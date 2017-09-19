var currentFocus;
var timeElapsed = 0;
var timeMultiplier = 1;
var tick=20;
var $=document;
var play=true;
var contentSize = 0;

function entity(id,name,tRot,relSize,orbFrac){
    this.id=id;
    this.name=name;
    var rotations=0;
    this.rotationTime=tRot;
	this.orbitFraction = orbFrac;
	this.relativeSize = relSize;
    
    this.getRots = function(){
        return rotations;
    }
    
    this.setRots = function(rots){
        rotations=(rots);
    }
};

var mercury = new entity("mercury-orbit","Mercury",88,1,.1);
var venus = new entity("venus-orbit","Venus",225,.2);
var earth = new entity("earth-orbit","Earth",365,.3);
var moon = new entity("moon-orbit","Moon",29,-1);
var mars = new entity("mars-orbit","Mars",687,.4);
var asteroid = new entity("asteroid-belt","Asteroid Belt",100,.5);
var jupiter = new entity("jupiter-orbit","Jupiter",4332,.6);
var saturn = new entity("saturn-orbit","Saturn",10760,.7);
var uranus = new entity("uranus-orbit","Uranus",30700,.8);
var neptune = new entity("neptune-orbit","Neptune",60200,.9);
var pluto = new entity("pluto-orbit","Pluto",90600,1);
var bodies = [mercury, venus, earth, moon, mars, asteroid, jupiter, saturn, uranus, neptune, pluto];

window.onload = function() {
	this.setFocus("earth-orbit");
    setInterval(this.incOrbit, tick);
	this.onResize();
};

function onResize(){
	contentSize = $.getElementById("content").offsetHeight;
	console.log("content height: " + contentSize);
	for(obj in bodies){
		console.log(obj + " height set to " contentSize*bodies[obj].orbitFraction)
		$.getElementById(bodies[obj].id).style.height = (contentSize*bodies[obj].orbitFraction) + "px";
	}
}

function setFocus(id){
    var planet;
	for(obj in bodies){
        if(bodies[obj].id===id){
            planet=bodies[obj];
            console.log(planet.id+" found");
            break;
        }
    }
	if(this.currentFocus!=null){
		$.getElementById(this.currentFocus.id).style.borderColor="white";
	}
	if(this.currentFocus===planet){
		this.currentFocus=null;
	} else {
		this.currentFocus = planet;
        console.log("currentFocus set to "+planet.id);
		$.getElementById(this.currentFocus.id).style.borderColor="red";
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
        entity = sun;
    } else if(box.name==="asteroid"){
        entity = asteroid;
    } else {
        for(obj in bodies){
            if(bodies[obj].id===box.name+"-orbit"){
                entity=bodies[obj];
                break;
            }
        }
    }
    if(box.checked){
        $.getElementById(entity.id).style.visibility="visible";
        console.log(entity.id+": visible");
    } else {
        if(entity===this.currentFocus){
            this.setFocus(entity.id);
        }
        $.getElementById(entity.id).style.visibility="hidden";
        console.log(entity.id+": hidden");
    }
};

function togglePlayback(button){
    if(this.play===true){
        this.play=false;
        button.innerHTML="Play";
    } else if(this.play===false){
        this.play=true;
        button.innerHTML="Pause";
    }
};

function toggleDirection(button){
    if(this.timeMultiplier>0){
        button.innerHTML="Forward";
    } else {
        button.innerHTML="Rewind";
    }
    this.timeMultiplier*=-1;
	this.updateInfo();
};

function resetSys(){
    this.timeElapsed=0;
    for(n in bodies){
        bodies[n].setRots(0);
		$.getElementById(bodies[n].id).style.transform="rotate(0deg)";
    }
	this.updateInfo();
};

function dilateTime(slider){
    this.timeMultiplier=slider.value*Math.sign(this.timeMultiplier);
	this.updateInfo();
};

function incTime(obj, direction){
	var time = this.timeMultiplier+direction*Math.sign(this.timeMultiplier);
	console.log(time);
	var slider = $.getElementById("timeSlider");
    if(Math.sign(this.timeMultiplier)>0){
        var max = parseInt(slider.getAttribute("max"));
        var min = parseInt(slider.getAttribute("min"));
    }
    else{
        var max = -parseInt(slider.getAttribute("min"));
        var min = -parseInt(slider.getAttribute("max"));
    }
	if(time>=min){
		if(time<=max){
			this.timeMultiplier=time;
			this.updateInfo();
		} else {
			this.timeMultiplier=max;
			this.updateInfo();
			throw time+" is outside the time scaling range. Defaulted back to "+this.timeMultiplier;
		}
	} else {
		this.timeMultiplier=min;
		this.updateInfo();
		throw time+" is outside the time scaling range. Defaulted back to "+this.timeMultiplier;
	}
}

function incOrbit() {
    if(this.play){
        if(tick>=1000){
            console.log(obj);
        }
        for(n in bodies){
            obj=bodies[n];
            obj.setRots(obj.getRots()+((1/obj.rotationTime)*(tick/1000)*this.timeMultiplier));
            $.getElementById(obj.id).style.transform="rotate("+obj.getRots()*360+"deg)";
        }
		this.timeElapsed+=this.tick*this.timeMultiplier/1000;
		this.updateInfo();
    }
};

function updateInfo() {
	if(this.currentFocus!=null){
        $.getElementById("rotCounter").innerHTML=this.currentFocus.getRots().toFixed(4);
    } else {
        $.getElementById("rotCounter").innerHTML="";
    }
    $.getElementById("timeCounter").innerHTML=this.timeElapsed.toFixed(2);
	var slider = $.getElementById("timeSlider");
	slider.value=Math.abs(timeMultiplier);
	if(this.timeMultiplier===1||this.timeMultiplier===-1){
		units = " day/sec";
	} else {
		units = " days/sec";
	};
	$.getElementById("timeDilation").innerHTML=this.timeMultiplier+units;
};