var map;
var geocoder;
var initPosition = true;
var gcWorkNo = 0;
var geoPopup = {};
var dataPopup = {};
var dataMarker = {};
var dataField = {};
var loading = 0
var jqXhrCount = null;
var jqXhrDate = null;
var jqXhrData = null;
var jqXhrField = null;
var jqXhrSensor = null;
var jqXhrUp = null;
var lastUpdate = 0;
var errorCount = 0;
$(document).ready(function(){
	initMap();
	initPanel();
	setInterval(function(){checkUpdate(true)}, 15000);
});

function showUI(){
	$("#control").slideDown();
	$("#toggleui").html("&#8679;Hide&#8679;");
}

function hideUI(){
	$("#control").slideUp();
	$("#toggleui").html("&#8681;Show&#8681;");
}

function incLoading() {
	loading++;
	$("#loading").show();
	//console.log("loading="+loading);
}

function decLoading() {
	loading--;
	if (loading==0){
		$("#loading").hide();
	}
	//console.log("loading="+loading);
}

function showError(errmsg) {
	var eId = errorCount;
	$("#errors").append(
			"<span id=\"err"+eId+"\" class=\"error\">"+errmsg+"<br></span>");
	console.log("#err"+eId+":"+errmsg);
	setTimeout(function(){
			$("#err"+eId).remove();
		}, 10000);
	errorCount++;
}

function initPanel() {
	// Fill hours
	for (var h=0; h<24; h++){
		$("#hour").append(
				"<option id=\"h"+h+"\" value=\""+h+"\">"+h+"</option>");
	}
	// Fill timezones
	for (var z=-12; z<0; z++){
		$("#zone").append(
				"<option id=\"z"+z+"\" value=\""+z+"\">"+z+"</option>");
	}
	for (var z=0; z<=14; z++){
		$("#zone").append(
				"<option id=\"z+"+z+"\" value=\""+z+"\">+"+z+"</option>");
	}

	fillValues();
	fillSensors();


	// Assign default values
	$("#autodate").prop("checked",true);
	setNow();
	showUI();

	// Event callbacks
	$("#toggleui").click(function(){
		if ($("#control").is(':visible')){
			hideUI();
		} else {
			showUI();
		}
	});
	$("#date").change(function (){
		$("#autodate").prop("checked",false);
		updateChartLink();
		updateCount(false);
		updateData(false);
	});
	$("#hour").change(function (){
		$("#autodate").prop("checked",false);
		updateChartLink();
		updateData(false);
	});
	$("#zone").change(function (){
		$("#autodate").prop("checked",false);
		updateChartLink();
		updateDate(false);
		updateCount(false);
		updateData(false);
	})
	$("#autodate").click(function (){
		if ($("#autodate").prop("checked")){
			setNow();
		}
		updateChartLink();
		updateDate(false);
		updateCount(false);
		updateData(false);
	});
	$("#value").change(function (){
		updateChartLink();
		updateData(false);
	});
	$("#btnToGps").click(centerGeoPos);
	$("#btnToData").click(fitDataPos);
	$("#txtAddress").on('keyup', function (e) {
		if (e.keyCode == 13) {
			var address = $("#txtAddress").val();
			if (address != ""){
				goTo(address);
			}
		}
	});
	
	// Load latest data
	checkUpdate(false);
}

function fillValues(){
	// Fill fields
	var url = "field.json.php";
	console.log("START: "+url);
	incLoading();
	jqXhrField = $.getJSON(url, function(result){
		if ("error" in result){
			showError("Error: "+result["error"]);
		}
		if ("fields" in result){
			var fields = result["fields"];
			for (var i=0; i<fields.length; i++){
				dataField[fields[i]["field"]]=fields[i];
				$("#value").append(
						"<option value="+fields[i]["field"]+">"
						+fields[i]["name"]+" ("
						+fields[i]["unit"]+")</option>");
			}
			$("#value").val("pm2.5");
			updateData(false);
		}
	}).always(function() {
		console.log("END: "+url);
		jqXhrField = null;
		decLoading();
	});
}

