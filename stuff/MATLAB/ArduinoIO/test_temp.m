function [T,V,R,Temp,D] = test_temp(a,inputPin,vSource,r0,r3)
% [T,V,R,Temp,D] = test_temp(a,inputPin,vSource,r0,r3)
% test_temp(a,inputPin,vSource,r0) - opens a GUI for collecting data
% with a thermistor using an arduino

if(~(exist('a','var')&&isa(a,'arduino')&&isvalid(a)))
    error('The input must be a valid arduino object');
end

switch(nargin)
    case 1
        inputPin = 14;
        vSource = 5;
        r0 = 100;
        fprintf('No input for the input pin number. Defaulting to 14\n');
        fprintf('No input for the voltage range. Defaulting to 5\n');
        fprintf('No input for the resistance range. Defaulting to 100\n');
    case 2
        vSource = 5;
        r0 = 100;
        fprintf('No input for the voltage range. Defaulting to 5\n');
        fprintf('No input for the resistance range. Defaulting to 100\n');
    case 3
        r0 = 100;
        fprintf('No input for the resistance range. Defaulting to 100\n');
end

    %resolution contant
    res = 1024;
    
    %set the input pin as an input
    a.pinMode(inputPin,'input');
    
    %thermistor constants
    A1=3.354016e-3;
    B1=2.569850e-4;
    C1=2.620131e-6;
    D1=6.383091e-8;
    
    %start timer
    t_offset = 0;
    collectTime = tic;
    
    %initialize all of the output arrays
    t = toc(collectTime)+t_offset;
    V = []; R = []; T = []; Temp = []; D = [];
    [v,r,d,temp] = getData();
    V = [V,v]; R = [R,r]; T = [T,t]; Temp = [Temp,temp]; D = [D,d];
    
    %make a new figure and set properties
    fig = figure('Position',[360,500,450,285]);
    ha = axes('Units','pixels','Position',[50,60,200,185]);
    set(ha,'YLimMode','manual');
    set(ha,'YLim',[0,5]);
    plot(ha,T,V,'XDataSource','T','YDataSource','V');
    
    xlabel('Time (s)');
    ylabel('Voltage (V)');
    
    %makes the stop button and displays
    
    vLabel = uicontrol('Style','text',...
        'String','Voltage (V)',...
        'Position',[325,220,100,15]);
    vBox = uicontrol('Style','edit',...
        'Position',[315,200,100,15],...
        'HorizontalAlignment','right');
    rLabel  = uicontrol('Style','text',...
        'String','Resistance (Ohm)',...
        'Position',[325,180,100,15]);
    rBox = uicontrol('Style','edit',...
        'Position',[315,160,100,15],...
        'HorizontalAlignment','right');
    tempLabel = uicontrol('Style','text',...
        'String','Temp (F)',...
        'Position',[325,140,100,15]);
    tempBox = uicontrol('Style','edit',...
        'Position',[315,120,100,15],...
        'HorizontalAlignment','right');
    tLabel = uicontrol('Style','text',...
        'String','Time (s)',...
        'Position',[325,100,100,15]);
    tBox = uicontrol('Style','edit',...
        'Position',[315,80,100,15],...
        'HorizontalAlignment','right');
    StopButton = uicontrol('Style','pushbutton',...
        'String','Stop',...
        'Position',[325,60,100,25],...
        'UserData',1,...
        'Callback',@exitClick);
    PauseButton = uicontrol('Style','pushbutton',...
        'String','Pause',...
        'Position',[325,40,100,25],...
        'UserData',0,...
        'Callback',{@pauseClick,StopButton});
    align([vLabel,vBox,rLabel,rBox,tBox,tLabel,StopButton,...
        tempLabel,tempBox,PauseButton],'Left','Fixed',5);
    movegui('center');

    while(get(StopButton,'UserData')&&ishandle(fig))
        %get time
        t = toc(collectTime)+t_offset;
        %get data
        [v,r,d,temp] = getData();
        %update arrays
        V = [V,v]; R = [R,r]; T = [T,t]; Temp = [Temp,temp]; D = [D,d];
        %update gui
        set(vBox,'String',v);
        set(rBox,'String',sprintf('%f',r));
        set(tBox,'String',t);
        set(tempBox,'String',temp);
        plot(T,Temp);
        pause(.001);
    end

    close(fig)
    
    %Reads raw data and calculates values
    function [v,r,d,temp] = getData()
        d = a.analogRead(inputPin);
        v = vSource*d/(res-1);
        r = r3/(vSource/v-1);
       %fprintf('r=%1.3g,A=%1.3g,B=%1.3g,C=%1.3g,D=%1.3g\n',r,A1,B1,C1,D1);
        temp = (A1+B1*log(r/r0)+C1*log(r/r0)^2+D1*log(r/r0)^3)^(-1);
        temp = (temp-273)*9/5+32;
    end

    %Stops Button is pressed
    function [] = exitClick(source,~)
        set(source,'UserData',0);
    end

    %Pause Button is pressed
    function [] = pauseClick(source,~,eBut)
        if(get(source,'UserData'))
            fprintf('unpaused\n');
            set(source,'UserData',0);
        else
            fprintf('paused\n');
            set(source,'UserData',1);
            pauseCol(source,eBut);
        end
    end

    %pauses playback
    function [] = pauseCol(pBut,eBut)
        set(pBut,'String','Paused')
        pauseTimer = tic;
        while(get(pBut,'UserData')&&get(eBut,'UserData')&&toc(pauseTimer)<10)
            drawnow;
        end
        t_offset = T(length(T));
        collectTime = tic;
        set(pBut,'String','Pause');
    end

    %when user exits figure
    function [] = exitFig()
        set(StopButton,'UserData',0);
    end
end
        