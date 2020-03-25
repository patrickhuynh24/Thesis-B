clc;
clear all;
close all;
%% Initialising
num_bit =10^6;
SNRdB = 0:1:10 ;                                                               %testing for 10 different SNR's
SNR=10.^(SNRdB/10);

F1= 900*10^6;           
Fc=867*10^6;
T=1/1000; %bit period for bitrate = 1kbps
Fs= 10000;
Ts=1/Fs;
L = T/Ts;

d = randi([0,1],[1,num_bit]);

min=0;
max=2*pi;
startphase= min+rand*(max-min); %in radians
 

noise= (1/sqrt(2))*(randn(L,num_bit) + 1i*randn(L,num_bit));

t_tr=24/(3*10^8);

ctr=2*pi*Fc*t_tr*3;

for p=1:length(SNRdB)
    mhat(p)=sqrt(SNR(p)*2/L); 
end

s2= ((mhat.^2)*(L^2))/2;  %non-centrality parameter

%M0= mhat.*L/2.*exp(-1i*(startphase-2*pi*F0*t_tr)-(-ctr));
M1= mhat.*L/2.*exp(1i*((startphase-2*pi*F1*t_tr)-(-ctr)));

r0pos= (randn(num_bit,1)+randn(num_bit,1)*1i)*sqrt(L/2);
r0neg= (randn(num_bit,1)+randn(num_bit,1)*1i)*sqrt(L/2);
r1pos= M1+sqrt(L/2)*(randn(num_bit,1)+randn(num_bit,1)*1i);
r1neg= M1+sqrt(L/2)*(randn(num_bit,1)+randn(num_bit,1)*1i);


for k = 1: length(SNRdB)
    c=0;
    err=0;
    for n = 1:num_bit
        if d(n) == 1
            z0=0;
            z1=0;
            c=c+1;
            z0= (abs(r0pos(n)))^2+(abs(r0neg(n)))^2;
            z1=(abs(r1pos(n,k)))^2+(abs(r1neg(n,k)))^2;
            if z0>z1
               err= err+1;
           end
        end
    end
    error(k) = err/c;
end
BER = error;


sig= L/2;
for z= 1:length(SNRdB)
    fun=@(x) (1- igamma(2,x/(2*sig))).*(1/2).*1/5.*exp((-((x./sig)+(s2(z)./sig))/2)).*((x./s2(z)).^(1/2)).*besseli(1,sqrt((x/sig).*(s2(z)./sig)));
    success(z)= integral(fun,0,1000);                                      
    theoryBER(z)= 1- success(z);
end

figure
semilogy(SNRdB,theoryBER,'b-','LineWidth',2);
%axis([0 10 10^-6 1])
hold on 
semilogy(SNRdB,BER,'rx','LineWidth',2);
grid on
legend1=legend('Simulation', 'Analytical');  


    