$(document).ready(function(){
var debug = false,
	elements = {},
	timeout_id = null;
	downStarted = false;
	$createDialog = $('<div></div>')
		.addClass('createDialog')
		.hide()
	,
	$optionsList = $('<ul id="optionsList" onclick="$createDialog.hide()">Add Menu</ul>')
		.append('<li onclick="optionsClick(1)">New Canvas</li>'),
		.append('<li onclick="optionsClick(2)">New iFrame</li>'),
	;
	$createDialog.append($optionsList);
	$content = $('#content')
		.append($createDialog)
	;

	$content.mousedown(function(e) {
		if(debug){console.log('Timeout Started')};
		downStarted = true;
		timeout_id = setTimeout(function(){
			if(debug){
				console.log('Timeout Executed');
				console.log('Mouse: ('+e.pageX+','+e.pageY+')');
			};
			downStarted=false;
			openCreateDialog(e.pageX,e.pageY)
		}, 1000);
	}).bind('mouseup mousemove', function() {
		if(downStarted===true){
			if(debug){console.log('Timeout Stopped')};
			clearTimeout(timeout_id);
			downStarted=false;
		};
	});

	function openCreateDialog(x,y){
		$createDialog.show();
		$createDialog.offset({top:(y-50), left:(x-50)});
		var offset = $createDialog.offset();
		if(debug){
			console.log('x: '+x+',y: '+y);
			console.log('Dialog: ('+$createDialog.offset().left+','+$createDialog.offset().top+')');
		};
	};
	
	function optionsClick(n){
		x = $createDialog.offset().left;
		y = $createDialog.offset().top;
		switch(n){
		case 1:
			createCanvas(x,y);
			$createDialog.hide();
			break;
		case 2:
			createIFrame(x,y);
			$createDialog.hide();
			break;
		default:
			throw ('No case found for option '+n);
	};
	
	//Creates a new canvas at the x,y coordinates
	function createCanvas(x,y){
		var $canvas = $('<canvas></canvas>')
			.resizable();
			.data('id', Math.floor(Math.random()*100000)
		;
		elements[$canvas.data('id')]=$canvas; //not sure if this will actually be used
		
	}
	
	function createIFrame(x,y){
		
	}
	this.toggleDebug = function(){
		debug = !debug;
		return debug;
	};
	
});