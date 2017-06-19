
 %----------------------------difference_equation--------------------------
 
	%disp 'Please fill in the specs of difference equation h(t)'
    num=input('\n please enter the numerator of the transfer function as a row coefficient vector : ');
	den=input('\n please enter the denomenator of the transfer function as a row coefficient vector : ');
    Fs=input('Fs=');
    
    % a. Plot the frequency response of the channel in both time and
    % frequency domains:
    
        t0=0:0.01:2;
        impulse = t0==0;
    h = filter(num,den,impulse);
    time=linspace(0,(length(h)-1)/Fs,length(h));
    figure
    plot(time,h)         %frequency response of the channel in time domains
    legend('h(t)')
    
    H = fftshift(fft(h));   % frequency response of the channel in frequency domains
    f2=linspace(-Fs/2,Fs/2,length(H));
    figure
    plot(f2,abs(H))      %plot frequency response in freq. domain
    legend('H(f)') 
    
    %------------------------------------------------------
    % b. Plot the signal output signal in both time and frequency domains:
    
    x = filter(num,den,m);
         new_t=(-length(x)/2:length(x)/2-1)/Fs;
    figure
    plot(new_t,x)               %plotting output x in time domain    
    legend('x(t)')  
    
    X = fftshift(fft(x));      
    f2=linspace(-Fs/2,Fs/2,length(X));
    figure
    plot(f2,abs(X))             %plot the output x in freq. domain
    legend('X(f)') 
    
 
     %--------------------------
     % c. Plot the frequency response of the unknown system that will
     % recover the transmitted signal m(t):
   %reverse
 h_recovery = filter(den,num,impulse);
         time=linspace(0,length(h_recovery),length(h_recovery));
    %plot(time1,impulse)
    figure
    stem(time,h_recovery)       %frequency response of the channel in time domains
    legend('h_recovery(t)in time domain')
    figure
    H_recovery = fftshift(fft(h_recovery));   % frequency response of the channel in frequency domains
        f2=linspace(-Fs/2,Fs/2,length(H_recovery));
    plot(f2,abs(H_recovery))      %plot frequency response in freq. domain
    legend('H_recovery(f) in frequency domain')  
             %for making sure
              mrev=filter(den,num,x);
              figure
              plot(new_t,mrev);
              legend('output of the reverse channel to make sure');
   
  %_____________________________________________________________________
  
  
   %check stability for the original system
   %=============================BOUNS===============================
  
   condition=0;
 [r,p,k]=residuez(num,den);
 img=imag(p);
 if(length(den)==1)
   if(length(num)>2)
       disp('the original system is unstable')
   else
       disp('the original system is marginally stable')
   end
           
 else
if(real(p)>0)
   disp('the original  system is unstable')
elseif(real(p)<0)
    disp('the original  system is stable')
else
    for i=1:length(p)
        for n=i+1:length(p)
             if(img(i)==img(n))
                 disp('the original  system is unstable')
                 n=length(p);
                 i=n;
                 condition=0;
             else
                 condition=1;
             end
        end
        
    end
    if(condition==1)
        disp('the original  system is marginally stable')
    end
end
 end 
   %=============================BOUNS===============================
     
   
 %check stability for the recovery system
    %=============================BOUNS===========================
   condition=0;
 [r,p,k]=residuez(den,num);
 img=imag(p);
 if(length(num)==1)
   if(length(den)>2)
       disp('the recovery system is unstable')
   else
       disp('the recovery system is marginally stable')
   end
           
 else
if(real(p)>0)
   disp('the recovery  system is unstable')
elseif(real(p)<0)
    disp('the recovery  system is stable')
else
    for i=1:length(p)
        for n=i+1:length(p)
             if(img(i)==img(n))
                 disp('the recovery  system is unstable')
                 n=length(p);
                 i=n;
                 condition=0;
             else
                 condition=1;
             end
        end
        
    end
    if(condition==1)
        disp('the recovery  system is marginally stable')
    end
end
 end 
    %================================BOUNS===============================  
%_________________________________________________________________________________