function fillSensors() {
	// Get available sensors
	var url = "sensors.json.php";
	console.log("START: "+url);
	incLoading();
	jqXhrSensor = $.getJSON(url, function(result){
		if ("error" in result){
			showError("Error: "+result["error"]);
		}
			console.log("iOK");
		if ("sensors" in result){
			console.log("OK");
			var sensors = result["sensors"];
			for (var i=0; i<sensors.length; i++){
				var si = sensors[i]["id"];
				var sn = sensors[i]["name"];
				$("#sensorlist").append("<label><input type=\"checkbox\""
						+" class=\"sensors\" value=\""+si+"\">"+si+"-"+sn
						+"</label><br>");
			}
		}
		$("input.sensors").click(function() {
			doUpdate(false);
		});
	}).always(function() {
		console.log("END: "+url);
		jqXhrSensor = null;
		decLoading();
	});
}

function resetDate(){
	$("#date").removeAttr("min");
	$("#date").removeAttr("max");
}

function resetCount(){
	$("#hx").html("All-day");
	for (var h=0; h<24; h++){
		$("#h"+h).html(h);
		$("#h"+h).prop("disabled",false);
	}
}

function resetData(){
	// Clear all markers
	for (key in dataMarker){
		hideMarker(dataMarker[key]);
	}
	//for (key in dataPopup){
	//	hidePopup(dataPopup[key]);
	//}
}

function setNow(){
	var nowDate = new Date();
	var tzOffset = nowDate.getTimezoneOffset();
	$("#date").val((
				new Date(nowDate.getTime()-tzOffset*60000))
				.toISOString().substr(0,10));
	$("#hour").val(nowDate.getHours());
	$("#zone").val(-tzOffset/60);
}

function checkUpdate(bg){
	if (jqXhrUp != null){
		if (bg){
			// background wont start if request is running
			return; 
		} else {
			// cancel the running request
			jqXhrUp.abort();
		}
	}

	// Get available dates and set limit
	var url = "last.json.php";
	console.log("START: "+url);
	incLoading();
	jqXhrUp = $.getJSON(url, function(result){
		if ("error" in result){
			showError("Error: "+result["error"]);
		}
		if ("last" in result){
			var last = parseInt(result["last"]);
			if (lastUpdate < last
					|| lastUpdate > (new Date().getTime())/1000){
				doUpdate(bg);
				lastUpdate = last;
			}
		}
	}).always(function() {
		console.log("END: "+url);
		jqXhrUp = null;
		decLoading();
	});
}

function doUpdate(bg){
	if ($("#autodate").prop("checked")){
		setNow();
	}
	updateChartLink();
	updateDate(bg);
	updateCount(bg);
	updateData(bg);
}

function updateChartLink() {
	var params = {}
	params["after"] = getSelectedDateTs(true);
	params["before"] = params["after"] + 24*60*60;
	params["split"] = 60*60;
	params["tz"] = $("#zone").val();
	params["value"] = $("#value").val();
	params["sensors"] = getSelectedSensors();

	var chartUrl = "chart.php?"+$.param(params);
	$("#lnkChart").attr("href", chartUrl);
}

function updateDate(bg) {
	if (jqXhrDate != null){
		if (bg){
			// background wont start if request is running
			return; 
		} else {
			// cancel the running request
			jqXhrDate.abort();
		}
	}

	// reset ui if not a background update
	if (!bg) {
		resetDate();
	}

	// Get available dates and set limit
	var params = {};
	params["sensors"] = getSelectedSensors();
	var url = "timestamp.json.php?"+$.param(params);
	console.log("START: "+url);
	incLoading();
	jqXhrDate = $.getJSON(url, function(result){
		if ("error" in result){
			showError("Error: "+result["error"]);
		}
		if (result["oldest"]!=null){
			var minDate = new Date(parseInt(result["oldest"])*1000);
			$("#date").attr("min",minDate.toISOString().substr(0,10));
		}
		if (result["lastest"]!=null){
			var maxDate = new Date(parseInt(result["lastest"])*1000);
			$("#date").attr("max",maxDate.toISOString().substr(0,10));
		}
	}).always(function() {
		console.log("END: "+url);
		jqXhrDate = null;
		decLoading();
	});
}

