function calc_gamma(points, alpha) {
	if(points[0].x != points[points.length-1].x || points[0].y != points[points.length-1].y) {
		throw "points must form closed shape";
	}
	
	//convert to panels for ease of calculation
	var panels = [];
	for(var i=0;i<points.length-1;i++) {
		panels[i] = new panel(points[i].x, points[i].y, points[i+1].x, points[i+1].y);
	}
	console.log('panels', panels);
	
	//calculate Cw Matrix
	var An = [];
	var At = [];
	var Cn1 = [];
	var Cn2 = [];
	var Ct1 = [];
	var Ct2 = [];
	var RHS = [];
	for(var i=0;i<panels.length;i++) {
		An[i] = [];
		At[i] = [];
		Cn1[i] = [];
		Cn2[i] = [];
		Ct1[i] = [];
		Ct2[i] = [];
		for(var j=0;j<panels.length;j++) {
			if(i==j) {
				Cn1[i][j] = -1;
				Cn2[i][j] = 1;
				Ct1[i][j] = Math.PI/2;
				Ct2[i][j] = Math.PI/2;
			} else {
				var A = -(panels[i].c_x - panels[j].x)*Math.cos(panels[j].theta) - (panels[i].c_y - panels[j].y)*Math.sin(panels[j].theta);
                var B = Math.pow(panels[i].c_x - panels[j].x, 2) + Math.pow(panels[i].c_y - panels[j].y, 2);
                var C = Math.sin(panels[i].theta - panels[j].theta);
                var D = Math.cos(panels[i].theta - panels[j].theta);
                var E = (panels[i].c_x - panels[j].x)*Math.sin(panels[j].theta) - (panels[i].c_y - panels[j].y)*Math.cos(panels[j].theta);
                var F = Math.log(1+panels[j].l*(panels[j].l+2*A)/B);
                var G = Math.atan2((E*panels[j].l),(B+A*panels[j].l));
                var P =
					(panels[i].c_x - panels[j].x)*Math.sin(panels[i].theta - 2*panels[j].theta)
					+ (panels[i].c_y - panels[j].y)*Math.cos(panels[i].theta - 2*panels[j].theta);
                var Q =
					(panels[i].c_x - panels[j].x)*Math.cos(panels[i].theta - 2*panels[j].theta)
					- (panels[i].c_y - panels[j].y)*Math.sin(panels[i].theta - 2*panels[j].theta);
				Cn2[i][j] = D + 0.5*Q*F/panels[j].l - (A*C + D*E)*G/panels[j].l;
				Cn1[i][j] = 0.5*D*F + C*G - Cn2[i][j];
				Ct2[i][j] = C + 0.5*P*F/panels[j].l + (A*D - C*E)*G/panels[j].l;
				Ct1[i][j] = 0.5*C*F - D*G - Ct2[i][j];
			}
		}
		
		An[i][0] = Cn1[i][0];
		An[i][panels.length] = Cn2[i][panels.length-1];
		At[i][0] = Ct1[i][0];
		At[i][panels.length] = Ct2[i][panels.length-1];
		
		for(var j=1;j<panels.length;j++) {
			An[i][j] = Cn1[i][j] + Cn2[i][j-1];
			At[i][j] = Ct1[i][j] + Ct2[i][j-1];
		}
		RHS[i] = Math.sin(panels[i].theta - alpha);
	}
	
	An[panels.length] = [];
	//Add row for Kutta condition
	An[panels.length][0] = 1;
	for(var j=1;j<panels.length;j++) {
		An[panels.length][j] = 0;
	}
	An[panels.length][panels.length] = 1;
	RHS[panels.length] = 0;
	
	
	console.log('An', An);
	//console.log('At', At);
	//Solve An*Gamma = RHS
	//Gamma = RHS*A^-1
	var Gamma = math.usolve(math.transpose(An), RHS);
	
	var c_l = 0;
	var c_d = 0;
	//calc Vd, Cp, c_l
	for(var i=0;i<panels.length;i++) {
		var sum = 0;
		for(var j=0;j<panels.length+1;j++) {
			sum += At[i][j]*Gamma[j];
		}
		
		panels[i].V = Math.cos(panels[i].theta - alpha) + sum;
		panels[i].Cp = 1 - Math.pow(panels[i].V, 2);
		c_l += panels[i].Cp*panels[i].l*Math.cos(panels[i].theta-alpha);
		c_d += panels[i].Cp*panels[i].l*Math.sin(panels[i].theta-alpha);
	}
	return {
		panels: panels,
		gamma: Gamma,
		An: An,
		At: At,
		c_l: c_l,
		c_d: c_d,
		aoa: alpha,
		RHS: RHS
	}
}

var panel = function(x1, y1, x2, y2) {
	this.x = x1;
	this.y = y1;
	this.x2 = x2;
	this.y2 = y2;
	this.c_x = (this.x2+this.x)/2;
	this.c_y = (this.y2+this.y)/2;
	this.l = Math.sqrt(Math.pow(this.x-this.x2,2)+Math.pow(this.y-this.y2,2));
	this.theta = Math.atan2(this.y2 - this.y, this.x2-this.x);
}