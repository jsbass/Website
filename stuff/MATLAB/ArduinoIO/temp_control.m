function [T,V,R,Temp,D] = temp_control(a)
% [T,V,R,Temp,D] = temp_control(a)
% potentiometer(a) - opens a GUI for collecting temperatur data on an
%   arduino
% inputs:
%   a = arduino object
%
% Values needed:
%   temperature input pin number
%   fan output pin number
%   light output pin number
%   thermistor source voltage
%   voltage divider static resistor
%   R25 thermistor value
%   thermistor coefficients (A1,B1,C1,D1)
%   fan speed
%   fan switch temperature
if(~(exist('a','var')&&isa(a,'arduino')&&isvalid(a)))
    error('The input must be a valid arduino object');
end

tempPin = 14;
fanPin = 3;
lightPin=2;
vSource = 5;
r1 = 10000;
r25 = 10000;
A1=3.354016e-3;
B1=2.569850e-4;
C1=2.620131e-6;
D1=6.383091e-8;
K = 255;
uprTemp = 85;
lwrTemp = 75;

    %resolution contant
    res = 1024;
    
    %graph domain and range
    xlim = [0,10];
    ylim = [50 125];
    
    %set the temp pin as an input
    a.pinMode(tempPin,'Input');
    
    %set the fan and light pin as an out
    a.pinMode(fanPin,'Output');
    a.pinMode(lightPin,'Output');
    
    %make figure
    fig = figure('Position',[0,0,700,350]);
    ha = axes('Units','pixels','Position',[50,50,300,200]);
    hp = plot(0,0);
    
    %make a set axis properties
    xlabel('Time (s)');
    ylabel('Temperature (F)');
    
    %makes the stop button and displays
    
    vLabel = uicontrol('Style','text',...
        'String','Voltage (V)',...
        'Position',[375,220,100,15]);
    vBox = uicontrol('Style','edit',...
        'Position',[375,200,100,15],...
        'HorizontalAlignment','right',...
        'Enable','off');
    rLabel  = uicontrol('Style','text',...
        'String','Resistance (Ohm)',...
        'Position',[375,180,100,15]);
    rBox = uicontrol('Style','edit',...
        'Position',[375,160,100,15],...
        'HorizontalAlignment','right',...
        'Enable','off');
    tempLabel = uicontrol('Style','text',...
        'String','Temperature (F)',...
        'Position',[375,140,100,15]);
    tempBox = uicontrol('Style','edit',...
        'Position',[375,120,100,15],...
        'HorizontalAlignment','right',...
        'Enable','off');
    tLabel = uicontrol('Style','text',...
        'String','Time (s)',...
        'Position',[375,100,100,15]);
    tBox = uicontrol('Style','edit',...
        'Position',[375,80,100,15],...
        'HorizontalAlignment','right',...
        'Enable','off');
    fanLabel = uicontrol('Style','text',...
        'String','Fan Status',...
        'Position',[500,220,100,15]);
    fanLight = uicontrol('Style','checkbox',...
        'Position',[500,200,20,20],...
        'Value',0,...
        'Enable','off');
    fanPop = uicontrol('Style','popupmenu',...
        'String',{'Auto','On','Off'},...
        'Position',[500,180,100,20],...
        'Callback',@fanPopCall);
    lightLabel = uicontrol('Style','text',...
        'String','Light Status',...
        'Position',[600,220,100,15]);
    lightLight = uicontrol('Style','checkbox',...
        'Position',[600,200,20,20],...
        'Value',0,...
        'Enable','off');
    lightPop = uicontrol('Style','popupmenu',...
        'String',{'Auto','On','Off'},...
        'Position',[600,180,100,20],...
        'Callback',@lightPopCall);
    StopButton = uicontrol('Style','pushbutton',...
        'String','Stop',...
        'Position',[400,60,100,25],...
        'UserData',1,...
        'Callback',@exitClick);
    PauseButton = uicontrol('Style','pushbutton',...
        'String','Pause',...
        'Position',[400,40,100,25],...
        'UserData',0,...
        'Callback',{@pauseClick,StopButton});
    ResetParamBut = uicontrol('Style','pushbutton',...
        'String','Reset Parameters',...
        'Position',[400,20,100,25],...
        'Callback',@resetParams);
    ResetDataBut = uicontrol('Style','pushbutton',...
        'String','Reset Data',...
        'Position',[400,0,100,25],...
        'Callback',@resetData);
    align([vLabel,vBox,rLabel,rBox,tBox,tLabel,StopButton,...
        tempLabel,tempBox,PauseButton,ResetParamBut,ResetDataBut],...
        'Left','Fixed',5);
    align([fanLabel,fanLight,fanPop],'Center','Fixed',5);
    align([lightLabel,lightLight,lightPop],'Center','Fixed',5);
    movegui('center');

    prompt = {...
        'Thermistor Input Pin Number',...
        'Fan Output Pin Number',...
        'Light Output Pin Number',...
        'Thermistor Source Voltage',...
        'Voltage Divider Static Resistor Resistance',...
        'Thermistor R25 Resistance',...
        'Thermistor A1 coefficient',...
        'Thermistor B2 coefficient',...
        'Thermistor C1 coefficient',...
        'Thermisort D1 coefficient',...
        'Input value for fan speed (50-255)',...
        'Input Switching Temperature (Upper Bound)',...
        'Input Switching Temperature (Lower Bound)'};
    
    %reset gui
    resetParams();
    resetData();
    set(hp,'XData',T,'YData',Temp);
    
    while(get(StopButton,'UserData'))
        %get time
        t = toc(collectTime)+t_offset;
        %get data
        [v,r,d,temp] = getData();
        %update arrays
        V = [V,v]; R = [R,r]; T = [T,t]; Temp = [Temp,temp]; D = [D,d];
        %update gui
        set(vBox,'String',v);
        set(rBox,'String',r);
        set(tBox,'String',t);
        set(tempBox,'String',temp);
        if(t>xlim(2))
            xlim = [xlim(2),xlim(2)+10];
        end
        axis([xlim ylim]);
        set(hp,'XData',T,'YData',Temp);
        if(get(fanPop,'Value')==1)
            if(temp>uprTemp)
                startFan();
            elseif(temp<lwrTemp)
                stopFan();
            end
        end
        if(get(lightPop,'Value')==1)
            if(temp>100)
                stopLight();
            elseif(temp<=100)
                startLight();
            end
        end
        
  %      if(a.digitalRead(lightPin)==0)
   %         set(lightLight,'Value',1);
    %    else
     %       set(lightLight,'Value',0);
      %  end
        pause(.01);
    end

    close(fig)
    a.digitalWrite(fanPin,0);
    a.digitalWrite(lightPin,0);
    
    %Reads raw data and calculates values
    function [v,r,d,temp] = getData()
        d = a.analogRead(tempPin);
        v = vSource*d/(res-1);
    	r = r1*v/(vSource-v);
        temp = (A1-B1*log(r/r25)-C1*log(r/r25)^2-D1*log(r/r25)^3)^(-1);
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
        set(pBut,'String','Paused');
        pauseTimer = tic;
        t_offset = 0;
        while(get(pBut,'UserData')&&get(eBut,'UserData'))
            drawnow;
            %set(lightPop,'enable','off');
            %set(fanPop,'enable','off');
        end
        %set(lightPop,'enable','on');
        %set(fanPop,'enable','on');
        if(~isempty(T))
            t_offset = T(length(T));
        end
        collectTime = tic;
        set(pBut,'String','Pause');
    end

    %turns on fan
    function [] = startFan()
        %Communicate with the external fan
        if(get(fanLight,'Value')==0)
            a.analogWrite(fanPin,K);
            set(fanLight,'Value',1);
        end
    end

    %turns off fan
    function [] = stopFan()
        %Communicate with the external fan
        if(get(fanLight,'Value')==1)
            a.analogWrite(fanPin,0);
            set(fanLight,'Value',0)
        end
    end

    %fanPop callback
    function [] = fanPopCall(source,~)
        switch(get(source,'Value'))
            case 1
                stopFan();
            case 2
                startFan();
            case 3
                stopFan();
        end
    end

    %turns on light
    function [] = startLight()
        %Communicate with the external light
        if(get(lightLight,'Value')==0)
            a.digitalWrite(lightPin,0);
            set(lightLight,'Value',1);
        end
    end

    %turns off light
    function [] = stopLight()
        %Communicate with the external light
        if(get(lightLight,'Value')==1)
            a.digitalWrite(lightPin,1);
            set(lightLight,'Value',0);
        end
    end

    %lightPop callback
    function [] = lightPopCall(source,~)
        switch(get(source,'Value'))
            case 1
                stopLight();
            case 2
                startLight();
            case 3
                stopLight();
        end
    end

    function [] = resetParams(~,~)
        answer = inputdlg(prompt,...
        'Input Parameters',...
        1,...
        {num2str(tempPin),num2str(fanPin),num2str(lightPin),...
            num2str(vSource),num2str(r1),num2str(r25),num2str(A1),...
            num2str(B1),num2str(C1),num2str(D1),num2str(K),...
            num2str(uprTemp),num2str(lwrTemp)...
        });
        drawnow; pause(0.5);
        if(isempty(answer))
            set(StopButton,'UserData',0);
            return;
        end
        tempPin = str2double(answer{1});
        fanPin = str2double(answer{2});
        lightPin = str2double(answer{3});
        vSource = str2num(answer{4});
        r1 = str2num(answer{5});
        r25 = str2num(answer{6});
        A1 = str2num(answer{7});
        B1 = str2num(answer{8});
        C1 = str2num(answer{9});
        D1 = str2num(answer{10});
        K = str2num(answer{11});
        uprTemp = str2num(answer{12});
        lwrTemp = str2num(answer{13});
        set(fanPop,'Value',1);
        set(lightPop,'Value',1);
        stopFan();
        stopLight();
    end

    function [] = resetData(~,~)
        %start timer
        t_offset = 0;
        collectTime = tic;
    
        %initialize all of the output arrays
        t = toc(collectTime)+t_offset;
        V = []; R = []; T = []; Temp = []; D = [];
        set(hp,'XData',T,'YData',Temp);
        xlim = [0 10];
        axis([xlim ylim]);
        set(vBox,'String',0);
        set(rBox,'String',0);
        set(tBox,'String',0);
        set(tempBox,'String',0);
    end

    function [bool] = pwmRead(pin,timeout)
        if(nargin==1)
            timeout=.0001;
        end
        bool=0;
        pwmTic = tic;
        val=0;
        while(val==0&&toc(pwmTic)<timeout)
            val = a.digitalRead(pin);
            if(val~=0)
                bool=1;
            end
        end
    end
end
        