function updateCount(bg) {
	if (jqXhrCount != null){
		if (bg){
			// background wont start if request is running
			return; 
		}else {
			// cancel the running request
			jqXhrCount.abort();
		}
	}

	var selTs = getSelectedDateTs(true);
	if (isNaN(selTs)){
		resetCount();
		showError("Invalid date/time.");
		return;
	}

	// reset ui if not a background update
	if (!bg) {
		resetCount();
	}

	// Query and show
	var params = {};
	params["after"] = selTs;
	params["before"] = selTs + 24*60*60;
	params["sensors"] = getSelectedSensors();

	var url = "countdata.json.php?"+$.param(params);
	console.log("START: "+url);
	incLoading();
	jqXhrCount = $.getJSON(url, function(result){
		if ("error" in result){
			showError("Error: "+result["error"]);
		}
		if (bg) {
			resetCount();
		}
		$("#hx").html("All-day ("+parseInt(result["sum"])+")");// All-day
		for (var h=0; h<24; h++){
			var count = parseInt(result[h]);
			$("#h"+h).html(h+" ("+count+")");
			if (count==0){
				$("#h"+h).prop("disabled",true);
			}
		}
	}).always(function() {
		console.log("END: "+url);
		jqXhrCount = null;
		decLoading();
	});
}

function updateData(bg) {
	if (jqXhrData != null){
		if (bg){
			// background wont start if request is running
			return; 
		}else {
			// cancel the running request
			jqXhrData.abort();
		}
	}

	// preparing parameters
	var value = $("#value").val();
	if (value === null){
		console.log("No value selected");
		return;
	}
	var valName = dataField[value]["name"];
	var valUnit = dataField[value]["unit"];
	var valMin = parseFloat(dataField[value]["minimum"]);
	var valMid = parseFloat(dataField[value]["threshold"]);
	var valMax = parseFloat(dataField[value]["maximum"]);
	if (isNaN(valMid)){
		valMid = (valMin+valMax)/2;
	}

	var params = {};
	if ($("#autodate").prop("checked")){ 
		var nowTs = parseInt(Date.now()/1000);
		nowTs += 60 - nowTs%60;
		params["before"] = nowTs;
		params["after"] = nowTs - 60*60;
	} else {
		var selTs = getSelectedDateTs(false);
		if (isNaN(selTs)){
			resetData();
			showError("Invalid date/time.");
			return;
		}
		params["after"] = selTs;
		params["before"] = selTs + 24*60*60;
		var hourStr = $("#hour").val();
		if (hourStr!=""){
			params["before"] = params["after"] + 1*60*60;
		}
	}
	params["value"] = value;
	params["sensors"] = getSelectedSensors();

	var tz = $("#zone").val();
	var url = "markers.json.php?"+$.param(params);
	
	// reset ui if not a background update
	if (!bg) {
		resetData();
	}

	// Query and show
	console.log("START: "+url);
	incLoading()
	jqXhrData = $.getJSON(url, function(result){
		if ("error" in result){
			showError("Error: "+result["error"]);
		}
		var activeMarker = [];
		var table = result["table"];
		console.log("# Count: "+table.length);
		for (var i=0; i<table.length; i++){
			var resultSensorId = table[i]["sensor_id"];
			var resultPos = {
				lat: parseFloat(table[i]["gps_lat"]),
				lng: parseFloat(table[i]["gps_lng"])
			};
			var oldGps = false;
			if (isNaN(resultPos.lat) || isNaN(resultPos.lng)){
				resultPos.lat = parseFloat(table[i]["last_gps_lat"]);
				resultPos.lng = parseFloat(table[i]["last_gps_lng"]);
				oldGps = true;
			}
			if (isNaN(resultPos.lat) || isNaN(resultPos.lng)){
				continue;
			}
			var chartUrl = "chart.php?"
				+"after="+params["after"]+"&before="+params["before"]
				+"&value="+params["value"]
				+"&sensors="+resultSensorId
				+"&tz="+tz;
			if (hourStr == ""){
				chartUrl += "&split=3600&merge";
			}
			var aDate = new Date((params["after"]+tz*3600)*1000);
			var bDate = new Date((params["before"]+tz*3600-1)*1000);
			var aStr = aDate.toISOString().substr(0,16);
			var bStr = bDate.toISOString().substr(0,16);
			aStr = aStr.replace(/-/g,"/").replace("T"," ");
			bStr = bStr.replace(/-/g,"/").replace("T"," ");
			if (aStr.substr(0,10) == bStr.substr(0,10)){
				bStr = bStr.substr(11);
			}
			tzStr = tz.toString();
			if (tz >= 0){
				tzStr = "+"+tzStr;
			}
			var resultTxt = "<strong>Sensor: "+resultSensorId
				+" - "+table[i]["sensor_name"]+"</strong>"
				+"<br>Time: "+aStr+" - "+bStr+" (UTC"+tzStr+")"
				+"<br>"+valName+" - "+valUnit
				+" ("+table[i]["count"]+" samples)"
				+"<br>Avg: "
				+(parseFloat(table[i]["avg"])).toFixed(2)
				+" / Max: "
				+(parseFloat(table[i]["max"])).toFixed(2)
				+" / Min: "
				+(parseFloat(table[i]["min"])).toFixed(2)
				+"<br><iframe src=\""+chartUrl+"&mini\""
				+" scrolling=\"no\" class=\"noframe chart\"></iframe>"
				+"<br><a target=\"_blank\" href=\""+chartUrl+"\">"
				+"Open in new tab<img src=\"newtab.png\" class=\"inline\">"
				+"</a>";
			var resultVal = parseFloat(table[i]["avg"]);
			
			var color = getColorRYG(resultVal, valMax, valMid, valMin);
			var marker = dataMarker[resultSensorId];
			var stroke = "black";
			if (oldGps){
				stroke = "gray";
			}
			marker = showMarker(marker, color, stroke, resultPos);
			var popup = dataPopup[resultSensorId];
			if (popup != null && popup.getMap() != null){
				popup = showPopupOnMarker(popup, resultTxt, marker);
			}
			google.maps.event.clearListeners(marker, 'click');
			google.maps.event.addListener(marker,"click",
					(function(marker,resultSensorId,resultTxt){
						return function() {
							var myPopup = dataPopup[resultSensorId];
							myPopup = showPopupOnMarker(
									 myPopup, resultTxt, marker);
							dataPopup[resultSensorId] = myPopup;
						};
					})(marker,resultSensorId,resultTxt));
			dataMarker[resultSensorId] = marker;
			activeMarker.push(resultSensorId);
		}
		if (bg){
			for (var sid in dataMarker){
				// hide markers that are not active
				if (activeMarker.indexOf(sid) == -1){
					hideMarker(dataMarker[sid]);
				}
			}
		}
	}).always(function() {
		console.log("END: "+url);
		jqXhrData = null;
		decLoading();
	});
}

