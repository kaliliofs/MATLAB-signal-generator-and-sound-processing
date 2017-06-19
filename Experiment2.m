
%---------------------Experiment 2-----------------------------------------

    disp 'Please fill in the specs of impulse response function h(t)'
    [t2,h] = signalGenerator(); % the impluse response 
                                        %equation in time domain
    legend('h(t)')    
    
    % a. Plot the frequency response of the channel in both time and
    %frequency domains:
    Fs=input('Fs=');
    H = fft(h);             
    f1=linspace(-Fs/2,Fs/2,length(H));
    HH=fftshift(abs(H));
    figure, plot(f1,HH)      %plot frequency response in freq. domain
    legend('H(f)')
    
%--------------------------------------------------------------------------
	% b. Plot the signal output signal in both time and frequency domains. 
    
    x = conv(m,h);              %convolution process to get the output x   
       tot_t_used=[t1 t2] ;     %total time used in h and m
       total=max(t1)-min(t1)+max(t2)-min(t2);  %length of the time   
       new_t=linspace(min(tot_t_used),total,length(tot_t_used)-1); 
                                %new time to plot th output x
    figure
    plot(new_t,x)               %the outpot x in time domain
    legend('x(t)')
        
    X = fft(x);             %the output x in freq. domain
    f2=linspace(-Fs/2,Fs/2,length(X));
    figure
    plot(f2,abs(X))               %plot the output x in freq. domain
    legend('X(f)')
    
         %-----------------------DECONVOLUTION--------------------------
    % it was required to return the input from the output using deconv
    m2=deconv(x,h);
         tt=[t2 new_t];
         k=min(new_t)-min(t2);
         c=(length(new_t)-length(t2))/Fs;
         ttt=linspace(k,k+c,length(m2));
    figure
    plot(ttt,m2)
    legend('Deconvolution for checking')
    
         %-----------------------noise--------------------------    
    %noise generation 
noise_choice = menu ('choose the type of the channel','noisy channel', 'non-noisy channel' ) ;

if (noise_choice == 1)   %nosiy channel
    sigma = input('\n enter the standard deviation: ');
	z = sigma*randn(1,length(x));
    r = z + x;
    figure
    plot(new_t,r)
end

if (noise_choice == 2)   %non-noisy channel 

	r = x;
    figure
    plot(new_t,r)
end
   

%____________________________________________________________________________%
