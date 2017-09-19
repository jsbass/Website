function [score] = pong(a,inputPin)
    %resolution contant
    res = 1024;
    
    %set the input pin as an input
    a.pinMode(inputPin,'input');
    
    %initialize score
    score = [0,0];
    
    %initialize ball location and speed
    bLoc = [0,0];
    bDx = 2;
    bDy = 0;
    
    %initialize player paddle
    pLoc = 50-10;
    
    
    %initialize opponent's paddle
    oLoc = 50-10;
    oDy = 2;
    
    %make board
    figure('Position',[360,500,700,500]);
    axis('off')
    ax = axes('Units','Pixels','Position',[10,50,400,400],...
        'XLim',[0,100],'YLim',[0,100]);
    box on;
    set(ax,'XTick',[],'YTick',[]);
    
    %make ball and paddles
    ball = rectangle('Position',[47.5,47.5,5,5],...
        'EdgeColor','k','FaceColor','w');
    pPaddle = rectangle('Position',[5,-10,5,20]);
    oPaddle = rectangle('Position',[90,-10,5,20]);
    
    %makes scoreboard
    potPosBox = uicontrol('Style','edit','Position',[425,300,100,15],...
        'HorizontalAlignment','right');
    bVBox = uicontrol('Style','edit','Position',[425,350,100,15],...
        'HorizontalAlignment','right');
    pLabel = uicontrol('Style','text','String','Player 1',...
           'Position',[425,220,100,15]);
    pBox = uicontrol('Style','edit','Position',[425,200,100,15],...
        'HorizontalAlignment','right','String',0);
    oLabel = uicontrol('Style','text','String','Computer',...
           'Position',[425,180,100,15]);
    oBox = uicontrol('Style','edit','Position',[425,160,100,15],...
        'HorizontalAlignment','right','String',0);
    exitButton = uicontrol('Style','pushbutton','String','Exit',...
        'Position',[425,110,100,25],'Callback',@exitClick,'UserData',1);
    pauseButton = uicontrol('Style','pushbutton','String','Pause',...
        'Position',[425,80,100,25],'Callback',{@pauseClick,exitButton},...
        'UserData',0);
    align([potPosBox,bVBox,oLabel,pLabel,pBox,oBox,exitButton,pauseButton],...
        'Left','Fixed',5);
    movegui('center');
    
    bLoc = [47.5,47.5];
    set(ball,'Position',[bLoc,5,5]);
    pause(2)
    bDy = oDy/2*(rand(1)+1);
    bDx = -abs(bDx);
    
    while(get(exitButton,'UserData')&&max(score)<10)
        d = a.analogRead(inputPin)/(res-1);
        pLoc = d*(100-20);
        set(pPaddle,'Position',[5,pLoc,5,20]);
        set(potPosBox,'String',d);
        set(bVBox,'String',bDy);
        
        %calculate next ball move
        bLoc = [bLoc(1)+bDx,bLoc(2)+bDy];
        
        %calculate and move oponent
        oDy = -(oLoc+7.5-bLoc(2))/abs(oLoc+7.5-bLoc(2))*abs(oDy);
        oLoc = oLoc+oDy;
        if(oLoc+10>90||oLoc+10<10)
            oLoc = oLoc-oDy;
        end
        set(oPaddle,'Position',[90,oLoc,5,20]);
        
        %check to see if ball is at vertical edge
        if(bLoc(2)<=0||bLoc(2)>=95)
            bDy = -1*bDy;
            bLoc(2) = bLoc(2)+2*bDy;
        end
        
        %check to see if the ball is blocked by opponent
        if(bLoc(1)+5<=92.5&&bLoc(1)+5>=90&&bDx>0)
            if(bLoc(2)+2.5>oLoc+5 &&...       %ball hits middle of paddle 
                    bLoc(2)+2.5<oLoc+15)
                bDx = -1*bDx;
            elseif(bLoc(2)+2.5>oLoc+15 &&...  %ball hits top edge
                    bLoc(2)+2.5<oLoc+22.5)
                bDx = -1*bDx;
                if(bDy<0)
                    bDy = .5*bDy;
                else
                    bDy = 1.5*bDy;
                end
            elseif(bLoc(2)+2.5>oLoc-2.5 &&...   %ball hits bottom edge
                    bLoc(2)+2.5<oLoc+5)
                bDx = -1*bDx;
                if(bDy<0)
                    bDy = 1.5*bDy;
                else
                    bDy = .5*bDy;
                end
            end
        end
        
        %check to see if the ball is blocked by player
        if(bLoc(1)<=10&&bLoc(1)>=7.5&&bDx<0)
            if(bLoc(2)+2.5>pLoc+5 &&...       %ball hits middle of paddle 
                    bLoc(2)+2.5<pLoc+15)
                bDx = -1*bDx;
            elseif(bLoc(2)+2.5>pLoc+15 &&...  %ball hits top edge
                    bLoc(2)+2.5<pLoc+22.5)
                bDx = -1*bDx;
                if(bDy<0)
                    bDy = .5*bDy;
                else
                    bDy = 1.5*bDy;
                end
            elseif(bLoc(2)+2.5>pLoc-2.5 &&...   %ball hits bottom edge
                    bLoc(2)+2.5<pLoc+5)
                bDx = -1*bDx;
                if(bDy<0)
                    bDy = 1.5*bDy;
                else
                    bDy = .5*bDy;
                end
            end
        end
        
        %check to see if ball has scored
        if(bLoc(1)<=0)
            %computer scored
            score(2)=score(2)+1;
            set(pBox,'String',score(1));
            set(oBox,'String',score(2));
            bLoc = [47.5,47.5];
            oLoc = 40;
            set(oPaddle,'Position',[90,oLoc,5,20]);
            set(ball,'Position',[bLoc,5,5]);
            pause(2)
            bDy = oDy/2*(rand(1)+1);
            bDx = -abs(bDx);
        elseif(bLoc(1)+5>=100)
            %player scored
            score(1)=score(1)+1;
            set(pBox,'String',score(1));
            set(oBox,'String',score(2));            
            bLoc = [47.5,47.5];
            oLoc = 40;
            set(oPaddle,'Position',[90,oLoc,5,20]);
            set(ball,'Position',[bLoc,5,5]);
            pause(2)
            bDy = oDy/2*(rand(1)+1);
            bDx = abs(bDx);
        end
        
        %move the ball
        set(ball,'Position',[bLoc,5,5]);
        refreshdata;
        drawnow;
    end

    if(score(1)>score(2))
        fprintf('Player wins');
    elseif(score(1)<score(2))
        fprintf('Computer wins');
    else
        fprintf('Tie');
    end
    fprintf(' (%d-%d)\n',score(1),score(2));
    close;
end

function [] = exitClick(source,~)
    set(source,'UserData',0);
end

function [] = pauseClick(source,~,eBut)
    if(get(source,'UserData'))
        fprintf('unpaused\n');
        set(source,'UserData',0);
    else
        fprintf('paused\n');
        set(source,'UserData',1);
        pauseGame(source,eBut);
    end
end

function [] = pauseGame(pBut,eBut)
    set(pBut,'String','Paused')
    pauseTimer = tic;
    while(get(pBut,'UserData')&&get(eBut,'UserData')&&toc(pauseTimer)<10)
        drawnow;
    end
    set(pBut,'String','Pause');
end
