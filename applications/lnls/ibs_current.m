%ibs_current: script used to plot the variation of final emittances and 
%energy spread in function of beam current per bunch due to intrabeam sca-
%ttering. The function lnls_calc_ibs_bane_cimp is used.
% Parameters as the maximum bunch current and number of steps of iteraction
% need to be set.
% April, 2018 - Murilo Barbosa Alves
datag = getad;
datag.NrBunches = 1; %Set the number of bunches as one
datas = atsummary;

Imax = 3e-4; %Maximum bunch current
Imin = 5e-5; %Minimum bunch current
nint = 10; %Number of steps
J = linspace(Imin,Imax, nint);

fEmitBANE = zeros(nint, 4);
fEmitCIMP = zeros(nint, 4);

%For each j, assigns a value of current to the function that calculates the
%effect of ibs on emittances
for j=1:nint
    if ~mod(j, 20)
        fprintf('.\n');
    else
        fprintf('.');
    end
    datag.BeamCurrent = J(j);
    [fEmitBANE(j,:),relBANE,fEmitCIMP(j,:),relCIMP] = lnls_calc_ibs_bane_cimp(datas,datag);
end
fprintf('\n');

fEmitBANE(:,1) = fEmitBANE(:,1) * 1e12;
fEmitBANE(:,2) = fEmitBANE(:,2) * 1e12;
fEmitBANE(:,3) = fEmitBANE(:,3) * 1e2;
fEmitCIMP(:,1) = fEmitCIMP(:,1) * 1e12;
fEmitCIMP(:,2) = fEmitCIMP(:,2) * 1e12;
fEmitCIMP(:,3) = fEmitCIMP(:,3) * 1e2;
J(:) = J(:)*1000;
    
J_min = J(1);
J_max = J(end);
f_min = 0.96;
f_max = 1.04;
    
figure;
semilogx(J,fEmitBANE(:,1),'color',[1.0 0.0 0.0]);
title('Final Horizontal Emittance versus Beam Current per bunch');
xlabel('I [mA]');
ylabel('\epsilon_x [pm rad]');
axis([J_min J_max f_min*min(fEmitBANE(:,1)) f_max*max(fEmitBANE(:,1))]);
 
hold on 
    
semilogx(J,fEmitCIMP(:,1),'color',[0.0 0.0 1.0]);
    
legend('BANE','CIMP','location','east');
hold off
    
figure;
semilogx(J,fEmitBANE(:,2),'color',[1.0 0.0 0.0]);
title('Final Vertical Emittance versus Beam Current per bunch');
xlabel('I [mA]');
ylabel('\epsilon_y [pm rad]');
axis([J_min J_max f_min*min(fEmitBANE(:,2)) f_max*max(fEmitBANE(:,2))]);
  
hold on 
    
semilogx(J,fEmitCIMP(:,2),'color',[0.0 0.0 1.0]);
  
legend('BANE','CIMP','location','east');
hold off
    
figure;
semilogx(J,fEmitBANE(:,3),'color',[1.0 0.0 0.0]);
title('Final Energy Spread versus Beam Current per bunch');
xlabel('I [mA]');
ylabel('\sigma_E / E_0 [%]');
axis([J_min J_max f_min*min(fEmitBANE(:,3)) f_max*max(fEmitBANE(:,3))]);
    
hold on 
    
semilogx(J,fEmitCIMP(:,3),'color',[0.0 0.0 1.0]);
    
legend('BANE','CIMP','location','east');
hold off
    
    
    