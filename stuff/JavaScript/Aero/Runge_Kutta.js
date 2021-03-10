var RungeKuttaSolver = (function () {
	function solver(odefun, tspan, y0) {
		if(!Array.isArray(tspan) || tspan.length < 2) {
			throw 'tspan must be an array of length two';
		}
		var dt = (tspan[1] - tspan[0]) / 1000;
		if(dt <= 0) {
			throw 't_max must be greater than t0.';
		}
		console.log('dt');
		console.log(dt);
		var values = [];
		
		
		var t = tspan[0];
		
		var initial = [];
		initial.unshift.apply(initial, y0);
		initial.unshift(t);
		values[0] = initial;
		
		while(t <= tspan[1]) {
			var next = Runge_Kutta4(odefun, dt, t, values[values.length-1].slice(1));
			values[values.length] = next;
			
			t = next[0];
		}
		
		return values;
	}

	function Runge_Kutta4(dydx_func, h, x_prev, y_prev) {
		
		k_1 = dydx_func(x_prev, y_prev);
		k_2 = dydx_func(x_prev + 0.5 * h, array_add(y_prev, array_multiply(k_1, 0.5*h)));
		k_3 = dydx_func(x_prev + 0.5 * h, array_add(y_prev, array_multiply(k_2, 0.5*h)));
		k_4 = dydx_func(x_prev + h, array_add(y_prev, array_multiply(k_3, h)));
		
		var y = array_add(y_prev, array_multiply(array_add(k_1, array_multiply(k_2,2), array_multiply(k_3,2), k_4), 1/6 * h));
		
		var next = [];
		next.unshift.apply(next, y);
		next.unshift(x_prev + h);
		
		return next;
	}
	
	function array_multiply(arr, k) {
		var results = [];
		for(var i=0;i < arr.length; i++) {
			results[i] = arr[i]*k;
		}
		
		return results;
	}
	
	function array_add() {
		var c = [];
		for(var i=0;i < arguments[0].length; i++) {
			c[i] = 0;
			for(var j=0;j < arguments.length; j++) {
				c[i] += arguments[j][i];
			}
		}
		
		return c;
	}
	
	return solver;
})();