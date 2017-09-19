x = @(r,theta) r.*cos(deg2rad(theta))-36;
y = @(r,theta) 6.5+r.*sin(deg2rad(theta));
[h, cVec] = colorScatter(x(r,theta),y(r,theta),q,20,figure(),false);
plotEllipse(36,24,[0 0],h);
xlabel('x location (in.)');
ylabel('y location (in.)');
line([-40 40],[0 0],'Color','k');
line([0 0],[-30 30],'Color','k');