function mild_vs_severe_plotter_single_variable(timeM,solM,timeS,solS,p)
 
load('Human_viral_load_data.mat')
p.lag_s5 = 2;
p.lag_s6 = 2.79;
p.lag_s18 = 1.32;
p.lag_g1 = 1.27;
p.lag_g2 = 0.92;
p.lag_g5 = 1.32;
p.lag_g6 = 2.76;
p.lag_g7 = 2;
% Model curves -----------------------------------------------------------

%Viral Load
fig = figure;
hold on 
l1 = plot(timeM, 10.^(solM(1,:)),'Color','k','LineWidth',3);
l3 = plot(p.lag_s5+time_s5,10.^(viral_load_s5),'o','Color',[0.5 0.5 0.5],'LineWidth',1)
plot(p.lag_s6+time_s6,10.^(viral_load_s6),'o','Color',[0.5 0.5 0.5],'LineWidth',1)
plot(p.lag_s18+time_s18,10.^(viral_load_s18),'o','Color',[0.5 0.5 0.5],'LineWidth',1)
plot(p.lag_g1+time_g1,10.^(viral_load_g1),'o','Color',[0.5 0.5 0.5],'LineWidth',1)
plot(p.lag_g2+time_g2,10.^(viral_load_g2),'o','Color',[0.5 0.5 0.5],'LineWidth',1)
plot(p.lag_g5+time_g5,10.^(viral_load_g5),'o','Color',[0.5 0.5 0.5],'LineWidth',1)
plot(p.lag_g6+time_g6,10.^(viral_load_g6),'o','Color',[0.5 0.5 0.5],'LineWidth',1)
plot(p.lag_g7+time_g7,10.^(viral_load_g7),'o','Color',[0.5 0.5 0.5],'LineWidth',1)
l3 = plot(timeS, 10.^(solS(1,:)),'--','Color','r','LineWidth',3);
set(gca,'yscale','log')
title('Viral load')
ylabel('copies/ml')
legend([l1 l3], {'mild','severe'})
set(gca,'Fontsize',24)
xlabel('Time (days)')
xlim([0 20])
saveas(gcf,'ViralLoad.fig');
saveas(gcf,'ViralLoad.png');



fig = figure;
hold on 
l4 = plot(timeM, (solM(2,:) +solM(4,:)) * 1e9,'Color','k','LineWidth',3);
l5 = plot(timeS, (solS(2,:) +solS(4,:)) * 1e9,'--','Color','r','LineWidth',3);
set(gca,'yscale','log')
ylabel('cells/ml')
title('Uninfected cells')
%legend([l1 l2 l3 l4 l5], {'V(t) (mild)','Data','V(t) (severe)','S(t)+R(t) (mild)','S(t)+R(t) (severe)'})
set(gca,'Fontsize',24)
%set(gca,'yTick',[1e5 1e6 1e7 1e8])
xlabel('Time (days)')
xlim([0 20])
saveas(gcf,'UninfectedCells.fig');
saveas(gcf,'UninfectedCells.png');

 
%dead cells
fig = figure;
hold on 
plot(timeM, solM(3,:)*1e9,'Color','k','LineWidth',3);
plot(timeS, solS(3,:)*1e9,'--','Color','r','LineWidth',3);
ylabel('cells/ml')
title('Infected cells')
set(gca,'yscale','log')
set(gca,'Fontsize',24)
xlabel('Time (days)')
set(gca,'yTick',[1e5 1e6 1e7 1e8])
saveas(gcf,'InfectedCells.fig');
saveas(gcf,'InfectedCells.png');

fig = figure
hold on 
plot(timeM, solM(5,:)*1e9,'Color','k','LineWidth',3);
plot(timeS, solS(5,:)*1e9,'--','Color','r','LineWidth',3);
set(gca,'yscale','log')
ylabel('cells/ml')
title('Dead cells')
%legend('I(t) (mild)','I(t) (severe)','D(t) (mild)','D(t) (severe)')
set(gca,'Fontsize',24)
xlabel('Time (days)')
set(gca,'yTick',[1E4 1e5 1e6 1e7 1e8])
saveas(gcf,'DeadCells.fig');
saveas(gcf,'DeadCells.png');

%macs cells
fig = figure;
hold on 
plot(timeM, solM(6,:)*1e9,'Color','k','LineWidth',3);
plot(timeS, solS(6,:)*1e9,'--','Color','r','LineWidth',3);
ylabel('cells/ml')
title('Alveolar macs')
set(gca,'Fontsize',24)
xlabel('Time (days)')
saveas(gcf,'RMacs.fig');
saveas(gcf,'RMacs.png');