function getSelectedDateTs(forceAllDay){
	if ($("#autodate").prop("checked")){ 
		var nowDate = new Date();
		var selY = nowDate.getFullYear();
		var selM = nowDate.getMonth();
		var selD = nowDate.getDate();
		var selH = nowDate.getHours();
		if (forceAllDay) {
			selH = 0;
		}
		var ts = (new Date(selY,selM,selD,selH,0,0,0)).getTime()/1000;
	} else {
		// Get selected date
		var dateStr = $("#date").val();
		var selY = parseInt(dateStr.substr(0,4));
		var selM = parseInt(dateStr.substr(5,2))-1;
		var selD = parseInt(dateStr.substr(8,2));
		var hourStr = $("#hour").val();
		var selH = 0;
		if (!forceAllDay && hourStr!=""){
			selH = parseInt(hourStr);
		}
		var selZ = parseInt($("#zone").val());
		var ts = Date.UTC(selY,selM,selD,selH,0,0,0)/1000 - selZ*60*60;
		console.log("# Selected date:"+selY+"-"+(selM+1)+"-"+selD+", hour:"+selH+", zone:"+selZ+" => timestamp:"+ts);
	}
	return ts;
}

function getSelectedSensors() {
	var sensorStr = "";
	var sensorCount = 0;
	$(".sensors:checked").each(function () {
		if (sensorCount>0) {
			sensorStr += ",";
		}
		sensorStr += $(this).val();
		sensorCount++;
	});
	console.log("sensors="+sensorStr);
	return sensorStr;
}

function initMap() {
	geocoder = new google.maps.Geocoder();
	map = new google.maps.Map($("#map").get(0), {
		center: {lat: 48.86, lng: 2.35},
		zoom: 13,
		streetViewControl: false
	});

	centerGeoPos();
}

function goTo(address) {
	incLoading();
	gcWorkNo++;
	var requestNo = gcWorkNo;
	console.log("START: goto "+address);
	geocoder.geocode({'address':address}, function(results, gcStatus) {
		if (requestNo != gcWorkNo) {
			return;
		}
		if (gcStatus == google.maps.GeocoderStatus.OK) {
			var pos = results[0].geometry.location;
			geoPopup[address] = showPopup(geoPopup[address], address, pos);
			map.setCenter(pos);
			if (results[0].geometry.viewport){
				map.fitBounds(results[0].geometry.viewport);
			}
		} else {
			showError("Geocode error: " + gcStatus);
		}
		console.log("END: goto "+address);
		decLoading();
	});
}

