//Graph stuff

this.Graph = function(cvs)
{
    Graph.id_num = 0;
    var paths = [];
    var data = [];
    var fcns = [];
    window.bStoreData = true;
    canvas = cvs;
    
    var axes_cvs = document.createElement("canvas");
    canvas.parentNode.appendChild(axes_cvs);
    axes_cvs.style.position = canvas.style.position;
    axes_cvs.style.zIndex = canvas.style.zIndex + 1;
    axes_cvs.style.top = canvas.style.top;
    axes_cvs.style.left = canvas.style.left;
    axes_cvs.style.width = canvas.style.width;
    axes_cvs.style.height = canvas.style.height;
	
    var div = document.createElement("div");
    canvas.parentNode.appendChild(div);
    div.style.position = canvas.style.position;
    div.style.top = canvas.style.top;
    div.style.left = canvas.style.left;
    div.style.width = canvas.style.width;
    div.style.height = canvas.style.height;
    div.style.zIndex = axes_cvs.style.zIndex + 1;
    div.style.opacity = 0;
    
    var ctx = canvas.getContext("2d");
    ctx.globalCompositeOperation = 'screen';
    var xmin = -10;
    var xmax = 10;
    var ymin = -10;
    var ymax = 10;

    var drawGrid = function drawGrid()
    {
        var path = new Path2D();
        var prevLineStyle = gCtx.lineStyle;
        ctx.lineStyle = '#111111';
        for(var i = 1; i<=10; i++)
        {
            paths.moveTo(i*gCtx.width/10, 0);
            paths.lineTo(i*gCtx.width/10, gCtx.height);
        }
        
        for(var i = 1; i<=10; i++)
        {
            paths.moveTo(0, i*gCtx.width/10);
            paths.lineTo(gCtx.width, i*gCtx.width/10);
        }
        
        paths[paths.length] = path;
    }
    
    function drawData(dat, args)
    {
        var i, pix, points = dat, color = "#000000", bStore = true;
        
        if(dat instanceof fData)
        {
            points = dat.data;
            color = dat.color;
        }
        
        for(prop in args)
        {
            switch(prop)
            {
                case 'color':
                    color = args[prop];
                    break;
                case 'bStore':
                    bStore = args[prop];
                    break;
            }
        }
        
        points.sort(function(a, b){return a.x - b.x});
        
        pix = pointToPixel(points[0].x,points[0].y);
        
        ctx.beginPath();
		ctx.moveTo(pix.x,pix.y);
		for(i = 1; i < points.length; i++)
		{
            pix = pointToPixel(points[i].x,points[i].y);
			ctx.lineTo(pix.x,pix.y);
		}
        
        ctx.strokeStyle = color;
        
        ctx.stroke();
        ctx.stroke();
        ctx.stroke();
        ctx.closePath();
        
        if(bStore === undefined || bStore === null ||bStore)
        {
            data[data.length] = new fData(points, color);
        }
    }
    this.drawData = drawData;
    
    function drawFcn(func, args)
    {
        var i, n = 10000, fcn = func, x = new Array(n), color = "#000000", xlims = [], bStore = true, params = [0];
        
        if(func instanceof fFunc){
            fcn = func.func;
            color = func.color;
            xlims = func.xlims;
            Array.prototype.push.apply(params,func.params);
        }
        
        for(prop in args)
        {
            switch(prop)
            {
                case 'color':
                    color = args[prop];
                    break;
                case 'xlims':
                    if(args[prop].length == 2)
                    {
                        xlims = args[prop];
                    }
                    break;
                case 'bStore':
                    bStore = args[prop];
                    break;
                case 'params':
                    Array.prototype.push.apply(params,args[prop]);
                    break;
            }
        }
        
        for(i=0;i<n;i++)
        {
            if(xlims.length > 0)
            {
                x[i] = (xlims[1]-xlims[0])*i/n + xlims[0];
            }
            else
            {
                x[i] = (xmax-xmin)*i/n + xmin;
            }
        }
        
        var data = new Array(n)

        for(i=0;i<n;i++)
        {
            params[0] = x[i];
            data[i] = new Point2D(x[i], fcn.apply(this||window,params));
        }
        
        if(bStore === undefined || bStore === null || bStore)
        {
            params.shift();
            fcns[fcns.length] = new fFunc(fcn,color,xlims,params);
        }
        
        drawData(data, {'bStore': false, 'color': color});
    }
    
    this.drawFcn = drawFcn;
    
    function pixelToPoint(x, y)
    {
		axis = String.toLower(axis);
		
		switch (axis)
		{
		    case 'x':
				var xPnt = xmin+(x-.5)*((xmax-xmin)/gCanvas.width);
				break;
			case 'y':
				var yPnt = ymin+(gCanvas.height-(y-.5))*((ymax-ymin)/gCanvas.height);
		}

        return (new Point2D(xPnt, yPnt));
    }

    function pointToPixel(x,y)
    {
            var xPix = canvas.width*(x-xmin)/(xmax-xmin)+.5;
            var yPix = canvas.height*(1-(y-ymin)/(ymax-ymin))+.5;

        return (new Point2D(xPix,yPix));
    }
    
    function clearGraph()
    {
        ctx.clearRect(0,0,canvas.width,canvas.height);
        
        data = [];
        fcns = [];
        
        refreshGraph();
    }
    this.clearGraph = clearGraph;
    
    function clearFcns()
    {
        ctx.clearRect(0,0,canvas.width,canvas.height);
        
        fcns = [];
        
        refreshGraph();
    }
    this.clearFcns = clearFcns;
    
    function clearData()
    {
        ctx.clearRect(0,0,canvas.width,canvas.height);
        
        data = [];
        
        refreshGraph();
    }
    this.clearData = clearData;
    
    this.getCanvas = function()
    {
        return canvas;
    }
    
    this.getContext = function()
    {
        return ctx;
    }

    this.getAxesCanvas = function()
    {
        return axes_cvs;
    }

    this.getXLims = function()
    {
        return [xmin, xmax];
    }
    
    this.getYLims = function()
    {
        return [ymin, ymax];
    }
    
    this.getFcns = function()
    {
        return fcns;
    }
    
    this.getData = function()
    {
        return data;
    }
    
    function drawAxes()
    {
        var actx = axes_cvs.getContext("2d");
        
        actx.clearRect(0,0,axes_cvs.width,axes_cvs.height);
        
        origin = pointToPixel(0,0);
        
        actx.beginPath();
        actx.moveTo(origin.x, 0);
		actx.lineTo(origin.x, canvas.height);

		actx.moveTo(0, origin.y);
		actx.lineTo(canvas.width, origin.y);
        actx.strokeStyle = "#000000";
        actx.lineWidth = 1;
		actx.stroke();
        actx.closePath();
    }

    function refreshGraph(){
        ctx.clearRect(0,0,canvas.width,canvas.height);
        
        for(i = 0; i<data.length; i++)
        {
            drawData(data[i],{'bStore':false});
        }
        
        for(i = 0; i<fcns.length; i++)
        {
            drawFcn(fcns[i],{'bStore':false});
        }
    }
    
    this.refreshGraph = refreshGraph;
    
    this.setXLims = function(min, max)
    {
		xmin = min;
		xmax = max;
        
        drawAxes();
    }

    this.setYLims = function(min, max)
    {
		ymin = min;
		ymax = max;
        
        drawAxes();
    }
    
    drawAxes();
};

function Point2D(x, y)
{
    this.x = x;
    this.y = y;
};

function fFunc(func, color, xlims, params)
{
    this.func = func;
    this.color = color;
    this.xlims = xlims;
    this.params = params;
}

function fData(data, color)
{
    this.data = data;
    this.color = color;
}
/*
function simple_sort(xdata,ydata)
{
    for (i=0; i < xdata.length; i++)
    {
        for (j=1; j < xdata.length; j++)
        {
            if(xdata[i]<xdata[j])
            {
                this.temp = xdata[i];
                xdata[i] = xdata[j];
                xdata[j] = temp;
                
                this.temp = ydata[i];
                ydata[i] = ydata[j];
                ydata[j] = temp;
            }
        }
    }
    
    return;
}
*/