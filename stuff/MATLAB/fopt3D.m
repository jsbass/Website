function [result,foptimum,fig] = fopt3D(t_x,t_y,t_z)
% given the 2D target location optimizes the initial velocity and angle
% to minimize enrgy usage

param.g=-9.81;
param.m=1;
param.x=t_x;
param.y=t_y;
param.z=t_z;

p0 = [10 50 45 45];             % p = [t v theta phi]
A = []; b = [];
Aeq = []; beq = [];
LB = [0 -Inf 0 0];
UB = [Inf Inf 360 360];
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
    t = p(1); v = p(2); theta = p(3); phi = p(4);
    x = v*sin(deg2rad(phi))*cos(deg2rad(theta))*t;
    y = v*sin(deg2rad(phi))*sin(deg2rad(theta))*t;
    z = v*cos(deg2rad(phi))*t+.5*param.g*t^2;
    ceq = [param.x-x;param.y-y;param.z-z];
end

function fig = plot_traj(result,param)
    fig = figure('Units','pixels',...
        'Position',[400 200 900 600]);
    ha = axes('Units','pixels',...
        'Position',[50 50 500 500],...
        'CameraPosition',[1000 0 1000],...
        'CameraTarget',[500 500 500]);
    demo_axes = axes('Units','pixels',...
        'Position',[650 50 200 200],...
        'CameraPosition',[1 0 1],...
        'CameraTarget',[.5 .5 .5]);
    h_t_text = uicontrol('Style','text',...
        'Units','pixels',...
        'Position',[650 500 80 30]);
    h_v_text = uicontrol('Style','text',...
        'Units','pixels',...
        'Position',[650 465 80 30]);
    h_theta_text = uicontrol('Style','text',...
        'Units','pixels',...
        'Position',[650 430 80 30]);
    h_phi_text = uicontrol('Style','text',...
        'Units','pixels',...
        'Position',[650 395 80 30]);
    t_max = result(1);v=result(2);theta=result(3);phi=result(4);
    t = linspace(0,t_max,1000);
    x = @(t) v*sin(deg2rad(phi))*cos(deg2rad(theta)).*t;
    y = @(t) v*sin(deg2rad(phi))*sin(deg2rad(theta)).*t;
    z = @(t) v*cos(deg2rad(phi)).*t+.5*param.g.*t.^2;
    axes(ha);
    hold on;
    plot3(ha,x(t),y(t),z(t));
    plot3(ha,x(t_max),y(t_max),z(t_max),'Marker','*','Color','g');
    plot3(ha,param.x,param.y,param.z,'Marker','*','Color','r');
    plot3(ha,x(t),y(t),0.*t,'LineStyle',':','Color','k');
    legend('Flight Path',...
        ['End Point: (' num2str(x(t_max)) ',' num2str(y(t_max)) ',' ...
            num2str(z(t_max)) ')'],...
        ['Target: (' num2str(param.x) ',' num2str(param.y) ',' ...
            num2str(param.z) ')']);
    axis([0 1000 0 1000 0 1000]);
    hold off;
    axes(demo_axes);
    hold on;
    line = plot3(linspace(0,1,100),...
        linspace(0,1,100),...
        linspace(0,1,100),...
        'Color','k','DisplayName','v0');
    plot3(linspace(0,1,100),...
        linspace(0,1,100),...
        linspace(0,0,100),...
        'Color','k','LineStyle',':');
    t_arc = plot_arc(gca,.5,[0 45],[90 90],'r','theta');
    p_arc = plot_arc(gca,.5,[45 45],[0 45],'b','phi');
    legend([line t_arc p_arc],{'v0','theta','phi'});
    hold off;
    set(h_t_text,'String',['Flight Time: ' num2str(t_max) ' s']);
    set(h_v_text,'String',['Initial Velocity: ' num2str(v) ' m/s']);
    set(h_theta_text,'String',...
        ['theta: ' num2str(theta) ' degrees']);
    set(h_phi_text,'String',['phi: ' num2str(phi) ' degrees']);
end

function ha = plot_arc(h,r,theta,phi,color,name)
    t = linspace(theta(1),theta(2),1000);
    p = linspace(phi(1),phi(2),1000);
    x = r.*sin(deg2rad(p)).*cos(deg2rad(t));
    y = r.*sin(deg2rad(p)).*sin(deg2rad(t));
    z = r.*cos(deg2rad(p));
    ha = plot3(h,x,y,z,'Color',color,'DisplayName',name);
end
