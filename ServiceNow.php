<?php
	/*
	 * TODO
	 * - Finish Column Labels
	 * - Finish Column Sorting Functionality
	 * - Finish Column Display Functionality
	 * - Add More Custom Columns For Quality of Use
	 */

	//Max rows shown in any table (May change to allow for variable row counts for each table)
	$MAX_ROW_COUNT = 10;
	//Base of SN Classroom Query URL
	$classURL = "https://ounew.service-now.com/u_class_rooms.do?JSONv2&";
	//Base of SN Building Query URL
	$buildingURL = "https://ounew.service-now.com/cmn_location.do?JSONv2&";
	//Reference # for LS Classrooms Assignment Group
	$classroomsRef = "560ec8c34a3623260149ea9979e736a2";
	//Reference # for LS Labs Assignment Group
	$labsRef = "560ec9344a36232601893503bc6721a8";
	//Base of SN  Incidents Query URL
	//Has the LS Classrooms & Labs requirement built in
	$incidentURL = "https://ounew.service-now.com/incident_list.do?JSONv2&displayvalue=true&sysparm_query=assignment_group=".$classroomsRef."^ORassignment_group=".$labsRef;
	//Base of SN User Query URL
	$userURL = "https://ounew.service-now.com/sys_user.do?JSONv2&";
	//Dashboard SN login credentials
	$userPwd = "queuedisp:display2015";
	class Column {
		static $id_count = 0;
		function __construct($label = ""){
			$this->label = $label;
			$this->id = Column::$id_count++;
		}
	}
	//Functional Enum representing the different possible column header for the
	//    gerenated tables.
	//The value each Enum represents is the corresponging column header used
	//Most of these fields are from the service now incident fields
	//
	//CUST_ prefix means that it is not a service now incident field and
	//    is a custom column header
	abstract class IncFields {
        const ACTIVE = array('id' => 0, 'label' => "Activity Due");
        const ACTIVITY_DUE = array('id' => 1, 'label' => "Activity Due");
        const APPROVAL = array('id' => 2, 'label' => "Approval");
        const APPROVAL_HISTORY = array('id' => 3, 'label' => "Approval History");
        const APPROVAL_SET = array('id' => 4, 'label' => "Activity Due");
        const ASSIGNED_TO_SHORT = array('id' => 5, 'label' => "Assigned To");
		const ASSIGNED_TO_FULL = array('id' => 6, 'label' => "Assigned To");
        const ASSIGNMENT_GROUP = array('id' => 7, 'label' => "Assignment Group");
        const BUSINESS_DURATION = array('id' => 8, 'label' => "Activity Due");
        const BUSINESS_STS = array('id' => 9, 'label' => "Activity Due");
        const CALENDAR_DURATION = array('id' => 10, 'label' => "Activity Due");
        const CALENDAR_STC = array('id' => 11, 'label' => "Activity Due");
        const CALLER_ID = array('id' => 12, 'label' => "Caller Id");
        const CATEGORY = array('id' => 13, 'label' => "Category");
        const CAUSED_BY = array('id' => 14, 'label' => "Activity Due");
        const CLOSE_NOTES = array('id' => 15, 'label' => "Activity Due");
        const CLOSED_AT = array('id' => 16, 'label' => "Activity Due");
        const CLOSED_BY = array('id' => 17, 'label' => "Activity Due");
        const CMDB_CI = array('id' => 18, 'label' => "Activity Due");
        const COMMENTS = array('id' => 19, 'label' => "Comments");
        const COMPANY = array('id' => 20, 'label' => "Activity Due");
        const CONTACT_TYPE = array('id' => 21, 'label' => "Activity Due");
        const CORRELATION_DISPLAY = array('id' => 22, 'label' => "Activity Due");
        const CORRELATION_ID = array('id' => 23, 'label' => "Activity Due");
        const DELIVERY_PLAN = array('id' => 24, 'label' => "Activity Due");
        const DESCRIPTION = array('id' => 25, 'label' => "Description");
        const DUE_DATE = array('id' => 26, 'label' => "Activity Due");
        const ESCALATION = array('id' => 27, 'label' => "Activity Due");
        const EXPECTED_START = array('id' => 28, 'label' => "Activity Due");
        const FOLLOW_UP = array('id' => 29, 'label' => "Activity Due");
        const GROUP_LIST = array('id' => 30, 'label' => "Activity Due");
        const IMPACT = array('id' => 31, 'label' => "Activity Due");
        const INCIDENT_STATE = array('id' => 32, 'label' => "Incident State");
        const KNOWLEDGE = array('id' => 33, 'label' => "Activity Due");
        const LOCATION = array('id' => 34, 'label' => "Location");
        const MADE_SLA = array('id' => 35, 'label' => "Activity Due");
        const NOTIFY = array('id' => 36, 'label' => "Activity Due");
        const NUMBER = array('id' => 37, 'label' => "Incident #");
        const OPENED_AT = array('id' => 38, 'label' => "Activity Due");
        const OPENED_BY = array('id' => 39, 'label' => "Activity Due");
        const ORDER = array('id' => 40, 'label' => "Activity Due");
        const INC_PARENT = array('id' => 41, 'label' => "Activity Due");
        const PRIORITY = array('id' => 42, 'label' => "Activity Due");
        const PROBLEM_ID = array('id' => 43, 'label' => "Activity Due");
        const REASSIGNMENT_COUNT = array('id' => 44, 'label' => "Reassignment Count");
        const REJECTION_GOTO = array('id' => 45, 'label' => "Activity Due");
        const RFC = array('id' => 46, 'label' => "Activity Due");
        const SERVICE_OFFERING = array('id' => 47, 'label' => "Activity Due");
        const SEVERITY = array('id' => 48, 'label' => "Activity Due");
        const SHORT_DESCRIPTION = array('id' => 49, 'label' => "Activity Due");
        const SKILLS = array('id' => 50, 'label' => "Activity Due");
        const SLA_DUE = array('id' => 51, 'label' => "Activity Due");
        const STATE = array('id' => 52, 'label' => "State");
        const SUBCATEGORY = array('id' => 53, 'label' => "Subcategory");
        const SYS_CLASS_NAME = array('id' => 54, 'label' => "Activity Due");
        const SYS_CREATED_BY = array('id' => 55, 'label' => "Created By");
        const SYS_CREATED_ON = array('id' => 56, 'label' => "Created On");
        const SYS_DOMAIN = array('id' => 57, 'label' => "Activity Due");
        const SYS_ID = array('id' => 58, 'label' => "Sys Id");
        const SYS_MOD_COUNT = array('id' => 59, 'label' => "Activity Due");
        const SYS_UPDATED_BY = array('id' => 60, 'label' => "Activity Due");
        const SYS_UPDATE_ON = array('id' => 61, 'label' => "Activity Due");
        const TIME_WORKED = array('id' => 62, 'label' => "Activity Due");
        const U_ACTION = array('id' => 63, 'label' => "Activity Due");
        const U_AFFECTED_USER = array('id' => 64, 'label' => "Affected User");
        const U_BS = array('id' => 65, 'label' => "Activity Due");
        const U_BUILDING_FULL = array('id' => 66, 'label' => "Building");
		const U_BUILDING_SHORT = array('id' => 67, 'label' => "Building");
        const U_BUS_SERV = array('id' => 68, 'label' => "Activity Due");
        const U_BUSINESS_SERVICE = array('id' => 69, 'label' => "Activity Due");
        const U_CLASS_IN_SESSION = array('id' => 70, 'label' => "Class in Session");
        const U_CLASSROOM = array('id' => 71, 'label' => "Room");
        const U_CMDB_CI_SERVICES = array('id' => 72, 'label' => "Activity Due");
        const U_CUSTOMER_CONTACTED = array('id' => 73, 'label' => "Activity Due");
        const U_LEGACY_INCIDENT_NUMBER = array('id' => 74, 'label' => "Activity Due");
        const U_OFF = array('id' => 75, 'label' => "Activity Due");
        const U_OFFERING = array('id' => 76, 'label' => "Activity Due");
        const U_ORDER_STATUS = array('id' => 77, 'label' => "Activity Due");
        const U_ORIGIN = array('id' => 78, 'label' => "Activity Due");
        const U_PREFDAY = array('id' => 79, 'label' => "Activity Due");
        const U_PREFFERED_PHONE = array('id' => 80, 'label' => "Activity Due");
        const U_PRIVATE_COMMENTS = array('id' => 81, 'label' => "Private Comments");
        const U_PROJECT_CATEGORY = array('id' => 82, 'label' => "Activity Due");
        const U_REQUISITION_NUMBER = array('id' => 83, 'label' => "Activity Due");
        const U_RESOLVED_1ST_CONTACT = array('id' => 84, 'label' => "Activity Due");
        const U_RESOLVED_2ND_CONTACT = array('id' => 85, 'label' => "Activity Due");
        const U_RESOLVED_3RD_CONTACT = array('id' => 86, 'label' => "Activity Due");
        const U_RESOLVED_BY = array('id' => 87, 'label' => "Activity Due");
        const U_SAMEUSER = array('id' => 88, 'label' => "Activity Due");
        const U_SECONDARY_LOCATION = array('id' => 89, 'label' => "Activity Due");
        const U_SERVICE_OFFERING = array('id' => 90, 'label' => "Activity Due");
        const U_SOURCE = array('id' => 91, 'label' => "Activity Due");
        const U_VAPINFO = array('id' => 92, 'label' => "Activity Due");
        const U_WORK_NOTES = array('id' => 93, 'label' => "Activity Due");
        const UPON_APPROVAL = array('id' => 94, 'label' => "Activity Due");
        const UPON_REJECT = array('id' => 95, 'label' => "Activity Due");
        const URGENCY = array('id' => 96, 'label' => "Urgency");
        const USER_INPUT = array('id' => 97, 'label' => "Activity Due");
        const VARIABLES = array('id' => 98, 'label' => "Activity Due");
        const WATCH_LIST = array('id' => 99, 'label' => "Activity Due");
        const WF_ACTIVITY = array('id' => 100, 'label' => "Activity Due");
        const WORK_END = array('id' => 101, 'label' => "Activity Due");
        const WORK_START = array('id' => 102, 'label' => "Activity Due");
        const WORK_NOTES = array('id' => 103, 'label' => "Activity Due");
		// Building and Classroom together
		const CUST_LOC = array('id' => 104, 'label' => "Location");
		const CUST_SHORT_CREATED_ON = array('id' => 105, 'label' => "Created On");
    }
	
	abstract class SortDir{
		const ASC = 1;
		const DESC = -1;
	}
	
	function getClassroom($u_room){
		//Access the classroom query url and user credentials locally
		global $classURL,$userPwd;
		//make a curl request object and set parameters
		$ch = curl_init($classURL."sysparm_query=u_room=".urlencode($u_room));
		curl_setopt($ch, CURLOPT_HEADER, false);
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
		curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
		curl_setopt($ch, CURLOPT_USERPWD, $userPwd);
		curl_setopt($ch, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_0);
		//get query JSON results
		$json = curl_exec($ch);
		//check for http errors
		if(curl_errno($ch)){
			print_r('Curl error: '.curl_error($ch)."<br/>");
		}
		//release curl object
		curl_close($ch);
		//decode JSON text into JSON objects
		$data = json_decode($json);
		//return the first (and only) classroom object
		return $data->records[0];
	}
	
	function getBuilding($full_name){
		//Access the building query url and user credentials locally
		global $buildingURL,$userPwd;
		//make a curl request object and set parameters
		$ch = curl_init($buildingURL."sysparm_query=full_name=".urlencode($full_name));
		curl_setopt($ch, CURLOPT_HEADER, false);
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
		curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
		curl_setopt($ch, CURLOPT_USERPWD, $userPwd);
		curl_setopt($ch, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_0);
		//get query JSON results
		$json = curl_exec($ch);
		//check for http errors
		if(curl_errno($ch)){
			print_r('Curl error: '.curl_error($ch)."<br/>");
		}
		//release curl object
		curl_close($ch);
		//decode JSON text into JSON objects
		$data = json_decode($json);;
		//return the first (and only) building object
		return $data->records[0];
	}
	
	function getUser($fourByfour){
		//Access the building query url and user credentials locally
		global $userURL,$userPwd;
		//make a curl request object and set parameters
		$ch = curl_init($userURL."sysparm_query=user_name=".$fourByfour);
		curl_setopt($ch, CURLOPT_HEADER, false);
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
		curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
		curl_setopt($ch, CURLOPT_USERPWD, $userPwd);
		curl_setopt($ch, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_0);
		$json = curl_exec($ch);
		//check for http errors
		if(curl_errno($ch)){
			print_r('Curl error: '.curl_error($ch)."<br/>");
		}
		//release curl object
		curl_close($ch);
		//decode JSON text into JSON objects
		$data = json_decode($json);
		//return the first (and only) building object
		return $data->records[0];
	}
	
	function getIncidents($params = "active=true"){
		global $incidentURL, $userPwd;
		$ch = curl_init($incidentURL."^".urlencode($params));
		curl_setopt($ch, CURLOPT_HEADER, 0);
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
        curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
        curl_setopt($ch, CURLOPT_USERPWD, $userPwd);
 
        $json = curl_exec($ch);
        if(curl_errno($ch)){
			print_r('Curl error: '.curl_error($ch)."<br/>");
		}
        curl_close($ch);
		$data = json_decode($json);
		//return all of the aquired incident objects
		return $data->records;
	}
	
	
	function getRows($incs, $cols){
		global $MAX_ROW_COUNT;
		$header = "<tr>";
		$rows = "<tr>";
		foreach($cols as $col){
			$header .= "<th>".$col['label']."</th>";
		}
		for($i = 0; ($i < $MAX_ROW_COUNT && $i < count($incs)); $i++){
			foreach($cols as $col){
				
				switch ($col['id']){
					case (IncFields::ACTIVE['id']):
						$rows .= "<td>".$incs[$i]->active."</td>";
						break;
					case (IncFields::ACTIVITY_DUE['id']):
						$rows .= "<td>".$incs[$i]->activity_due."</td>";
						break;
					case (IncFields::APPROVAL['id']):
						$rows .= "<td>".$incs[$i]->approval."</td>";
						break;
					case (IncFields::APPROVAL_HISTORY['id']):
						$rows .= "<td>".$incs[$i]->approval_history."</td>";
						break;
					case (IncFields::APPROVAL_SET['id']):
						$rows .= "<td>".$incs[$i]->approval_set."</td>";
						break;
					case (IncFields::ASSIGNED_TO_SHORT['id']):
						/*
						if($incs[$i]->assigned_to != ""){
							$user = getUser($incs[$i]->assigned_to);
							$rows .= "<td>".$user->first_name." ".$user->last_name."</td>";
						} else {
							$rows .= "<td></td>";
						}
						*/
						$rows .= "<td>".$incs[$i]->assigned_to."</td>";
						break;
					case (IncFields::ASSIGNED_TO_FULL['id']):
						if($incs[$i]->assigned_to != ""){
							$user = getUser($incs[$i]->assigned_to);
							$rows .= "<td>".$user->first_name." ".$user->last_name."</td>";
						} else {
							$rows .= "<td></td>";
						}
						break;
					case (IncFields::ASSIGNMENT_GROUP['id']):
						$rows .= "<td>".$incs[$i]->assignment_group."</td>";
						break;
					case (IncFields::BUSINESS_DURATION['id']):
						$rows .= "<td>".$incs[$i]->business_duration."</td>";
						break;
					case (IncFields::BUSINESS_STS['id']):
						$rows .= "<td>".$incs[$i]->business_sts."</td>";
						break;
					case (IncFields::CALENDAR_DURATION['id']):
						$rows .= "<td>".$incs[$i]->calendar_duration."</td>";
						break;
					case (IncFields::CALENDAR_STC['id']):
						$rows .= "<td>".$incs[$i]->calendar_stc."</td>";
						break;
					case (IncFields::CALLER_ID['id']):
						$rows .= "<td>".$incs[$i]->caller_id."</td>";
						break;
					case (IncFields::CATEGORY['id']):
						$rows .= "<td>".$incs[$i]->category."</td>";
						break;
					case (IncFields::CAUSED_BY['id']):
						$rows .= "<td>".$incs[$i]->caused_by."</td>";
						break;
					case (IncFields::CLOSE_NOTES['id']):
						$rows .= "<td>".$incs[$i]->close_notes."</td>";
						break;
					case (IncFields::CLOSED_AT['id']):
						$rows .= "<td>".$incs[$i]->closed_at."</td>";
						break;
					case (IncFields::CLOSED_BY['id']):
						$rows .= "<td>".$incs[$i]->closed_by."</td>";
						break;
					case (IncFields::CMDB_CI['id']):
						$rows .= "<td>".$incs[$i]->cmdb_ci."</td>";
						break;
					case (IncFields::COMMENTS['id']):
						$rows .= "<td>".$incs[$i]->comments."</td>";
						break;
					case (IncFields::COMPANY['id']):
						$rows .= "<td>".$incs[$i]->company."</td>";
						break;
					case (IncFields::CONTACT_TYPE['id']):
						$rows .= "<td>".$incs[$i]->contact_type."</td>";
						break;
					case (IncFields::CORRELATION_DISPLAY['id']):
						$rows .= "<td>".$incs[$i]->correlation_display."</td>";
						break;
					case (IncFields::CORRELATION_ID['id']):
						$rows .= "<td>".$incs[$i]->correlation_id."</td>";
						break;
					case (IncFields::DELIVERY_PLAN['id']):
						$rows .= "<td>".$incs[$i]->delivery_plan."</td>";
						break;
					case (IncFields::DESCRIPTION['id']):
						$rows .= "<td>".$incs[$i]->description."</td>";
						break;
					case (IncFields::DUE_DATE['id']):
						$rows .= "<td>".$incs[$i]->due_date."</td>";
						break;
					case (IncFields::ESCALATION['id']):
						$rows .= "<td>".$incs[$i]->escalation."</td>";
						break;
					case (IncFields::EXPECTED_START['id']):
						$rows .= "<td>".$incs[$i]->expected_start."</td>";
						break;
					case (IncFields::FOLLOW_UP['id']):
						$rows .= "<td>".$incs[$i]->follow_up."</td>";
						break;
					case (IncFields::GROUP_LIST['id']):
						$rows .= "<td>".$incs[$i]->group_list."</td>";
						break;
					case (IncFields::IMPACT['id']):
						$rows .= "<td>".$incs[$i]->impact."</td>";
						break;
					case (IncFields::INCIDENT_STATE['id']):
						$rows .= "<td>".$incs[$i]->incident_state."</td>";
						break;
					case (IncFields::KNOWLEDGE['id']):
						$rows .= "<td>".$incs[$i]->knowledge."</td>";
						break;
					case (IncFields::LOCATION['id']):
						$rows .= "<td>".$incs[$i]->location."</td>";
						break;
					case (IncFields::MADE_SLA['id']):
						$rows .= "<td>".$incs[$i]->made_sla."</td>";
						break;
					case (IncFields::NOTIFY['id']):
						$rows .= "<td>".$incs[$i]->notify."</td>";
						break;
					case (IncFields::NUMBER['id']):
						$rows .= "<td>".$incs[$i]->number."</td>";
						break;
					case (IncFields::OPENED_AT['id']):
						$rows .= "<td>".$incs[$i]->opened_at."</td>";
						break;
					case (IncFields::OPENED_BY['id']):
						$rows .= "<td>".$incs[$i]->opened_by."</td>";
						break;
					case (IncFields::ORDER['id']):
						$rows .= "<td>".$incs[$i]->order."</td>";
						break;
					case (IncFields::INC_PARENT['id']):
						$rows .= "<td>".$incs[$i]->inc_parent."</td>";
						break;
					case (IncFields::PRIORITY['id']):
						$rows .= "<td>".$incs[$i]->priority."</td>";
						break;
					case (IncFields::PROBLEM_ID['id']):
						$rows .= "<td>".$incs[$i]->problem_id."</td>";
						break;
					case (IncFields::REASSIGNMENT_COUNT['id']):
						$rows .= "<td>".$incs[$i]->reassignment_count."</td>";
						break;
					case (IncFields::REJECTION_GOTO['id']):
						$rows .= "<td>".$incs[$i]->rejection_goto."</td>";
						break;
					case (IncFields::RFC['id']):
						$rows .= "<td>".$incs[$i]->rfc."</td>";
						break;
					case (IncFields::SERVICE_OFFERING['id']):
						$rows .= "<td>".$incs[$i]->service_offering."</td>";
						break;
					case (IncFields::SEVERITY['id']):
						$rows .= "<td>".$incs[$i]->severity."</td>";
						break;
					case (IncFields::SHORT_DESCRIPTION['id']):
						$rows .= "<td>".$incs[$i]->short_description."</td>";
						break;
					case (IncFields::SKILLS['id']):
						$rows .= "<td>".$incs[$i]->skills."</td>";
						break;
					case (IncFields::SLA_DUE['id']):
						$rows .= "<td>".$incs[$i]->sla_due."</td>";
						break;
					case (IncFields::STATE['id']):
						$rows .= "<td>".$incs[$i]->state."</td>";
						break;
					case (IncFields::SUBCATEGORY['id']):
						$rows .= "<td>".$incs[$i]->subcategory."</td>";
						break;
					case (IncFields::SYS_CLASS_NAME['id']):
						$rows .= "<td>".$incs[$i]->sys_class_name."</td>";
						break;
					case (IncFields::SYS_CREATED_BY['id']):
						$rows .= "<td>".$incs[$i]->sys_created_by."</td>";
						break;
					case (IncFields::SYS_CREATED_ON['id']):
						$rows .= "<td>".$incs[$i]->sys_created_on."</td>";
						break;
					case (IncFields::SYS_DOMAIN['id']):
						$rows .= "<td>".$incs[$i]."</td>";
						break;
					case (IncFields::SYS_ID['id']):
						$rows .= "<td>".$incs[$i]."</td>";
						break;
					case (IncFields::SYS_MOD_COUNT['id']):
						$rows .= "<td>".$incs[$i]."</td>";
						break;
					case (IncFields::SYS_UPDATED_BY['id']):
						$rows .= "<td>".$incs[$i]."</td>";
						break;
					case (IncFields::SYS_UPDATE_ON['id']):
						$rows .= "<td>".$incs[$i]."</td>";
						break;
					case (IncFields::TIME_WORKED['id']):
						$rows .= "<td>".$incs[$i]."</td>";
						break;
					case (IncFields::U_ACTION['id']):
						$rows .= "<td>".$incs[$i]."</td>";
						break;
					case (IncFields::U_AFFECTED_USER['id']):
						$rows .= "<td>".$incs[$i]."</td>";
						break;
					case (IncFields::U_BS['id']):
						$rows .= "<td>".$incs[$i]."</td>";
						break;
					case (IncFields::U_BUILDING_FULL['id']):
						if($incs[$i]->u_building != ""){
							$class = getBuilding($incs[$i]->u_building);
							$rows .= "<td>".$class->full_name."</td>";
						} else {
							$rows .= "<td></td>";
						}
						break;
					case (IncFields::U_BUILDING_SHORT['id']):
						if($incs[$i]->u_building != ""){
							$class = getBuilding($incs[$i]->u_building);
							$rows .= "<td>".$class->u_regents_code."</td>";
						} else {
							$rows .= "<td></td>";
						}
						break;
					case (IncFields::U_BUS_SERV['id']):
						$rows .= "<td>".$incs[$i]->u_bus_serv."</td>";
						break;
					case (IncFields::U_BUSINESS_SERVICE['id']):
						$rows .= "<td>".$incs[$i]."</td>";
						break;
					case (IncFields::U_CLASS_IN_SESSION['id']):
						$rows .= "<td>".$incs[$i]->u_class_in_session."</td>";
						break;
					case (IncFields::U_CLASSROOM['id']):
						if($incs[$i]->u_classroom != ""){
							$class = getClassroom($incs[$i]->u_classroom);
							$rows .= "<td>".$class->u_room."</td>";
						} else {
							$rows .= "<td></td>";
						}
						break;
					case (IncFields::U_CMDB_CI_SERVICES['id']):
						$rows .= "<td>".$incs[$i]."</td>";
						break;
					case (IncFields::U_CUSTOMER_CONTACTED['id']):
						$rows .= "<td>".$incs[$i]."</td>";
						break;
					case (IncFields::U_LEGACY_INCIDENT_NUMBER['id']):
						$rows .= "<td>".$incs[$i]."</td>";
						break;
					case (IncFields::U_OFF['id']):
						$rows .= "<td>".$incs[$i]."</td>";
						break;
					case (IncFields::U_OFFERING['id']):
						$rows .= "<td>".$incs[$i]."</td>";
						break;
					case (IncFields::U_ORDER_STATUS['id']):
						$rows .= "<td>".$incs[$i]."</td>";
						break;
					case (IncFields::U_ORIGIN['id']):
						$rows .= "<td>".$incs[$i]."</td>";
						break;
					case (IncFields::U_PREFDAY['id']):
						$rows .= "<td>".$incs[$i]."</td>";
						break;
					case (IncFields::U_PREFFERED_PHONE['id']):
						$rows .= "<td>".$incs[$i]->preffered_phone."</td>";
						break;
					case (IncFields::U_PRIVATE_COMMENTS['id']):
						$rows .= "<td>".$incs[$i]->private_comments."</td>";
						break;
					case (IncFields::U_PROJECT_CATEGORY['id']):
						$rows .= "<td>".$incs[$i]."</td>";
						break;
					case (IncFields::U_REQUISITION_NUMBER['id']):
						$rows .= "<td>".$incs[$i]."</td>";
						break;
					case (IncFields::U_RESOLVED_1ST_CONTACT['id']):
						$rows .= "<td>".$incs[$i]."</td>";
						break;
					case (IncFields::U_RESOLVED_2ND_CONTACT['id']):
						$rows .= "<td>".$incs[$i]."</td>";
						break;
					case (IncFields::U_RESOLVED_3RD_CONTACT['id']):
						$rows .= "<td>".$incs[$i]."</td>";
						break;
					case (IncFields::U_RESOLVED_BY['id']):
						$rows .= "<td>".$incs[$i]->resolved_by."</td>";
						break;
					case (IncFields::U_SAMEUSER['id']):
						$rows .= "<td>".$incs[$i]."</td>";
						break;
					case (IncFields::U_SECONDARY_LOCATION['id']):
						$rows .= "<td>".$incs[$i]."</td>";
						break;
					case (IncFields::U_SERVICE_OFFERING['id']):
						$rows .= "<td>".$incs[$i]."</td>";
						break;
					case (IncFields::U_SOURCE['id']):
						$rows .= "<td>".$incs[$i]."</td>";
						break;
					case (IncFields::U_VAPINFO['id']):
						$rows .= "<td>".$incs[$i]."</td>";
						break;
					case (IncFields::U_WORK_NOTES['id']):
						$rows .= "<td>".$incs[$i]."</td>";
						break;
					case (IncFields::UPON_APPROVAL['id']):
						$rows .= "<td>".$incs[$i]."</td>";
						break;
					case (IncFields::UPON_REJECT['id']):
						$rows .= "<td>".$incs[$i]."</td>";
						break;
					case (IncFields::URGENCY['id']):
						$rows .= "<td>".$incs[$i]."</td>";
						break;
					case (IncFields::USER_INPUT['id']):
						$rows .= "<td>".$incs[$i]."</td>";
						break;
					case (IncFields::VARIABLES['id']):
						$rows .= "<td>".$incs[$i]."</td>";
						break;
					case (IncFields::WATCH_LIST['id']):
						$rows .= "<td>".$incs[$i]."</td>";
						break;
					case (IncFields::WF_ACTIVITY['id']):
						$rows .= "<td>".$incs[$i]."</td>";
						break;
					case (IncFields::WORK_END['id']):
						$rows .= "<td>".$incs[$i]."</td>";
						break;
					case (IncFields::WORK_START['id']):
						$rows .= "<td>".$incs[$i]."</td>";
						break;
					case (IncFields::WORK_NOTES['id']):
						$rows .= "<td>".$incs[$i]."</td>";
						break;
					case (IncFields::CUST_LOC['id']):
						$rows .= "<td>";
						if($incs[$i]->u_building != ""){
							$rows .= getBuilding($incs[$i]->u_building)->u_regents_code;
						}
						if($incs[$i]->u_classroom != ""){
							$rows .= " ".getClassroom($incs[$i]->u_classroom)->u_room;
						}
						$rows .= "</td>";
						break;
					case (IncFields::CUST_SHORT_CREATED_ON['id']):
						if($incs[$i]->sys_created_on != ""){
							$rows .= "<td>".date("m/d",strtotime($incs[$i]->sys_created_on))."</td>";
						} else {
							$rows .= "<td></td>";
						}
						break;
				}
			}
			$rows .= "</tr>\n";
		}
		return $header."\n".$rows;
	}
	
	function sortBy($data, $col, $dir){
		usort($data,function($a,$b) use ($col,$dir){
			$bl = 0;
			$al = 0;
			switch ($col['id']){
				case (IncFields::ACTIVE['id']):
					$al = $a->active == 'true' ? 1 : 0;
					$b1 = $b->active == 'true' ? 1 : 0;
					break;
				case (IncFields::ACTIVITY_DUE['id']):
					break;
				case (IncFields::APPROVAL['id']):
					break;
				case (IncFields::APPROVAL_HISTORY['id']):
					break;
				case (IncFields::APPROVAL_SET['id']):
					break;
				case (IncFields::ASSIGNED_TO_SHORT['id']):
					$al = strtolower($a->assigned_to);
					$bl = strtolower($b->assigned_to);
					break;
				case (IncFields::ASSIGNED_TO_FULL['id']):
					$al = strtolower($a->assigned_to);
					$bl = strtolower($b->assigned_to);
					break;
				case (IncFields::ASSIGNMENT_GROUP['id']):
					$al = strtolower($a->assigned_to);
					$bl = strtolower($b->assigned_to);
					break;
				case (IncFields::BUSINESS_DURATION['id']):
					break;
				case (IncFields::BUSINESS_STS['id']):
					break;
				case (IncFields::CALENDAR_DURATION['id']):
					break;
				case (IncFields::CALENDAR_STC['id']):
					break;
				case (IncFields::CALLER_ID['id']):
					$al = strtolower($a->caller_id);
					$bl = strtolower($b->caller_id);
					break;
				case (IncFields::CATEGORY['id']):
					$al = strtolower($a->category);
					$bl = strtolower($b->category);
					break;
				case (IncFields::CAUSED_BY['id']):
					$al = strtolower($a->caused_by);
					$bl = strtolower($b->caused_by);
					break;
				case (IncFields::CLOSE_NOTES['id']):
					break;
				case (IncFields::CLOSED_AT['id']):
					break;
				case (IncFields::CLOSED_BY['id']):
					break;
				case (IncFields::CMDB_CI['id']):
					break;
				case (IncFields::COMMENTS['id']):
					$al = strtolower($a->comments);
					$bl = strtolower($b->comments);
					break;
				case (IncFields::COMPANY['id']):
					break;
				case (IncFields::CONTACT_TYPE['id']):
					break;
				case (IncFields::CORRELATION_DISPLAY['id']):
					break;
				case (IncFields::CORRELATION_ID['id']):
					break;
				case (IncFields::DELIVERY_PLAN['id']):
					break;
				case (IncFields::DESCRIPTION['id']):
					break;
				case (IncFields::DUE_DATE['id']):
					break;
				case (IncFields::ESCALATION['id']):
					break;
				case (IncFields::EXPECTED_START['id']):
					break;
				case (IncFields::FOLLOW_UP['id']):
					break;
				case (IncFields::GROUP_LIST['id']):
					break;
				case (IncFields::IMPACT['id']):
					break;
				case (IncFields::INCIDENT_STATE['id']):
					$al = $a->incident_state;
					$bl = $b->incident_state;
					break;
				case (IncFields::KNOWLEDGE['id']):
					break;
				case (IncFields::LOCATION['id']):
					break;
				case (IncFields::MADE_SLA['id']):
					break;
				case (IncFields::NOTIFY['id']):
					break;
				case (IncFields::NUMBER['id']):
					$al = strtolower($a->number);
					$bl = strtolower($b->number);
					break;
				case (IncFields::OPENED_AT['id']):
					break;
				case (IncFields::OPENED_BY['id']):
					break;
				case (IncFields::ORDER['id']):
					break;
				case (IncFields::INC_PARENT['id']):
					break;
				case (IncFields::PRIORITY['id']):
					break;
				case (IncFields::PROBLEM_ID['id']):
					break;
				case (IncFields::REASSIGNMENT_COUNT['id']):
					break;
				case (IncFields::REJECTION_GOTO['id']):
					break;
				case (IncFields::RFC['id']):
					break;
				case (IncFields::SERVICE_OFFERING['id']):
					break;
				case (IncFields::SEVERITY['id']):
					break;
				case (IncFields::SHORT_DESCRIPTION['id']):
					break;
				case (IncFields::SKILLS['id']):
					break;
				case (IncFields::SLA_DUE['id']):
					break;
				case (IncFields::STATE['id']):
					break;
				case (IncFields::SUBCATEGORY['id']):
					break;
				case (IncFields::SYS_CLASS_NAME['id']):
					break;
				case (IncFields::SYS_CREATED_BY['id']):
					break;
				case (IncFields::SYS_CREATED_ON['id']):
					$al = strtotime($a->sys_created_on);
					$bl = strtotime($b->sys_created_on);
					break;
				case (IncFields::SYS_DOMAIN['id']):
					break;
				case (IncFields::SYS_ID['id']):
					break;
				case (IncFields::SYS_MOD_COUNT['id']):
					break;
				case (IncFields::SYS_UPDATED_BY['id']):
					break;
				case (IncFields::SYS_UPDATE_ON['id']):
					break;
				case (IncFields::TIME_WORKED['id']):
					break;
				case (IncFields::U_ACTION['id']):
					break;
				case (IncFields::U_AFFECTED_USER['id']):
					break;
				case (IncFields::U_BS['id']):
					break;
				case (IncFields::U_BUILDING_FULL['id']):
					$al = strtolower(getBuilding($a->u_building)->full_name);
					$bl = strtolower(getBuilding($b->u_building)->full_name);
					break;
				case (IncFields::U_BUILDING_SHORT['id']):
					$al = strtolower(getBuilding($a->u_building)->u_regents_code);
					$bl = strtolower(getBuilding($b->u_building)->u_regents_code);
					break;
				case (IncFields::U_BUS_SERV['id']):
					break;
				case (IncFields::U_BUSINESS_SERVICE['id']):
					break;
				case (IncFields::U_CLASS_IN_SESSION['id']):
					break;
				case (IncFields::U_CLASSROOM['id']):
					$al = strtolower(getClassroom($a->u_classroom)->u_room);
					$bl = strtolower(getClassroom($b->u_classroom)->u_room);
					break;
				case (IncFields::U_CMDB_CI_SERVICES['id']):
					break;
				case (IncFields::U_CUSTOMER_CONTEACTED['id']):
					break;
				case (IncFields::U_LEGACY_INCIDENT_NUMBER['id']):
					break;
				case (IncFields::U_OFF['id']):
					break;
				case (IncFields::U_OFFERING['id']):
					break;
				case (IncFields::U_ORDER_STATUS['id']):
					break;
				case (IncFields::U_ORIGIN['id']):
					break;
				case (IncFields::U_PREFDAY['id']):
					break;
				case (IncFields::U_PREFFERED_PHONE['id']):
					break;
				case (IncFields::U_PRIVATE_COMMENTS['id']):
					break;
				case (IncFields::U_PROJECT_CATEGORY['id']):
					break;
				case (IncFields::U_REQUISITION_NUMBER['id']):
					break;
				case (IncFields::U_RESOLVED_1ST_CONTACT['id']):
					break;
				case (IncFields::U_RESOLVED_2ND_CONTACT['id']):
					break;
				case (IncFields::U_RESOLVED_3RD_CONTACT['id']):
					break;
				case (IncFields::U_RESOLVED_BY['id']):
					break;
				case (IncFields::U_SAMEUSER['id']):
					break;
				case (IncFields::U_SECONDARY_LOCATION['id']):
					break;
				case (IncFields::U_SERVICE_OFFERING['id']):
					break;
				case (IncFields::U_SOURCE['id']):
					break;
				case (IncFields::U_VAPINFO['id']):
					break;
				case (IncFields::U_WORK_NOTES['id']):
					break;
				case (IncFields::UPON_APPROVAL['id']):
					break;
				case (IncFields::UPON_REJECT['id']):
					break;
				case (IncFields::URGENCY['id']):
					break;
				case (IncFields::USER_INPUT['id']):
					break;
				case (IncFields::VARIABLES['id']):
					break;
				case (IncFields::WATCH_LIST['id']):
					break;
				case (IncFields::WF_ACTIVITY['id']):
					break;
				case (IncFields::WORK_END['id']):
					break;
				case (IncFields::WORK_START['id']):
					break;
				case (IncFields::WORK_NOTES['id']):
					break;
				case (IncFields::CUST_LOC['id']):
					break;
				case (IncFields::CUST_SHORT_CREATED_ON['id']):
					break;
			}
			
			if($al == $bl){
				return 0;
			}
			return (($al > $bl) ? ($dir*1): ($dir*-1));
		});
		return $data;
	}
