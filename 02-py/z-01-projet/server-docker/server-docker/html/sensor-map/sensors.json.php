<?php
header("Cache-Control: no-cache, no-store, must-revalidate"); // HTTP 1.1.
header("Pragma: no-cache"); // HTTP 1.0.
header("Expires: 0"); // Proxies.

include("db.inc.php");

$data = [];
$db = new DB;
if ($db->connect() === FALSE) {
	$data["error"] = "Connecting to database";
} else {
	$sql = "SELECT * FROM `sensor`";
	$result = $db->query($sql);
	$db->close();
	if ($result === FALSE) {
		$data["error"] = "Querying database";
	} else {
		$sensors = [];
		while ($row = $result->fetch_assoc()) {
			$sensors[] = $row;
		}
		$result->close();
		$data["sensors"] = $sensors;
	}
}

header('Content-Type: application/json');
echo json_encode($data);

?>
