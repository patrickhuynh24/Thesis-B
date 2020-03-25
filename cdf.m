clc
clear all
close all
Nmax = 10^6;
L=10;
r0pos= sqrt(L/2)*(randn(Nmax,1)+randn(Nmax,1)*1i);
r0neg= sqrt(L/2)*(randn(Nmax,1)+randn(Nmax,1)*1i);

bins=50;
%theta = chi2rnd(4,Nmax,1);  %simulation
theta = (abs(r0pos)).^2+(abs(r0neg)).^2;
[fSA,z0]=hist(theta,bins); %analysis


%pdf_SA=1/sqrt(2*pi)*exp(-z0.^2/2);
cdf_SA= 1- igamma(2,z0/L);

figure('Name','Dist_Valid','Position',[10 50 800 650])
% subplot(1,2,1)
% bar(z0,fSA/trapz(z0,fSA),'FaceColor','m');
% hold on;
% plot(z0,pdf_SA,'-k','LineWidth',4,'MarkerSize',5);hold off;
% legend1=legend('Simulation', 'Analysis');  
% set(legend1,'FontSize',15,'FontName','Times New Roman','Orientation','Vertical','interpreter', 'latex','Location', 'best','TextColor','k');
% set(gca,'FontSize',17,'FontName','Times New Roman','TickLabelInterpreter','latex','XColor','k','YColor','k');
% ylabel('PDF of $d_{SA}$','FontSize',18,'FontName','Times New Roman','interpreter', 'latex','Color','k');
% xlabel('Values','FontSize',18,'FontName','Times New Roman','interpreter', 'latex','Color','k');
% title('PDF S-A','FontSize',14,'FontName','Times New Roman','interpreter', 'latex','Color','k');
% grid on; 

subplot(1,2,2)
[H,STATS] = cdfplot(theta); 
%simulation
hold on;
plot(z0,cdf_SA,'kx','MarkerSize',9);hold off;                              %analysis
legend1=legend('Simulation', 'Analysis');  
set(legend1,'FontSize',15,'FontName','Times New Roman','Orientation','Vertical','interpreter', 'latex','Location', 'best','TextColor','k');
set(gca,'FontSize',17,'FontName','Times New Roman','TickLabelInterpreter','latex','XColor','k','YColor','k');
ylabel('CDF of $d_{SA}$','FontSize',18,'FontName','Times New Roman','interpreter', 'latex','Color','k');
xlabel('Values','FontSize',18,'FontName','Times New Roman','interpreter', 'latex','Color','k');
title('CDF S-A','FontSize',14,'FontName','Times New Roman','interpreter', 'latex','Color','k');
grid on; 
 