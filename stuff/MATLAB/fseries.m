function [rng,series,e,M] = fseries(f, L, n, err, plt, animate)
% fseries:  Computes the fouries series for input function
% series = fseries(f, max_n, err, plot, animate):   computes the Fouries
%                                                   series for the input
%                                                   function, f, calculates
%                                                   the error at a given n,
%                                                   calculates the minimum
%                                                   n to attain an error,
%                                                   err, and chooses
%                                                   whether to plot the
%                                                   series over the
%                                                   function/animate the
%                                                   plot
% input:
%   f = input function to model
%   L = half of the period of the function
%   n = number of terms in the series to use
%   err = maximum error to find an associated minimum number of terms that
%         be bounded by the error
%   plt = boolean for whether to plot the series to n terms over the
%          function
%   animate = boolean for whether to animate the plot (plot must equal
%             true)

switch nargin
    case 0
        error('must specify a function');
    case 1
        n = 10;
        fprintf('n defaulted to %d\n', n);
        err = .0001;
        fprintf('err defaulted to %%%f (%f)\n', err*100, err);
        plt = false;
        animate = false;
    case 2
        err = .0001;
        fprintf('err defaulted to %%%f (%f)\n', err*100, err);
        plt = false;
        animate = false;
    case 3
        plt = false;
        animate = false;
    case 4
        animate = false;
end

if ~isa(f, 'function_handle')
    error('f must be of type function_handle')
end
if mod(n,1)~=0
    error('n must be an integer');
end
if err < 0
    err = -1*err;
    fprintf('err must be positive. err has been changed to %f.\n',err);
end
if plt~=true&&plt~=false
    error('plt must be a boolean value (true/1 or false/0)');
end
if plt==1
    if animate~=1&&animate~=0
        error('animate must be a boolean value (true/1 or false/0)');
    end
end

rng = (-3*L):(L/100):(3*L);

syms m x

a0 = (1/L)*int(f(x),x,-L,L);
am = @(m) (1/L).*int(f(x).*cos(m*pi.*x./L),x,-L,L);
bm = @(m) (1/L).*int(f(x).*sin(m*pi.*x./L),x,-L,L);


series{1} = @(x) a0/2;
e{1} = @(x)(series{1}(x)-f(x));

for i=1:n
    series{i+1}= ...
        @(x)(series{i}(x)+(am(i).*cos(i*pi.*x./L))+(bm(i).*sin(i*pi.*x./L)));
    e{i+1} = @(x)series{i+1}(x)-f(x);
    if animate
        h(1) = subplot(2,1,1);
        plot(rng,mod(f(rng)+L,2*L)-L); hold all;
        plot(rng,series{i+1}(rng));
        xlabel('x');
        ylabel('y');
        title('x vs. f(x), Fourier Series');
        legend(['f(x)','Series: n=',num2str(i)]); hold off;
        h(2) =subplot(2,1,2);
        plot(rng,e{i+1}(rng)); hold all;
        xlabel('x');
        ylabel('Error');
        title('x vs. e');
        legend(['e: n = ',num2str(i)]); hold off;
        linkaxes(h,'x');
        M(i) = getframe(gcf);
    end        
end

if animate
    movie(M,3,.5);
end

h(1) = subplot(2,1,1);
plot(rng,mod(f(rng)+L,2*L)-L); hold all;
plot(rng,series{n+1}(rng));
xlabel('x');
ylabel('y');
title('x vs. f(x), Fourier Series');
legend(['f(x)','Series: n=',num2str(n)]); hold off;
h(2) = subplot(2,1,2);
plot(rng,e{n+1}(rng)); hold all;
xlabel('x');
ylabel('Error');
title('x vs. e');
legend(['e: n = ',num2str(n)]); hold off;


return
