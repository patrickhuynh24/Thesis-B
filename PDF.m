clc
clear all
close all
L=10;
Nmax = 10^6;
SNR=10;
mhat=sqrt(SNR*2/L);
s= (mhat^2*10^2)/2;
F1= 880*10^6;           
Fc=867*10^6;
min=0;
max=2*pi;
startphase= min+rand*(max-min); %in radians
t_tr=24/(3*10^8);
ctr=2*pi*Fc*t_tr*3;
M1= mhat.*L/2.*exp(1i*((startphase-2*pi*F1*t_tr)-(-ctr)));
r1pos= M1+sqrt(L/2)*(randn(Nmax,1)+randn(Nmax,1)*1i);
r1neg= M1+sqrt(L/2)*(randn(Nmax,1)+randn(Nmax,1)*1i);

bins=50;

% theta =  ncx2rnd(4,s,Nmax,1); %Theoretical Data
theta=(abs(r1pos)).^2+(abs(r1neg)).^2; %Simulate Data

[fSA,z1]=hist(theta,bins);


%pdf_SA=1/2.*exp(-(z1+s)./2).*((z1./s).^(-1/2)).*besseli(1,sqrt(s.*z1));
pdf_SA=((sqrt(z1)./(L*sqrt(s))).*exp((-(z1+s))/L)).*besseli(1,sqrt(z1).*sqrt(s)./(L/2));

figure('Name','Dist_Valid','Position',[10 50 800 650])
subplot(1,2,1)
bar(z1,fSA/trapz(z1,fSA),'FaceColor','m');
hold on;
plot(z1,pdf_SA,'-k','LineWidth',4,'MarkerSize',5);hold off;
legend1=legend('Simulation', 'Analysis');  
set(legend1,'FontSize',15,'FontName','Times New Roman','Orientation','Vertical','interpreter', 'latex','Location', 'best','TextColor','k');
set(gca,'FontSize',17,'FontName','Times New Roman','TickLabelInterpreter','latex','XColor','k','YColor','k');
ylabel('PDF of $d_{SA}$','FontSize',18,'FontName','Times New Roman','interpreter', 'latex','Color','k');
xlabel('Values','FontSize',18,'FontName','Times New Roman','interpreter', 'latex','Color','k');
title('PDF S-A','FontSize',14,'FontName','Times New Roman','interpreter', 'latex','Color','k');
grid on; 