?>

<!DOCTYPE html>
<html>
    <head>
        <title>OUIT LS SN Dashboard</title>
        <style>
			html,body {
				padding: 0px 0px 0px 0px;
				min-height:100%;
				min-width:100%;
			}
			header {
				position: absolute;
				height:50px;
				width:100%;
				top:0px;
				left:0px;
				margin: 0px 0px 0px 0px;
				background-color:black;
				opacity: 80%;
			}
			header h1 {
				position: absolute;
				margin-top: -18px;
				left: 100px;
				top: 25px;
				color:white;
				font-family: Arial, Helvetica, sans-serif;
				font-size:36px;
			}
			#db_incs {
				height: auto;
				width: 30%;
				position:absolute;
				top: 50px;
				left:1%;
				background-color:transparent;
				border-spacing: 0px 5px;
			}
			#db_incs caption {
				color:#FFFFFF;
			}
			#db_incs th{
				padding: 2px 2px 2px 10px;
				text-align:left;
				background-color:#990000;
				opacity: 90%;
			}
			#db_incs td {
				text-align:left;
				padding: 2px 2px 2px 10px;
				background-color:#000000;
				color:#FFFFFF;
			}
			#faculty_assists {
				height: auto;
				width: 30%;
				position:absolute;
				top: 50px;
				left: 35%;
				background-color:transparent;
				border-spacing: 0px 5px;
			}
			#faculty_assists caption {
				color:#FFFFFF;
			}
			#faculty_assists th{
				padding: 2px 2px 2px 10px;
				text-align:left;
				background-color:#990000;
				opacity: 90%;
			}
			#faculty_assists td {
				text-align:left;
				padding: 2px 2px 2px 10px;
				background-color:#000000;
				color:#FFFFFF;
			}
			#urgent {
				height: auto;
				width: 30%;
				position:absolute;
				top: 50px;
				left: 69%;
				background-color:transparent;
				border-spacing: 0px 5px;
			}
			#urgent caption {
				color:#FFFFFF;
			}
			#urgent th{
				padding: 2px 2px 2px 10px;
				text-align:left;
				background-color:#990000;
				opacity: 90%;
			}
			#urgent td {
				text-align:left;
				padding: 2px 2px 2px 10px;
				background-color:#000000;
				color:#FFFFFF;
			}
			footer {
				position: absolute;
				height:100px;
				width:100%;
				bottom: 0%;
				left:0px;
				margin: 0px 0px 0px 0px;
				background-color:black;
				opacity: 80%;
				overflow:hidden;
			}
			#date_time {
				position:absolute;
				right:5px;
				height: 50px;
				top:5px;
				color:white;
				float:right;
				font-size:36px;
				font-family:Arial, Helvetica, sans-serif;
			}
			#stats {
				color:white;
				text-align: left;
			}
		</style>
    </head>
    <body>
    	<video autoplay loop muted style="position: fixed; top: 0; left: 0; min-width: 100%; min-height: 100%; width: auto; height: auto; z-index: -100;">
        	Video Not Supported
        	<source src="WD0185.webm" type="video/webm">
        </video>
        <header>
        	<h1>OUIT Learning Spaces</h1>
        </header>
        <?php flush(); ?>
        <section>
        	<table id="db_incs">
        		<col style="width:20%">
                <col style="width:40%">
                <col style="width:40%">
            	<caption>Dashboard Incidents</caption>
            	<?php
                	$results = getIncidents("active=true^short_description>=~");
					echo getRows($results,
						array(IncFields::CUST_SHORT_CREATED_ON,IncFields::NUMBER,IncFields::ASSIGNED_TO_FULL));
				?>
            </table>
            <table id="faculty_assists">
            	<col style="width:20%">
                <col style="width:20%">
                <col style="width:30%">
                <col style="width:30%">
            	<caption>Faculty Assists</caption>
            	<?php
                	$results = getIncidents("active=true^subcategory=Faculty Assist");
					echo getRows($results,
						array(IncFields::CUST_SHORT_CREATED_ON,IncFields::NUMBER,IncFields::CUST_LOC,IncFields::ASSIGNED_TO_FULL));
				?>
            </table>
            <table id="urgent">
            	<col style="width:20%">
                <col style="width:20%">
                <col style="width:30%">
                <col style="width:30%">
            	<caption>Urgent</caption>
            	<?php
                	$results = getIncidents("active=true^u_class_in_session=Yes");
					echo getRows($results,
						array(IncFields::CUST_SHORT_CREATED_ON,IncFields::NUMBER,IncFields::CUST_LOC,IncFields::ASSIGNED_TO_FULL));
				?>
            </table>
        </section>
        <?php flush(); ?>
        <footer>
        	<div id="date_time">
            	<?php echo date("l M/j",time()); ?>
              	<br/>
                <?php echo date("h:i a",time()); ?>
            </div>
            <table id="stats">
            	<col style="width:5%">
                <col style="width:35%">
                <col style="width:30%">
                <col style="width:30%">
                <tr height="25%"><td colspan="4">Learning Spaces</td></tr>
                <tr height="15%"><td></td><td></td><td>Total</td><td>Added</td></tr>
                <tr height="15"><td><?php echo count(getIncidents("incident_state=1")); ?></td><td>New</td><td rowspan="4"><?php echo count(getIncidents("active=true")); ?></td><td rowspan="4"><?php echo count(getIncidents("closed_atONToday@javascript:gs.daysAgoStart(0)@javascript:gs.daysAgoEnd(0)")); ?></td></tr>
                <tr height="15%"><td><?php echo count(getIncidents("active=true^incident_state>=3^incident_state<=5")); ?></td><td>Awaiting</td></tr>
                <tr height="15%"><td><?php echo count(getIncidents("incident_state=6")); ?></td><td>Resolved</td></tr>
                <tr height="15%"><td></td><td></td></tr>
            </table>
        </footer>
        <script>
			setTimeout(function (){location.reload(true)},1000*60);
		</script>
    </body>
</html>
