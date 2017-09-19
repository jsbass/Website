// ServiceNow Info Puller
var labsRef ="560ec8c34a3623260149ea9979e736a2";
var classroomRef = "560ec9344a36232601893503bc6721a8";
var xmlIncLoc = "https://ounew.service-now.com/incident_list.do?XML&sysparm_query=assignment_group="+labsRef+"^ORassignment_group="+classroomRef;
var xmlUserLoc = "https://ounew.service-now.com/user_list.do?XML&sys_id=";
var xmlBuildingLoc = "https://ounew.service-now.com/cmn_location.do?XML&sys_id=";
var xmlRoomLoc = "https://ounew.service-now.com/u_class_rooms.do?XML&sys_id=";

function getIncidents(query, callback){
    var xmlhttp = new XMLHttpRequest();
	var inc = [];
    xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            var xmlDoc = xmlhttp.responseXML;
			callback(xmlDoc.getElementsByTagName("incident"));
        }
    }
    xmlhttp.open("GET", xmlIncLoc+query, true);
	console.log("Getting incidents from xml file: "+xmlIncLoc+query);
    xmlhttp.withCredentials = true;
    xmlhttp.send();
}

function getUser(ref, callback){
	var xmlhttp = new XMLHttpRequest();
	var inc = [];
    xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            var xmlDoc = xmlhttp.responseXML;
			callback(xmlDoc[0]);
        }
    }
    xmlhttp.open("GET", xmlUserLoc+ref, true);
	console.log("Getting incidents from xml file: "+xmlUserLoc+ref);
    xmlhttp.withCredentials = true;
    xmlhttp.send();
}

function getLocation(ref, callback){
	
}

function getBuilding(ref, callback){
	var xmlhttp = new XMLHttpRequest();
	var inc = [];
    xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            var xmlDoc = xmlhttp.responseXML;
			callback(xmlDoc[0]);
        }
    }
    xmlhttp.open("GET", xmlBuildingLoc+ref, true);
	console.log("Getting incidents from xml file: "+xmlBuildingLoc+ref);
    xmlhttp.withCredentials = true;
    xmlhttp.send();
}

function getRoom(ref, callback) {
	var xmlhttp = new XMLHttpRequest();
	var inc = [];
    xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            var xmlDoc = xmlhttp.responseXML;
			callback(xmlDoc[0]);
        }
    }
    xmlhttp.open("GET", xmlRoomLoc+ref, true);
	console.log("Getting incidents from xml file: "+xmlRoomLoc+ref);
    xmlhttp.withCredentials = true;
    xmlhttp.send();
}