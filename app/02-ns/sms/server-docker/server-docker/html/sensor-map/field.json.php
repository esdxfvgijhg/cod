<?php
header("Cache-Control: no-cache, no-store, must-revalidate"); // HTTP 1.1.
header("Pragma: no-cache"); // HTTP 1.0.
header("Expires: 0"); // Proxies.

$value = null;
if (!empty($_GET["value"])){
	$value = $_GET["value"];
}

include("db.inc.php");
$data = [];
$db = new DB;
if ($db->connect() === FALSE) {
	$data["error"] = "Connecting to database";
} else {
	$sql = "SELECT * FROM `field-view`";
	if ($value !== null){
		$value = $db->escape_str($value);
		$sql .= "WHERE `field`=\"$value\"";
	}
	$result = $db->query($sql);
	$db->close();
	if ($result === FALSE) {
		$data["error"] = "Querying database";
	} else {
		$table = [];
		while ($row = $result->fetch_assoc()) {
			$table[] = $row;
		}
		$result->close();
		$data["fields"] = $table;
	}
}

header('Content-Type: application/json; charset=UTF-8');
echo json_encode($data);

?>
