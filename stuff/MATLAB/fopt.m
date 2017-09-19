function [result,foptimum,fig] = fopt(t_x,t_y)
% function [results,foptimum, fig] = fopt(t_x,t_y)
% given the 2D target location optimizes the initial velocity and angle
% to minimize enrgy usage

param.g=-9.81;
param.m=1;
param.x=t_x;
param.y=t_y;

p0 = [10 50 45 45];             % p = [t v theta]
A = []; b = [];
Aeq = []; beq = [];
LB = [0 -Inf 0];
UB = [Inf Inf 360];
options = [];

[result,foptimum]=fmincon(@func,p0,A,b,Aeq,beq,LB,UB,@cons,options,...
    param);

fig = plot_traj(result,param);

end

function E = func(p,param)
    v = p(2);
    E = .5*param.m*v^2;
end

function [cineq,ceq] = cons(p,param)
    cineq = [];
    t = p(1); v = p(2); theta = p(3);
    x = v*cos(deg2rad(theta))*t;
    y = v*sin(deg2rad(theta))*t+.5*param.g*t^2;
    ceq = [param.x-x;param.y-y];
end

function fig = plot_traj(result,param)
    fig = figure('Units','pixels',...
        'Position',[400 200 900 600]);
    ha = axes('Units','pixels',...
        'Position',[50 50 500 500]);
    demo_axes = axes('Units','pixels',...
        'Position',[650 50 200 200]);
    h_t_text = uicontrol('Style','text',...
        'Units','pixels',...
        'Position',[650 500 80 30]);
    h_v_text = uicontrol('Style','text',...
        'Units','pixels',...
        'Position',[650 465 80 30]);
    h_theta_text = uicontrol('Style','text',...
        'Units','pixels',...
        'Position',[650 430 80 30]);
    t_max = result(1);v=result(2);theta=result(3);
    t = linspace(0,t_max,1000);
    x = @(t) v*cos(deg2rad(theta)).*t;
    y = @(t) v*sin(deg2rad(theta)).*t+.5*param.g.*t.^2;
    axes(ha);
    hold on;
    plot(ha,x(t),y(t));
    plot(ha,x(t_max),y(t_max),'Marker','*','Color','g');
    plot(ha,param.x,param.y,'Marker','*','Color','r');
    legend('Flight Path',...
        ['End Point: (' num2str(x(t_max)) ',' num2str(y(t_max)) ')'],...
        ['Target: (' num2str(param.x) ',' num2str(param.y) ')']);
    axis([0 1000 0 1000 0 1000]);
    hold off;
    axes(demo_axes);
    hold on;
    line = plot(linspace(0,1,100),...
        linspace(0,1,100),...
        'Color','k','DisplayName','v0');
    t_arc = plot_arc(gca,.5,[0 45],'r','theta');
    legend([line t_arc],{'v0','theta'});
    hold off;
    set(h_t_text,'String',['Flight Time: ' num2str(t_max) ' s']);
    set(h_v_text,'String',['Initial Velocity: ' num2str(v) ' m/s']);
    set(h_theta_text,'String',...
        ['theta: ' num2str(theta) ' degrees']);
    movegui('center');
end

function ha = plot_arc(h,r,theta,color,name)
    t = linspace(theta(1),theta(2),1000);
    x = r.*cos(deg2rad(t));
    y = r.*sin(deg2rad(t));
    ha = plot(h,x,y,'Color',color,'DisplayName',name);
end