figure
hold on
plot(timeM, solM(7,:)*1e9,'Color','k','LineWidth',3);
plot(timeS, solS(7,:)*1e9,'--','Color','r','LineWidth',3);
set(gca,'yscale','log')
ylabel('cells/ml')
title('Inflammatory macs')
%legend('M_{\Phi R}(t) (mild)','M_{\Phi R}(t) (severe)','M_{\Phi I}(t) (mild)','M_{\Phi I}(t) (severe)')
set(gca,'Fontsize',24)
set(gca,'yTick',[1E1 1e2 1e3 1e4 1e5])
xlabel('Time (days)')
saveas(gcf,'InflamMacs.fig');
saveas(gcf,'InflamMacs.png');
%monocytes cells
fig = figure;
hold on 
plot(timeM, solM(8,:)*1e9,'Color','k','LineWidth',3);
plot(timeS, solS(8,:)*1e9,'--','Color','r','LineWidth',3);
ylabel('cells/ml')
title('Monocytes')
set(gca,'yscale','log')
set(gca,'Fontsize',24)
xlabel('Time (days)')
saveas(gcf,'monocytes.fig');
saveas(gcf,'monocytes.png');

figure
hold on 
plot(timeM, solM(9,:)*1e9,'Color','k','LineWidth',3);
plot(timeS, solS(9,:)*1e9,'--','Color','r','LineWidth',3);
set(gca,'yscale','log')
title('Neutrophils')
set(gca,'Fontsize',24)
ylabel('cells/ml');
xlabel('Time (days)');
set(gca, 'FontSize', 24);
saveas(gcf,'neutrophils.fig');
saveas(gcf,'neutrophils.png');



%T cells
fig = figure;
hold on 
%yyaxis left
plot(timeM, solM(10,:)*1e9,'Color','k','LineWidth',3);
plot(timeS, solS(10,:)*1e9,'--','Color','r','LineWidth',3);
ylabel('cells/ml')
title('CD8^+ T cells')
%yyaxis right
%plot(timeM,1./(1+solM(12,:)./p.eps_L_T),'Color',[230,97,1]/255,'LineWidth',2)
%plot(timeS,1./(1+solS(12,:)./p.eps_L_T),'Color',[230,97,13]/255,'LineWidth',2)
%ylabel('IL-6 anti-inflam effect, 1/(1+L_B/\epsilon_{L,T})')
%legend('T(t) (mild)','T(t) (severe)')%,'IL-6 anti-inflam curve (mild)','IL-6 anti-inflam curve (severe)')
set(gca,'Fontsize',24)
xlabel('Time (days)')
saveas(gcf,'tCells.fig');
saveas(gcf,'tCells.png');

%IL-6 cells
fig = figure;
hold on 
plot(timeM, solM(11,:),'Color','k','LineWidth',3);
plot(timeS, solS(11,:),'--','Color','r','LineWidth',3);
ylabel('pg/ml')
title('Unbound IL-6')
set(gca,'Fontsize',24)
xlabel('Time (days)')
saveas(gcf,'Unbound_IL6.fig');
saveas(gcf,'Unbound_IL6.png');

figure
hold on 
plot(timeM, solM(12,:),'Color','k','LineWidth',3);
plot(timeS, solS(12,:),'--','Color','r','LineWidth',3);
ylabel('pg/ml')
title('Bound IL-6')
%legend('L_U(t) (mild)','L_U(t) (severe)','L_B(t) (mild)','L_B(t) (severe)')
set(gca,'Fontsize',24)
xlabel('Time (days)')
saveas(gcf,'Bound_IL6.fig');
saveas(gcf,'Bound_IL6.png');

% GM-CSF cells
fig = figure;
hold on 
plot(timeM, solM(13,:),'Color','k','LineWidth',3);
plot(timeS, solS(13,:),'--','Color','r','LineWidth',3);
ylabel('pg/ml')
title('Unbound GM-CSF')
set(gca,'Fontsize',24)
xlabel('Time (days)')
saveas(gcf,'Unbound_GMCSF.fig');
saveas(gcf,'Unbound_GMCSF.png');

figure
hold on
plot(timeM, solM(14,:),'Color','k','LineWidth',3);
plot(timeS, solS(14,:),'--','Color','r','LineWidth',3);
ylabel('pg/ml')
title('Bound GM-CSF')
%legend('G_U(t) (mild)','G_U(t) (severe)','G_B(t) (mild)','G_B(t) (severe)')
set(gca,'Fontsize',24)
xlabel('Time (days)')
saveas(gcf,'Bound_GMCSF.fig');
saveas(gcf,'Bound_GMCSF.png');

% G-CSF cells
fig = figure;
hold on 
plot(timeM, solM(15,:)*1000,'Color','k','LineWidth',3);
plot(timeS, solS(15,:)*1000,'--','Color','r','LineWidth',3);
ylabel('pg/ml')
title('Unbound G-CSF')
set(gca,'Fontsize',24)
xlabel('Time (days)')
saveas(gcf,'Unbound_GCSF.fig');
saveas(gcf,'Unbound_GCSF.png');