function centerDefault(){
	var neNew = new google.maps.LatLng( -40, 0 );
	var swNew = new google.maps.LatLng( 70, 0 );
	var boundsNew = new google.maps.LatLngBounds( swNew, neNew );
	map.fitBounds(boundsNew);
}

function fitDataPos(){
	var bounds = new google.maps.LatLngBounds();
	for (key in dataMarker){
		if (dataMarker[key].getMap() == null){
			continue;
		}
		bounds.extend(dataMarker[key].getPosition());
	}
	if (bounds.isEmpty()){
		return;
	}
	var zoom = map.getZoom();
	map.fitBounds(bounds);
	if (map.getZoom() > zoom) {
		map.setZoom(zoom);
	}
}

function centerGeoPos(){
	if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(showGeoPos, showGeoError);
	} else {
		showError("Geolocation is not supported by this browser.");
		if (initPosition){
			centerDefault();
		}
		initPosition = false;
	}
}

function showGeoPos(position) {
	var pos = {
		lat: position.coords.latitude,
		lng: position.coords.longitude
	};
	geoPopup["geolocation"] = showPopup(geoPopup["geolocation"]
			, "Location found.", pos);
	map.setCenter(pos);
	map.setZoom(13);
	initPosition = false;
}

function showGeoError(error) {
	var errMsg;
	switch(error.code) {
		case error.PERMISSION_DENIED:
			errMsg="User denied the request for Geolocation.";
				break;
		case error.POSITION_UNAVAILABLE:
			errMsg="Location information is unavailable.";
				break;
		case error.TIMEOUT:
			errMsg="The request to get user location timed out.";
				break;
		case error.UNKNOWN_ERROR:
			errMsg="An unknown error occurred.";
				break;
	}
	showError("Geolocation: "+errMsg);
	if (initPosition){
		centerDefault();
	}
	initPosition = false;
}

function showPopupOnMarker(infoWindow, content, marker) {
	if (infoWindow == null) {
		var options = {
			disableAutoPan: true
		};
		infoWindow = new google.maps.InfoWindow(options);
	}
	if (infoWindow.getContent() != content){
		infoWindow.setContent(content);
	}
	if (infoWindow.getMap() != map){
		infoWindow.open(map, marker);
	}
	return infoWindow;
}

function showPopup(infoWindow, content, pos) {
	if (infoWindow == null) {
		var options = {
			disableAutoPan: true
		};
		infoWindow = new google.maps.InfoWindow(options);
	}
	infoWindow.setPosition(pos);
	if (infoWindow.getContent() != content){
		infoWindow.setContent(content);
	}
	if (infoWindow.getMap() != map){
		infoWindow.open(map);
	}
	return infoWindow;
}

function hidePopup(infoWindow) {
	if (infoWindow != null) {
		infoWindow.close();
	}
	return infoWindow;
}

function showMarker(marker, color, stroke, pos) {
	if (marker == null) {
		var options = {
			icon: {
				path: google.maps.SymbolPath.CIRCLE,
				scale: 10,
				fillOpacity: 1,
				strokeWeight: 3
			}
		};
		marker = new google.maps.Marker(options);
	}
	marker.setPosition(pos);
	var icon = marker.getIcon();
	icon.fillColor = color;
	icon.strokeColor = stroke;
	marker.setIcon(icon);
	if (marker.getMap() != map){
		marker.setMap(map);
	}
	return marker;
}

function hideMarker(marker) {
	if (marker != null) {
		marker.setMap(null);
	}
	return marker;
}

function getColorRYG(val,r,y,g){
	lr = getLevel(val,g,y);
	lg = getLevel(val,r,y);
	return "rgb("+lr+","+lg+",0)";
}

function getLevel(val,l,h) {
	var v;
	if (h > l) {
		v = (val-l)*255/(h-l);
	} else {
		v = (l-val)*255/(l-h);
	}
	if (v < 0) {
		v = 0;
	} else if (v > 255) {
		v = 255;
	} else {
		v = Math.round(v);
	}
	return v;
}
