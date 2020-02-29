<?php
$sensors = "";
$before = time();
$before += 3600 - $before%(3600);
$after = $before - (24*3600); // last 24 hours
$split = 0;
$merge = false;
$value = null;
$gps = false;
$tz = null;
$mini = false;

if (!empty($_GET['sensors'])){
	$sensors = $_GET['sensors'];
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
if (isset($_GET['merge'])){
	$merge = true;
}
if (!empty($_GET['value'])){
	$value = $_GET['value'];
}
if (isset($_GET['gps'])){
	$gps = true;
}
if (isset($_GET['tz'])){
	$tz = intval($_GET['tz']);
}
if (isset($_GET['mini'])){
	$mini = true;
}

$urlParams = "after=$after&before=$before";
if ($split > 0){
	$urlParams .= "&split=$split";
}
if ($merge){
	$urlParams .= "&merge";
}
if ($gps){
	$urlParams .= "&gps";
}
if ($sensors != ""){
	$urlParams .= "&sensors=$sensors";
}
if ($value !== null){
	$urlParams .= "&value=$value";
}

// HTML headers
echo '
<html>
<head>
<title>Sensor Chart</title>
<meta charset="utf-8">
<meta name="viewport" content="initial-scale=1.0, user-scalable=yes">
<link rel="stylesheet" type="text/css" href="style.css">
<script src="jquery-3.1.0.min.js"></script>
</head>
<body>
<div id="chartpanel">
';

if (!$mini) {
//////////// START - Control UI for Full version
	include("db.inc.php");
	$db = new DB;
	if ($db->connect() === FALSE) {
		// show error and exit
		die("Error - Cannot connect to database");
	}

	echo '
<form id="chartcontrol" action="" method="get">
<div class="left">
<label>Value: <select id="value" name="value" required>
';
	echo '<option value=""'
		.(is_null($value)?' checked':'').'>None</option>';
	// query database for value fields
	$sql = "SELECT * FROM `field-view`";
	$result = $db->query($sql);
	if ($result === FALSE) {
		// TODO: handle query error
	}
	// loop create options
	while ($row = $result->fetch_assoc()) {
		echo '<option value="'.$row["field"].'"'
			.((!is_null($value) && $value==$row["field"])?' selected':'')
			.'>'.$row["name"].' ('.$row["unit"].')</option>';
	}
	$result->close();

	echo '
</select></label>
<br><label>From: <input type="datetime-local" id="afterDT" required></label>
<br><label>To: <input type="datetime-local" id="beforeDT" required></label>
<br><label>Timezone: 
<select id="zone" name="tz">
';

	// make timezone selection UTC-12 to UTC+14
	for ($z=-12; $z<14; $z++){
		$zStr = $z;
		if ($z>=0){
			$zStr = "+$z";
		}
		if (!is_null($tz) && $z==$tz){
			echo "<option value=\"$z\" selected>UTC$zStr</option>";
		} else {
			echo "<option value=\"$z\">UTC$zStr</option>";
		}
	}

	echo '
</select></label>
<br><label>Average by: <select name="split">
<option value="0"'
.($split==0 ? ' selected' : '')
.'>None</option>
<option value="3600"'
.($split==3600 ? ' selected' : '')
.'>60 Minutes</option>
<option value="86400"'
.($split==86400 ? ' selected' : '')
.'>24 Hours</option>
</select></label>
</div>
<div class="mid">
<legend>Sensors:</legend><fieldset id="sensorlist">
';

	// convert selected sensors string to array
	$sensorAry = explode(",", $sensors);

	// query database for all sensors
	$allSensors = [];
	$sql = "SELECT `id`,`name` FROM `sensor`";
	$result = $db->query($sql);
	if ($result === FALSE){
		// TODO: handle query error
	}
	// loop make sensors checkboxes
	while ($row = $result->fetch_assoc()) {
		echo '<label><input type="checkbox" class="sensors" value="'
			.$row["id"].'"'
			.(in_array($row["id"], $sensorAry)?" checked":"")
			.'>'.$row["id"].'-'.$row["name"].'</label> ';
	}
	$result->close();

	echo '
</fieldset>
<label><input type="checkbox" name="merge"'
.($merge ? ' checked' : '')
.'>Average all sensors</label>
</div>
<div class="clear">
<br>
<input type="button" id="update" value="Update">
</div>
<input type="submit" id="dosubmit" class="hide">
<input type="hidden" id="after" name="after" value="'.$after.'">
<input type="hidden" id="before" name="before" value="'.$before.'">
<input type="hidden" id="sensors" name="sensors" value="'.$sensors.'">

</form>

<a href="#" id="toggleui">Show/Hide</a>
<script>
$("#chartcontrol").hide();
hideUI();

// round the offset to hours
var utcHour = Math.round((new Date()).getTimezoneOffset()/-60); // hours
var tzOffset = utcHour*60*60; // in seconds

// set datetime on the input
var afterIso=(new Date(('.$after.'+tzOffset)*1000)).toISOString();
var beforeIso=(new Date(('.$before.'+tzOffset)*1000)).toISOString();
$("#afterDT").val(afterIso.substr(0,19));
$("#beforeDT").val(beforeIso.substr(0,19));
'.(is_null($tz) ? '$("#zone").val(utcHour);' : '').'

// button click event
$("#update").click(function () {
	// timezone
	var tz = parseInt($("#zone").val());
	
	// after
	var afterStr = $("#afterDT").val();
	var aY = parseInt(afterStr.substr(0,4));
	var aM = parseInt(afterStr.substr(5,2))-1;
	var aD = parseInt(afterStr.substr(8,2));
	var aH = parseInt(afterStr.substr(11,2));
	var aN = parseInt(afterStr.substr(14,2));
	var afterTs = Date.UTC(aY,aM,aD,aH,aN,0)/1000 - tz*60*60;
	console.log(afterStr+"="+afterTs);
	$("#after").val(afterTs);

	// before
	var beforeStr = $("#beforeDT").val();
	var bY = parseInt(beforeStr.substr(0,4));
	var bM = parseInt(beforeStr.substr(5,2))-1;
	var bD = parseInt(beforeStr.substr(8,2));
	var bH = parseInt(beforeStr.substr(11,2));
	var bN = parseInt(beforeStr.substr(14,2));
	var beforeTs = Date.UTC(bY,bM,bD,bH,bN,0)/1000 - tz*60*60;
	$("#before").val(beforeTs);

	// sensors
	var sensorCount = 0;
	var sensorStr = "";
	$(".sensors:checked").each(function () {
		if (sensorCount>0) {
			sensorStr += ",";
		}
		sensorStr += $(this).val();
		sensorCount++;
	});
	$("#sensors").val(sensorStr);
	console.log("sensors="+sensorStr);

	// submit
	//$("#chartcontrol").submit();
	$("#dosubmit").trigger("click");
});

$("#toggleui").click(function(){
	if ($("#chartcontrol").is(":visible")){
		hideUI();
	} else {
		showUI();
	}
});

function showUI(){
    $("#chartcontrol").slideDown();
    $("#toggleui").html("&#8679;Hide&#8679;");
}

function hideUI(){
    $("#chartcontrol").slideUp();
    $("#toggleui").html("&#8681;Show&#8681;");
}

</script>
';
	////////////////// END - Control UI
}?>
<div id="error"></div>
</div>
<div id="loading" class="centerpage-outer"><div class="centerpage-inner"><iframe class="noframe center" src="loading.html" scrolling="no" width="50" height="50">Loading...</iframe></div></div>
<div id="chart"></div>

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawChart);
var data;
var chartTitle = "Please select value to display";
function drawChart(){
	var url = "val.json.php?<?php echo $urlParams; ?>";
	console.log(url);
	jqXhrDate = $.getJSON(url, function(result){
		$("#loading").hide();
		if ("error" in result){
			$("#error").html("Error: "+result["error"]);
		} else {
			if ("field" in result){
				var field = result["field"];
				chartTitle = field["name"]+" ("+field["unit"]+")";
			}
			var table = result["data"];
			var data = new google.visualization.DataTable();
			data.addColumn("datetime","Time");
<?php if (!$merge) { // no sensor merging ?>
			var sensors = result["sensor"];
			var dataRow = [null];
			for (var sid in sensors){
				data.addColumn("number",sid+":"+sensors[sid]);
				dataRow.push(null); // initialize space
			}
			for (var ts in table){
				if (table[ts].lenght < 1){
					continue;
				}
				dataRow.fill(null);
				var myDate = new Date(parseInt(ts)*1000);
				dataRow[0] = myDate;
				var rows = table[ts];
				for (var i=0; i<rows.length; i++){
					var row = rows[i];
	<?php if ($split > 0) { echo "
					if (row[\"#\"] == \"all\"){
						continue;
					}
	";} ?>
					var col = -1;
					var j = 0;
					for (var sid in sensors){
						if (sid === row["sensor_id"]){
							col = j;
							break;
						}
						j++
					}
					if (col<0){
						continue;
					}
					col += 1;
					if ("value" in row){
						dataRow[col] = parseFloat(row["value"]);
					} else {
						dataRow[col] = parseFloat(row["avg"]);
					}
				}
				data.addRow(dataRow);
			}
<?php } else { // with sensor merging ?>
			data.addColumn("number","Avg");
			data.addColumn("number","Min");
			data.addColumn("number","Max");
			for (var ts in table){
	<?php if ($split > 0) { echo "
				var rows = table[ts];
				var row = null;
				for (var i=0; i<rows.length; i++){
					if (rows[i][\"#\"] != \"all\"){
						row = rows[i];
						break;
					}
				}
	";} else { echo "
				if (table[ts].lenght < 1){
					continue;
				}
				var row = table[ts][0];
	";} ?>
				var myDate =new Date(parseInt(row["timestamp"])*1000);
				data.addRow([
					myDate, 
					parseFloat(row["avg"]), 
					parseFloat(row["min"]),
					parseFloat(row["max"])
				]);
			}
<?php } // end if merge ?>
			var dateFmt = new google.visualization.DateFormat({
<?php if ($tz !== null) { echo "
				timeZone: $tz,
";} ?>
				pattern: "yyyy/MM/dd - HH:mm:ss (Z)"
			});
			dateFmt.format(data,0);
			var options = {
<?php if ($mini) { echo "
				chartArea: { left:30, top:10, right:20, bottom:40 },
";} ?>
				hAxis: {
<?php if ($tz !== null) { echo "
					timeZone: $tz,
";} ?>
					format: 'HH:mm' 
				},
				pointSize: 5,
				legend: { position: 'bottom' },
				title: chartTitle,
				interpolateNulls: true
			};
			var chart = new google.visualization.LineChart(document.getElementById('chart'));
			chart.draw(data, options);
		}
	});
}
</script>
</body>
</html>
