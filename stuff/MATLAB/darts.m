function [fig,cat]=darts(num,area)
% darts(num,area) - takes an optional number and area and returns the
%                   category to which it belongs. Also generates a
%                   categorized dart board
% inputs:
%   num = number of section on dart board (1-20)
%   area = area of that section ('Single','Double','Triple')
% outputs:
%   fig = figure containing the dart board image
%   cat = category of the board that the dart is in

    global categories = [{'Read'},{'Study'},{'Brain Games'},{'Clean'}];
    global colors = ['r','b','g','y'];
    global sect;
    
    figure;
    set(gcf,'Position',[180 302 1063 518]);
    set(gca,'Visible','off');
    hold on;
    for i=1:20
        n=floor(rand*1000);
        sect(i)=struct('Single',colors(mod(n,4)+1),...
            'Double',colors(mod(n+1,4)+1),...
            'Triple',colors(mod(n+2,4)+1));
        circles(18*i+9,18*i-9,1,sect(i).Double);
        circles(18*i+9,18*i-9,.9,sect(i).Single);
        circles(18*i+9,18*i-9,.6,sect(i).Triple);
        circles(18*i+9,18*i-9,.5,sect(i).Single);
    end
    circles(0,360,.1,'m');
    circles(0,360,.05,'c');
    set(gca,'XLim',[-1 2]);
    for i=1:4
        text(1.31,1.05-.15*i,categories(i),'BackgroundColor',colors(i));
    end
    hold off;
    
end

function P = circles(t1,t2,r,color)
%makes an arc with the specified color
    t = linspace(deg2rad(t1),deg2rad(t2));
    x = r*cos(t);
    y = r*sin(t);
    x = [x 0 x(1)];
    y = [y 0 y(1)];
    P = fill(x,y,color);
    axis([-r-1 r+1 -r-1 r+1]) 
    axis square;
    if ~nargout
        clear P
    end
end

function C = getCat(num,area)
% gets the category for a given section number and area on baord

    if strcmpi(area,'Single')
        
    elseif strcmpi(area,'Double')
        
    elseif strcmpi(area,'Triple')
        
    else
        
    end