// JavaScript Document

var Camera = function(canvas, depth, pos,rot){
	this.pos = pos || new Vector3D(0,0,0);
	this.rot = rot || new Vector3D(0,0,0);
	this.canvas = canvas;
	this.depth = depth || 350;
	this.screen = canvas.getContext("2d");
	this.height = canvas.height;
	this.width = canvas.width;
	this.offset = new Vector2D(canvas.width/2,canvas.height/2);
}

Camera.prototype = {
	clear: function(){
		this.screen.clearRect(0,0,this.canvas.width,this.canvas.height);
	}
}

var Renderer = function(camera, world){
	this.camera = camera;
	this.world = world;
	
	this.toDraw = [];
}

Renderer.prototype = {	
	drawVertices: function(){
		camera.clear();
		for(var i=0; i<world.vertices.length; i++){
			var vertex = world.vertices[i];
			
			var dr = vertex.pos.subtract(camera.pos);
			dr = dr.rotate(camera.rot);
			
			if(dr.z>0){
				var coords = vertex.getScreenPos(camera);
				var size = coords.z * 10;
				
				camera.screen.fillRect((coords.x-size/2),(coords.y-size/2),size,size);
			}
		  }
	},
	
	drawLines: function(){
		camera.clear();
		for(var i=0; i<world.lines.length; i++){
			var line = world.lines[i];
			var p1 = line.p1.getScreenPos(camera);
			var p2 = line.p2.getScreenPos(camera);
			if(p1 && p2){
				this.toDraw.push({
					'p1': p1,
					'p2': p2
					});
			}
		}
		
		this.toDraw.sort(function(a,b){
			return ((a.p1.z + a.p2.z)/2-(b.p1.z + b.p2.z)/2);
		});
		camera.screen.beginPath();
		for(var i=0; i<this.toDraw.length; i++){
			var l = this.toDraw[i];
			
			camera.screen.moveTo(l.p1.x, l.p1.y);
			camera.screen.lineTo(l.p2.x, l.p2.y);
			
		}
		camera.screen.stroke();
		this.toDraw = [];
	},
	
	drawTriangles: function(){
		camera.clear();
		for(var i = 0; i<world.triangles.length; i++){
			var triangle = world.triangles[i];
			if(typeof triangle.p1 == 'undefined' || typeof triangle.p2 == 'undefined' || typeof triangle.p3 == 'undefined'){continue;}
			var p1 = triangle.p1.getScreenPos(camera);
			var p2 = triangle.p2.getScreenPos(camera);
			var p3 = triangle.p3.getScreenPos(camera);
			if(p1 && p2 && p3){
				this.toDraw.push({
					'p1': p1,
					'p2': p2,
					'p3': p3,
					'color': triangle.color
					});
			}
		}
		
		this.toDraw.sort(function (a,b) {
			return ((a.p1.z + a.p2.z+a.p3.z)/3-(b.p1.z + b.p2.z + b.p3.z)/3);
		});
		
		for(var i=0; i<this.toDraw.length; i++){
			var l = this.toDraw[i];
			camera.screen.beginPath();
			camera.screen.fillStyle = l.color;
			camera.screen.moveTo(l.p1.x, l.p1.y);
			camera.screen.lineTo(l.p2.x, l.p2.y);
			camera.screen.lineTo(l.p3.x, l.p3.y);
			camera.screen.stroke();
			camera.screen.fill();
		}
		
		this.toDraw = [];
	}
}

var Vertex = function(pos){
	this.pos = pos;
}

Vertex.prototype = {
	getScreenPos: function(camera){			
		var dr = this.pos.subtract(camera.pos);
		dr = dr.rotate(camera.rot);
		
		if(dr.z>0){
			var scale = camera.depth / dr.z;
			var posX = scale * dr.x + camera.offset.x;
			var posY = scale * dr.y + camera.offset.y;
			
			return new Vector3D(posX,posY,scale);
		}
		else {
			return null;
		}
	}
}

