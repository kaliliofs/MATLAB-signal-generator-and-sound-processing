%%%%%%%%%%% TEAM 17 %%%%%%%%

function [t,x,Fs]=signalGenerator()
clc % clear all
DC_fn = 1; %giving them numbers 
Ramp_fn = 2;
Exponential_fn = 3;
sinusoidal_fn = 4;
% --------------------------------------------- reading parameters
pBreakPoints = [];

Fs = input('\nEnter the value of Fs: ');      %Sampling frequency 

Start = input('\nEnter the Start of time scale: ');    %start time

End = input('\nEnter the End of time scale: ');       %end time 

nBreakPoints = input('\nEnter the number of break points: ');     % number of break points

for n=1:nBreakPoints
    pBreakPoints(n) = input('\nEnter the positions of break points: ');    %position of break points
end
% --------------------------------------------- reading segments
%of course no. of breakpoints must be equal to the number of positions 
time_axis = [Start pBreakPoints End]

Ts = 1/Fs; 
t = []; %empty matrix initial value for t
x = []; %empty matrix initial value for x

for i=1:(nBreakPoints+1) %reading function and their specifications

   fn_code = menu ('choose your wave form','DC','Ramp', 'exponential', 'sinusoidal');
    
    t_tmp = time_axis(i) : Ts : time_axis(i+1); 
    %temporarily time which is changing in the "for loop" 
    %Now we will use "if condition" for the four functions we have
    
    if (fn_code == DC_fn)

        amplitude = input('\namplitude =  ');        
        x_tmp = amplitude*ones(1,length(t_tmp));
    end

    if (fn_code == Ramp_fn)
        
        slope = input('\nslope =  ');        
        intercept = input('intercept =  ');        
        
        x_tmp = slope*t_tmp + intercept;
    end
    
    if (fn_code == Exponential_fn)
        amplitude = input('\namplitude =  ');        
        exponent = input('exponent =  ');      
        x_tmp = amplitude * exp(exponent * t_tmp);
    end
    
    if (fn_code == sinusoidal_fn)
        amplitude = input('\namplitude =  ');        
        frequency = input('frequency =  ');        
        phase = input('phase =  ')*pi/180;
        shift = input('shift =  ');

        x_tmp = amplitude*sin(2*pi*frequency*t_tmp + phase)+shift;
    end
    
        t = [t t_tmp];        
        x = [x x_tmp];
end %end for "for loop" 
figure
plot(t,x);


end %end for "function" 



