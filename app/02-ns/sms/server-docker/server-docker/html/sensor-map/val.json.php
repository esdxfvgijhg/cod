<?php
header("Cache-Control: no-cache, no-store, must-revalidate"); // HTTP 1.1.
header("Pragma: no-cache"); // HTTP 1.0.
header("Expires: 0"); // Proxies.

include("db.inc.php");

$sensors = [];
$before = time(); // now
$after = $before - (1*60*60); // last hour
$split = 0;
$value = null;
$gps = false;
$merge = false;

if (!empty($_GET['sensors'])){
	$sensors = explode(",", $_GET['sensors']);
}
if (!empty($_GET['before'])){
	$before = intval($_GET['before']);
}
if (!empty($_GET['after'])){
	$after = intval($_GET['after']);
}
if (!empty($_GET['value'])){
	$value = $_GET['value'];
}
if (isset($_GET['gps'])){
	$gps = true;
}
if (!empty($_GET['split'])){
	$split = intval($_GET['split']);
}
if (isset($_GET['merge'])){
	$merge = true;
}


$data = [];
$db = new DB;
if ($db->connect() === FALSE) {
	$data["error"] = "Connecting to database";
} else {
	$sql = "";
	$selSet = "all";
	$subAfter = $after;
	$subBefore = $after + $split;
	while ($selSet === "all" || ($split>0 && $subAfter < $before)){
		if (strlen($sql)>0){
			$sql .= " UNION ALL ";
		}
		$sql .= "(SELECT \"$selSet\" AS `#`";
		if (!$merge){
			$sql .= ", `sensor_id`";
		}
		if ($split > 0){
			$sql .= ", \"$subAfter\" AS `timestamp`, COUNT(*) as `count`";
		} else {
			$sql .= ", `timestamp`";
			if ($merge){
				$sql .= ", COUNT(*) as `count`";
			}
		}
		if ($gps){
			if ($split > 0 || $merge){
				$sql .= ", AVG(`gps_lat`) AS `gps_lat`";
				$sql .= ", AVG(`gps_lng`) AS `gps_lng`";
				$sql .= ", AVG(`gps_alt`) AS `gps_alt`";
			} else {
				$sql .= ", `gps_lat`, `gps_lng`, `gps_alt`";
			}
		}
		if ($value != null){
			$value = str_replace("`", "", $value); // Escape string!!!!
			if ($split > 0 || $merge){
				$sql .= ", AVG(`".$value."`) AS `avg`";
				$sql .= ", MIN(`".$value."`) AS `min`";
				$sql .= ", MAX(`".$value."`) AS `max`";
			} else {
				$sql .= ", `".$value."` AS `value`";
			}
		}
		$sql .= " FROM `data`";
		if ($selSet === "all"){
			$sql .= " WHERE `timestamp` >= $after AND `timestamp` < $before";
		} else {
			$sql .= " WHERE `timestamp`>=$subAfter AND `timestamp`<$subBefore";
		}
		if ($gps) {
			$sql .= " AND `gps_lat`!=0";
		}
		if (count($sensors) > 0){
			$sql .= " AND `sensor_id` IN (";
			for ($i=0; $i<count($sensors); $i++){
				if ($i > 0){
					$sql .= ",";
				}
				$sql .= intval($sensors[$i]);
			}
			$sql .= ")";
		}
		if ($split > 0 && !$merge){
			$sql .= " GROUP BY `sensor_id`";
		} else if ($split == 0 && $merge){
			$sql .= " GROUP BY `timestamp`";
		}
		$sql .= " ORDER BY `timestamp` ASC";
		$sql .= " )";
		if ($selSet === "all"){
			$selSet = 0;
		} else {
			$subAfter += $split;
			$subBefore += $split;
			$selSet++;
		}
	}

	//echo $sql;
	$result = $db->query($sql);
	if ($result === FALSE) {
		$data["error"] = "Querying database";
	} else {
		$table = [];
		while ($row = $result->fetch_assoc()) {
			if (!isset($table[$row["timestamp"]])){
				$table[$row["timestamp"]] = [];
			}
			$table[$row["timestamp"]][] = $row;
			
			if (!$merge && !in_array($row["sensor_id"], $sensors)){
				$sensors[] = $row["sensor_id"];
			}
		}
		$result->close();
		$data["data"] = $table;
	}

	if ($value !== null){
		$value = $db->escape_str($value);
		$sql = "SELECT * FROM `field-view` WHERE `field`=\"$value\"";

		//echo $sql;
		$result = $db->query($sql);
		if ($result === FALSE) {
			$data["error"] = "Querying database";
		} else {
			if ($row = $result->fetch_assoc()) {
				$data["field"] = $row;
			}
			$result->close();
		}
	}

	if (!$merge && count($sensors) > 0){
		$sql = "SELECT `id`,`name` FROM `sensor` WHERE `id` IN (";
		for ($i=0; $i<count($sensors); $i++){
			if ($i > 0){
				$sql .= ",";
			}
			$sql .= intval($sensors[$i]);
		}
		$sql .= ") ORDER BY `id`";
		
		//echo $sql;
		$result = $db->query($sql);
		if ($result === FALSE) {
			$data["error"] = "Querying database";
		} else {
			$table = [];
			while ($row = $result->fetch_assoc()) {
				$table[$row["id"]] = $row["name"];
			}
			$result->close();
			$data["sensor"] = $table;
		}
	}
	$db->close();
}

header('Content-Type: application/json; charset=UTF-8');
echo json_encode($data);

?>
