%% Clearing the work space and reading the signal:
    clear;                                       %clearing the workspace                                         
    [Xt, Fs] = audioread('sound.wav');           %Reading the sound file 
    Xt = vec2mat(Xt, length(Xt));                %Convert x to a matrix
    %Fs = 44100;
    %t = linspace(0, 1, 44100);
    %Xt = sin(10 * pi * t);
    
%% Plotting the signal in time domain:
    t1 = linspace(0, length(Xt)/Fs, length(Xt)); %Setting the time
    figure
    plot(t1, Xt, 'r')                                  
    title('Time Domain')
    xlabel('Time(t)');
    
    
%% Plotting the signal in frequency domain:
    N = size(t1, 2);                             %Samples count
    Xs = fftshift(fft(Xt));                      %Fourier transform
    
    %% Frequency specifications:
    
        f=linspace(-Fs/2,Fs/2,length(Xt));

    %% Plot the spectrum:
    figure
    subplot(2, 1, 1)
    plot(f, abs(Xs), 'g');                          % Magnitude Response
    title('Magnitude Response');
    xlabel('Frequency (HZ)');
    
    subplot(2, 1, 2)
    plot(f, angle(Xs),'b');                        % Phase Response
    title('Phase Response');  
    xlabel('Frequency (HZ)');

%% Impulse Response of the system
    t2 = linspace(0, 1, Fs);
    h = [1 zeros(1, length(t2)-2) 0.5];
    figure
    subplot(2, 6, 1)
    stem(t2, h)
    title('Impulse Response')

%% Output of the system for the given input:
    Yt = conv(Xt, h);
    t3 = linspace(0, length(Yt)/Fs, length(Yt));
    
    subplot(2, 6, [2 6])                            
    plot(t1, Xt, 'r')                                  
    title('Time Domain')
    xlabel('Time(t)');
    
    subplot(2, 6, [8 12])
    plot(t3, Yt)
    title('Output')
    xlabel('Time(t)');
    
%%  save the output sound from the system & play it
        audiowrite('new_sound.wav',Yt,Fs);
        sound(Yt,Fs);

    
%% Filter the system at 4000 HZ:

%===================BOUNS==========================

     o = ones(1,8000);
     z = zeros(1,(length(f)-length(o))/2);
     Xs=Xs.*[z o z];
     f1=-length(f)/2:-4001;
     f2=-4000:4000-1;
     f3=4001:length(f)/2;
     ff=[f1 f2 f3];
    figure
    % filtered signal frequency
    subplot(2, 1, 1)
    plot(ff, abs(Xs))
    title('Output')
    xlabel('Frequency (Hz)');
    

    
    % filtered signal time
    Xt=ifft(Xs);
    subplot(2, 1, 2)
    plot(t1,abs(Xt))
    title('Output')
    xlabel('Time (sec)');
    
    
        audiowrite('new_sound_2.wav',abs(Xt),Fs);
        sound(abs(Xt),Fs);

    
    

  
    
    






