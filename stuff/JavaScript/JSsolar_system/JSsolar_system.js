var currentFocus;
var timeElapsed = 0;
var timeMultiplier = 1;
var tick=20;
var $=document;
var play=true;
var contentSize = 0;

var timeDilationSlider;
var timeDilationLabel;
var rotCounter;
var timeCounter

function entity(id,name,tRot,orbFrac, element){
    this.id=id;
    this.name=name;
    this.rotations=0;
    this.rotationTime=tRot;
	this.orbitFraction = orbFrac;
    this.element = element;
    
    console.log(this);
};

var mercury, venus, earth, moon, mars, asteroid, jupiter, saturn, uranus, neptune, pluto;
var bodies = [];

window.onload = function() {
    console.log('onload');
    mercury = new entity("mercury-orbit","Mercury",88,.1, $.getElementById('mercury-orbit'));
    console.log($.getElementById('venus-orbit'));
    venus = new entity("venus-orbit","Venus",225,.2, $.getElementById('venus-orbit'));
    earth = new entity("earth-orbit","Earth",365,.3, $.getElementById('earth-orbit'));
    moon = new entity("moon-orbit","Moon",29,-1, $.getElementById('moon-orbit'));
    mars = new entity("mars-orbit","Mars",687,.4, $.getElementById('mars-orbit'));
    asteroid = new entity("asteroid-belt","Asteroid Belt",100,.5,$.getElementById('asteroid-belt'));
    jupiter = new entity("jupiter-orbit","Jupiter",4332,.6, $.getElementById('jupiter-orbit'));
    saturn = new entity("saturn-orbit","Saturn",10760,.7, $.getElementById('saturn-orbit'));
    uranus = new entity("uranus-orbit","Uranus",30700,.8, $.getElementById('uranus-orbit'));
    neptune = new entity("neptune-orbit","Neptune",60200,.9, $.getElementById('neptune-orbit'));
    pluto = new entity("pluto-orbit","Pluto",90600,1, $.getElementById('pluto-orbit'));
    bodies = [mercury, venus, earth, moon, mars, asteroid, jupiter, saturn, uranus, neptune, pluto];

    timeDilationSlider = $.getElementById("timeSlider");
    rotCounter = $.getElementById("rotCounter");
    timeCounter = $.getElementById("timeCounter");
    timeDilationLabel = $.getElementById("timeDilation");

	this.onResize();
    this.setFocus("earth-orbit");
    requestAnimationFrame(loop);
};

function onResize(){
	contentSize = $.getElementById("content").offsetHeight;
	console.log("content height: " + contentSize);
	// for(obj in bodies){
    //     var body = bodies[obj];
	// 	console.log(obj + " height set to " + contentSize*body.orbitFraction)
	// 	body.element.style.height = (contentSize*body.orbitFraction) + "px";
	// }
}

function setFocus(id){
    var body;
	for(obj in bodies){
        body = bodies[obj];
        if(body.id===id){
            console.log(body.id+" found");
            break;
        }
    }

	if(this.currentFocus!=null){
		this.currentFocus.element.style.borderColor="white";
    }
    
	if(this.currentFocus===body){
		this.currentFocus=null;
	} else {
		this.currentFocus = body;
        console.log("currentFocus set to "+body.id);
		this.currentFocus.element.style.borderColor="red";
	}
    x = $.getElementsByName("planetName");
    for(i=0;i<x.length;i++){
        x[i].innerHTML=this.currentFocus.name;
    }
    console.log("focus set to "+this.currentFocus.id);
};

function onCheck(box){
    var entity;
    if(box.name==="sun"){
        $.getElementById('sun').style.visibility = box.checked ? "visible" : "hidden";
    } else if(box.name==="asteroid"){
        entity = asteroid;
    } else {
        for(obj in bodies){
            var body = bodies[obj];
            if(body.id===box.name+"-orbit"){
                entity=body;
                break;
            }
        }
    }
    if(box.checked){
        entity.element.style.visibility="visible";
        console.log(entity.id+": visible");
    } else {
        if(entity===this.currentFocus){
            var focus = entity.id === earth.id ? mercury : earth;
            this.setFocus(focus.id);
        }
        entity.element.style.visibility="hidden";
        console.log(entity.id+": hidden");
    }
};

function togglePlayback(button){
    this.play = !this.play;
    if(this.play===true){
        requestAnimationFrame(loop);
        button.innerHTML="Pause";
    } else if(this.play===false){
        button.innerHTML="Play";
    }
};

function toggleDirection(button){
    if(this.timeMultiplier>0){
        button.innerHTML="Forward";
    } else {
        button.innerHTML="Rewind";
    }
    this.timeMultiplier*=-1;
	draw();
};

function resetSys(){
    this.timeElapsed=0;
    for(n in bodies){
        bodies[n].rotations = 0;
    }
	draw();
};

function dilateTime(slider){
    this.timeMultiplier=slider.value*Math.sign(this.timeMultiplier);
	draw();
};

var last=null;
function loop(now) {
    var dt = 0;
    if(last!==null) {
        dt = now - last;
    }
    last = now;
    update(dt);
    draw();
    if(this.play) {
        requestAnimationFrame(loop);
    } else {
        last = null;
    }
}
function update(dt) {
    for(n in bodies) {
        obj=bodies[n];
        obj.rotations = (obj.rotations+((1/obj.rotationTime)*(dt/1000)*this.timeMultiplier))%1
    }
    this.timeElapsed += dt/1000*this.timeMultiplier;
}

function draw() {
    
    for(n in bodies) {
        var obj = bodies[n];
        obj.element.style.transform="rotate("+obj.rotations*360+"deg)";
    }
    
	if(this.currentFocus!=null){
        rotCounter.innerHTML=this.currentFocus.rotations.toFixed(4);
    } else {
        rotCounter.innerHTML="";
    }
    timeCounter.innerHTML=this.timeElapsed.toFixed(2);
	var slider = timeDilationSlider
	slider.value=Math.abs(timeMultiplier);
	if(this.timeMultiplier===1||this.timeMultiplier===-1){
		units = " day/sec";
	} else {
		units = " days/sec";
	};
	timeDilationLabel.innerHTML=this.timeMultiplier+units;
};


