<?php
header("Cache-Control: no-cache, no-store, must-revalidate"); // HTTP 1.1.
header("Pragma: no-cache"); // HTTP 1.0.
header("Expires: 0"); // Proxies.

include("db.inc.php");

$sensors = [];
$before = time(); // now
$after = $before - 24*60*60; // last 24 hours
$split = 1*60*60;
$gps = false;

if (!empty($_GET['sensors'])){
	$sensors = explode(",", $_GET['sensors']);
}
if (!empty($_GET['before'])){
	$before = intval($_GET['before']);
}
if (!empty($_GET['after'])){
	$after = intval($_GET['after']);
}
if (!empty($_GET['split'])){
	$split = intval($_GET['split']);
}
if (!empty($_GET['gps'])){
	$gps = true;
}

$data = [];
$db = new DB;
if ($db->connect() === FALSE) {
	$data["error"] = "Connecting to database";
} else {
	$sql = "SELECT COUNT(*) as `sum`";

	$subAfter = $after;
	$subBefore = $after + $split;
	$i = 0;
	while ($subAfter < $before){
		$sql .= ", COUNT(CASE WHEN `timestamp` >= $subAfter ";
		$sql .= "AND `timestamp` < $subBefore THEN 1 ELSE NULL END) AS `$i`";
		$subAfter += $split;
		$subBefore += $split;
		$i++;
	}
	$sql .= " FROM `data` WHERE";
	$sql .= " `timestamp` >= $after AND `timestamp` < $before";
	if ($gps){
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

	//echo $sql;
	$result = $db->query($sql);
	$db->close();
	if ($result === FALSE) {
		$data["error"] = "Querying database";
	} else {
		if ($row = $result->fetch_assoc()) {
			$data = $row;
		}
		$result->close();
	}
}

header('Content-Type: application/json; charset=UTF-8');
echo json_encode($data);

?>
