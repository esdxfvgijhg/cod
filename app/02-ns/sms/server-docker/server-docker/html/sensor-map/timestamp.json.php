<?php
header("Cache-Control: no-cache, no-store, must-revalidate"); // HTTP 1.1.
header("Pragma: no-cache"); // HTTP 1.0.
header("Expires: 0"); // Proxies.

include("db.inc.php");

$sensors = [];

if (!empty($_GET['sensors'])){
	$sensors = explode(",", $_GET['sensors']);
}

$data = [];
$db = new DB;
if ($db->connect() === FALSE) {
	$data["error"] = "Connecting to database";
} else {
	$sql = "SELECT MIN(`timestamp`) AS `oldest`, MAX(`timestamp`) AS `lastest` FROM `data`";
	if (count($sensors) > 0){
		$sql .= " WHERE `sensor_id` IN (";
		for ($i=0; $i<count($sensors); $i++){
			if ($i > 0){ 
				$sql .= ",";
			}   
			$sql .= intval($sensors[$i]);
		}   
		$sql .= ")";
	}
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

header('Content-Type: application/json');
echo json_encode($data);

?>
