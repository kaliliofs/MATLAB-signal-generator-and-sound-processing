
%----------------------Experiment 1----------------------------------------

[t1,m,Fs] = signalGenerator();    %taking input from Signal Generator in time domain
legend('m(t)')
%--------------------------------------------------------------------------

frequency_domain = fft(m);
frequency_domain_1 = fftshift(frequency_domain);
Nlength = length(m);
frequency_length =[-Nlength/2:Nlength/2-1]/Nlength;
figure
plot(frequency_length,abs(frequency_domain_1));
legend('m(f)')
%______________________________________________________________________________________%