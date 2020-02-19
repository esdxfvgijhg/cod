<?php
class DB {
	# database parameters
	var $dbHost="mysql";
	var $dbName="sensors";
	var $dbUser="root";
	var $dbPass="sensors/root";

	var $conn;

	function connect(){
		$this->conn = new mysqli($this->dbHost, $this->dbUser, $this->dbPass, $this->dbName);
		if ($this->conn->connect_error) {
			return FALSE; // $this->conn->connect_error;
		}
		$this->conn->set_charset('utf8');
	}
	function query($sql){
		$result = $this->conn->query($sql);
		if ($result === FALSE){
			return FALSE; // $this->conn->error;
		}
		return $result;
	}
	function close(){
		$this->conn->close();
	}
	function escape_str($str){
		return $this->conn->real_escape_string($str);
	}
}


//////test
/*
$db = new DB;
$db->connect();
$result = $db->query("SELECT * FROM `SensorNode` ");
if ($result !== FALSE && $result->num_rows > 0) {
	while($row = $result->fetch_assoc()) {
		echo $row['location'].":".$row['freq']."<br>";
	}
}else{
	echo "No result";
}
$db->close();
*/

?>
