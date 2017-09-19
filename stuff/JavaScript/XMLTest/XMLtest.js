var new_inc_count = [];
var active_inc_count = [];
var resolved_inc_count = [];
var incs = [];
var urgents = [];
var fac_assists = [];

function updateIncidents(){
	getIncidents("^active=true^short_description>~", function (inc) {
		var table = "";
		for(var i=0; i<inc.length; i++){
			table += "<tr><td>"+inc[i].getElementsByTagName("opened_at")+"</td>"+
				"<td>"+inc[i].getElementsByTagName("number")+"</td>"+
				"<td>"+inc[i].getElementsByTagName("building")+"</td>";
		document.getElementById("incidents").getChildren()[1].innerHtml = "";

function updateLabStats(){
	getIncidents("^active=true^incident_state=1", function (inc) {
		new_inc = inc;
		document.getElementById("new_count").innerHTML = new_inc.length;
	});
// States: 1=New, 2=Active, 3=Awaiting Problem, 4=Awaiting Parts/User Info, 5=Awaiting Evidence, 6=Resolved, 7=Closed, 8=Closed - Self Service Action
getIncidents("^active=true^incident_state=2", function (inc) {
		active_inc_count = inc.length;
		document.getElementById("active_count").innerHTML = active_inc_count;
	});
getIncidents("^active=true^incident_state=6", function (inc) {
		resolved_inc_count = inc.length;
		document.getElementById("resolved_count").innerHTML = resolved_inc_count;
	});
}