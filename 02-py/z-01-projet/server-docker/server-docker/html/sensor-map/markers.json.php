<?php
header("Cache-Control: no-cache, no-store, must-revalidate"); // HTTP 1.1.
header("Pragma: no-cache"); // HTTP 1.0.
header("Expires: 0"); // Proxies.

include("db.inc.php");

$sensors = [];
$before = time(); // now
$after = $before - (24*60*60); // last 24 hours
$value = null;

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

$data = [];
$db = new DB;
if ($db->connect() === FALSE) {
	$data["error"] = "Connecting to database";
} else {

	$sql = "SELECT `timestamp`, `sensor_id`,";
	$sql .= " `sensor`.`name` AS `sensor_name`,";
	$sql .= " COUNT(*) AS `count`,";
	if ($value != null){
		$value = str_replace("`", "", $value); // Escape string!!!!
		$sql .= " AVG(`$value`) AS `avg`,";
		$sql .= " MIN(`$value`) AS `min`,";
		$sql .= " MAX(`$value`) AS `max`,";
	}
	$sql .= " AVG(NULLIF(`gps_lat`,0)) AS `gps_lat`,";
	$sql .= " AVG(NULLIF(`gps_lng`,0)) AS `gps_lng`,";
	$sql .= "(SELECT `di`.`gps_lat` FROM `data` AS `di`";
	$sql .= " WHERE `di`.`sensor_id`=`dd`.`sensor_id` AND `di`.`gps_lat`";
	$sql .= " AND `di`.`timestamp` < $before";
	$sql .= " ORDER BY `di`.`timestamp` DESC LIMIT 1";
	$sql .= ") AS `last_gps_lat`,";
	$sql .= "(SELECT `dj`.`gps_lng` FROM `data` AS `dj`";
	$sql .= " WHERE `dj`.`sensor_id`=`dd`.`sensor_id` AND `dj`.`gps_lng`";
	$sql .= " AND `dj`.`timestamp` < $before";
	$sql .= " ORDER BY `dj`.`timestamp` DESC LIMIT 1";
	$sql .= ") AS `last_gps_lng`";
	$sql .= " FROM `data` AS `dd`";
	$sql .= " INNER JOIN `sensor` ON `sensor_id`=`sensor`.`id`";
	$sql .= " WHERE `timestamp` >= $after AND `timestamp` < $before";
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
	$sql .= " GROUP BY `sensor_id`";

	//echo $sql;
	$result = $db->query($sql);
	$db->close();
	if ($result === FALSE) {
		$data["error"] = "Querying database";
		$data["sql"] = $sql;
	} else {
		$table = [];
		while ($row = $result->fetch_assoc()) {
			$table[] = $row;
		}
		$result->close();
		$data["table"] = $table;
	}
}

header('Content-Type: application/json; charset=UTF-8');
echo json_encode($data);

?>
