/*
	Conversion factors:
		lenght is in km
		mass is in kg
		time is in s
		(0,0) is the center of the screen
*/

//Constants Used
var G = 66.73*10^-12;

function planet(pName,mass,r0,v0){
	var name = pName;
	var m = mass;
	var r = r0;
	var th = 0;
	var v = v0;
	var eps = null;
	
	this.calcEps = function(M){
		eps = (r0*v0^2)/(G*M)-1;
	};
	
	this.calcCoords(t){
		
	};
	
	this.getCartesian = function(){
		var x = this.r*Math.cos(th);
		var y = this.r*Math.sin(th);
		
		return [x,y];
	};
    
	this.getName = function(){
		return name;
	};
	
	this.setName = function(){
		return name;
	};
	
    this.getMass = function(){
        return m;
    };
    
    this.setMass = function(mass){
        m = mass;
    };
    
    this.getRadius = function() {
        return r;
    };
    
    this.setRadius = function(radius){
        r = radius;
    };
    
    this.getTheta = function(){
        return r;
    };
    
    this.setTheta = function(theta){
        th = theta;
    };
    
    this.getVRadius = function(){
        return vr;
    };
    
    this.setVRadius = function(v){
        vr = v;
    };
    
    this.getVTheta = function(){
        return vth;
    };
    
    this.setVTheta(v){
        vth = v;
    };
	
	this.setEps(starMass){
		eps = r*vth
	}
};

function star(mass){S
	var m = mass;
	
	this.getMass = function(){
		return m;
	};
    
    this.setMass = function(mass){
        m = mass;
    };
};

function system(planetArray,centerStar){

	var planets = planetArray;
	var star = centerStar;
	
	for planet in planetArray{
		planet.calcMotion(centerStar.getMass());
	};
	
	this.calculateStep = function(intTime, planet){
		planets[planet.getName()]
	};
};

$(document).ready(function (){
	
});