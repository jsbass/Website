function [t,avg]=reflex()
% reflex tester
t=[];
n=1+rand*10;
fprintf('Hit enter to start');
fprintf(' and then enter again when the prompt appears\n');
a='';
avg=0;
while ~strcmp(a,'q')
    a = input('Press enter to start (type q to exit)','s');
    if ~strcmp(a,'q')
        fprintf('Started\n');
        tic
        while toc<n
        end
        beep;
        tic
        input('Now!');
        temp=toc;
        if temp<.05
            fprintf('Either your reflexes are insane or you pressed');
            fprintf(' enter early\n');
        else
            t(length(t)+1)=temp;
            fprintf('Your time was %0.6f\n',t(length(t)));
        end
    end
end
avg=sum(t)/length(t(t>.05));
fprintf('Average: %0.3f\n',avg);