var Line = function(p1,p2){
	this.p1 = p1;
	this.p2 = p2;
}

Line.prototype = {
	
}

var Vector3D = function(x,y,z){
	this.x = x;
	this.y = y;
	this.z = z;
	
	Vector3D.average = function(vects){
		var x = 0;
		var y = 0;
		var z = 0;
		for(var i=0;i<vects.length;i++){
			x += vects[i].x;
			y += vects[i].y;
			z += vects[i].z;
		}
		x /= vects.length;
		y /= vects.length;
		z /= vects.length;
		return new Vector3D(x,y,z);
	}
}

Vector3D.prototype = {
	dist: function(vec2){
		return Math.sqrt(distSquared(vec2));
	},
	
	distSquared: function(vec2){
		return Math.pow(this.x-vec2.x,2)+Math.pow(this.y-vec2.y,2)+Math.pow(this.z-vec2.z);
	},
	
	subtract: function(vec2){
		return new Vector3D(this.x-vec2.x,this.y-vec2.y,this.z-vec2.z);
	},
	
	add: function(vec2){
		return new Vector3D(this.x+vec2.x,this.y+vec2.y,this.z+vec2.z);
	},
	
	negate: function(){
		return new Vector3D(-this.x,-this.y,-this.z);
	},
	
	rotate: function(rotVec){
		var d = new Vector3D(this.x,Math.cos(rotVec.x)*this.y-Math.sin(rotVec.x)*this.z,Math.cos(rotVec.x)*this.z + Math.sin(rotVec.x)*this.y);
		d = new Vector3D(Math.cos(rotVec.y)*d.x + Math.sin(rotVec.y)*d.z,d.y,Math.cos(rotVec.y)*d.z - Math.sin(rotVec.y)*d.x);
		return new Vector3D(Math.cos(rotVec.z)*d.x + Math.sin(rotVec.z)*d.y,Math.cos(rotVec.z)*d.y - Math.sin(rotVec.z)*d.x,d.z);
	},
	
	cross: function(vec2){
		return new Vector3D(this.y*vec2.z-this.z*vec2.y,this.z*vec2.x-this.x*vec2.z,this.x*vec2.y-this.y*vec2.x);
	},
	
	dot: function(vec2){
		return this.x*vec2.x+this.y*vec2.y+this.z*vec2.z;
	}
}

var Vector2D = function(x,y){
	this.x = x;
	this.y = y;
}

Vector2D.prototype = {
	dist: function(vec2){
		return Math.sqrt(distSquared(vec2));
	},
	
	distSquared: function(vec2){
		return Math.pow(this.x-vec2.x,2)+Math.pow(this.y-vec2.y,2);
	},
	
	length: function(){
		return dist(this);
	},
	
	lengthSquared: function(){
		return distSquared(this);
	}
}

var World = function(points, lines, polygons, lights){
	this.vertices = points;
	this.lines = lines;
	this.triangles = polygons;
	this.lights = lights;
}

World.prototype = {
	
}

var Triangle = function(p1,p2,p3,color){
	this.p1 = p1;
	this.p2 = p2;
	this.p3 = p3;
	this.color = color;
}

Triangle.prototype = {
	getNormalVect: function(){
		var v1 = this.p1.subtract(this.p2);
		var v2 = this.p3.subtract(this.p2);
		return v1.cross(v2);
	},
	
	getCameraVector: function(camera){
		return camera.pos.subtract(Vector3D.average([v1,v2]));
	},
	
	maxX: function(){
		return Math.max(this.p1.pos.x,this.p2.pos.x,this.p3.pos.x);
	},
	
	maxY: function(){
		return Math.max(this.p1.pos.y,this.p2.pos.y,this.p3.pos.y);
	},
	
	maxZ: function(){
		return Math.max(this.p1.pos.z,this.p2.pos.z,this.p3.pos.z);
	}
}