figure
hold on
plot(timeM, solM(16,:)*1000,'Color','k','LineWidth',3);
plot(timeS, solS(16,:)*1000,'--','Color','r','LineWidth',3);
ylabel('pg/ml')
title('Bound G-CSF')
%legend('C_U(t) (mild)','C_U(t) (severe)','C_B(t) (mild)','C_B(t) (severe)')
set(gca,'Fontsize',24)
xlabel('Time (days)')
saveas(gcf,'Bound_GCSF.fig');
saveas(gcf,'Bound_GCSF.png');

% IFN cells
fig = figure;
hold on 
plot(timeM, solM(17,:),'Color','k','LineWidth',3);
plot(timeS, solS(17,:),'--','Color','r','LineWidth',3);
ylabel('pg/ml')
title('Unbound Type I IFN')
set(gca,'Fontsize',24)
xlabel('Time (days)')
saveas(gcf,'Unbound_TypeIIFN.fig');
saveas(gcf,'Unbound_TypeIIFN.png');

figure
hold on
plot(timeM, solM(18,:),'Color','k','LineWidth',3);
plot(timeS, solS(18,:),'--','Color','r','LineWidth',3);
ylabel('pg/ml')
title('Bound Type I IFN')
%legend('F_U(t) (mild)','F_U(t) (severe)','F_B(t) (mild)','F_B(t) (severe)')
%legend('Mild disease','Severe disease')
set(gca,'Fontsize',24)
xlabel('Time (days)')
saveas(gcf,'Bound_TypeIIFN.fig');
saveas(gcf,'Bound_TypeIIFN.png');

%NK cells
figure
hold on 
plot(timeM, solM(19,:)*1e9,'Color','k','LineWidth',3);
plot(timeS, solS(19,:)*1e9,'--','Color','r','LineWidth',3);
ylabel('cells/ml')
title('NK cells')
set(gca,'Fontsize',24)
xlabel('Time (days)')
saveas(gcf,'NK.fig');
saveas(gcf,'NK.png');

figure
hold on
plot(timeM, solM(24,:)*1e9,'Color','k','LineWidth',3);
plot(timeS, solS(24,:)*1e9,'--','Color','r','LineWidth',3);
ylabel('cells/mL')
title('Infected Cells Killed by NK')
set(gca,'Fontsize',24)
xlabel('Time (days)')
saveas(gcf,'I_killedbyNK.fig');
saveas(gcf,'I_killedbyNK.png');

% IFN-Gamma 
fig = figure;
hold on 
plot(timeM, solM(20,:),'Color','k','LineWidth',3);
plot(timeS, solS(20,:),'--','Color','r','LineWidth',3);
ylabel('pg/ml')
title('Unbound IFN-\gamma ')
set(gca,'Fontsize',24)
xlabel('Time (days)')
saveas(gcf,'Unbound_IFNGamma.fig');
saveas(gcf,'Unbound_IFNGamma.png');

figure
hold on
plot(timeM, solM(21,:),'Color','k','LineWidth',3);
plot(timeS, solS(21,:),'--','Color','r','LineWidth',3);
ylabel('pg/ml')
title('Bound IFN-\gamma ')
%legend('Gamma_U(t) (mild)','Gamma_U(t) (severe)','Gamma_B(t) (mild)','Gamma_B(t) (severe)')
%legend('Mild disease','Severe disease')
set(gca,'Fontsize',24)
xlabel('Time (days)')
saveas(gcf,'Bound_IFNGamma.fig');
saveas(gcf,'Bound_IFNGamma.png');

% TNF Alpha 
fig = figure;
hold on 
plot(timeM, solM(22,:),'Color','k','LineWidth',3);
plot(timeS, solS(22,:),'--','Color','r','LineWidth',3);
ylabel('pg/ml')
title('Unbound TNF-\alpha ')
set(gca,'Fontsize',24)
xlabel('Time (days)')
saveas(gcf,'Unbound_TNFAlpha.fig');
saveas(gcf,'Unbound_TNFAlpha.png');

figure
hold on
plot(timeM, solM(23,:),'Color','k','LineWidth',3);
plot(timeS, solS(23,:),'--','Color','r','LineWidth',3);
ylabel('pg/ml')
title('Bound TNF-\alpha ')
%legend('alpha_U(t) (mild)','alpha_U(t) (severe)','alpha_B(t) (mild)','alpha_B(t) (severe)')
%legend('Mild disease','Severe disease')
set(gca,'Fontsize',24)
xlabel('Time (days)')
saveas(gcf,'Bound_TNFAlpha.fig');
saveas(gcf,'Bound_TNFAlpha.png');

end
