function r = lnls1_meascoupling(nr_points)
%Mede acoplamento do anel atrav�s de separa��o m�nima entre sintonias.
%
%Hist�ria: 
%
%2010-09-13: coment�rios iniciais no c�digo.
%
% function r = lnls1_meascoupling(nr_points)
%
% A fun��o 'lnls1_meascoupling' mede o coeficiente de acoplamento 
% atrav�s da separa��o m�nima de sintonias. Para isto o script varia as for�as nos
% quadrupolos focalizadores de defocalizadores de modo a gerar uma invers�o da parte
% fracion�ria das sintonias.
%
% Par�metros de Entrada:
%
% nr_points: n�mero de pontos na varredura das for�as quadrupolares para invsers�o de sintonia.
%
% Par�metros de Sa�da:
%
% r.tunes  : matrix com sintonias medidas durante a varredura. Primeira coluna corresponde � sintonia
%            horizontal e a segunda � vertical.
% r.qf_set : matrix com valores da corrente das fontes dos quadrupolos focalizadores
% r.qd_set : matrix com valores da corrente das fontes dos quadrupolos defocalizadores
% r.timestamp_init  : instante do in�cio da medida.
% r.timestamp_final : instante do final da medida.
% r.machineconfig_init  : estrutura com todos os setpoints no in�cio da medida.
% r.machineconfig_final : estrutura com todos os setpoints no final da medida.
%
% obs: a corre��o de �rbita � ligada automaticamente antes da medida.

lnls1_fast_orbcorr_on;

fd = getfamilydata('TUNE');
if strcmpi(fd.Monitor.Mode,'Online')
    sp_wait = 3;
else
    sp_wait = 0;
end

tunes = gettune;
DeltaTune = [tunes(2)-tunes(1); tunes(1)-tunes(2)];
tuneresp = gettuneresp;
DeltaAmps = inv(tuneresp) * DeltaTune;
quad_families = {'QF', 'QD'}; 

originalSP = getsp(quad_families);

nr_supplies_qf = length(originalSP{1});
nr_supplies_qd = length(originalSP{2});

steps  = linspace(0,1,nr_points);
for i=1:length(steps)
    sp_set{i} = [originalSP{1} + DeltaAmps(1) * ones(nr_supplies_qf,1) * steps(i) originalSP{2} + DeltaAmps(2) * ones(nr_supplies_qd,1) * steps(i)]; 
end

fprintf('Varredura de Sintonias...\n');
r.tunes = [];
r.machineconfig_init = getmachineconfig;
r.timestamp_init= clock;
for i=1:nr_points
    setsp(quad_families{1}, sp_set{i}(:,1));
    setsp(quad_families{2}, sp_set{i}(:,2));
    sleep(sp_wait);
    r.qf_set{i} = sp_set{i}(:,1);
    r.qd_set{i} = sp_set{i}(:,2);
    r.tunes(i,:) = sort(gettune, 'descend');
    fprintf('ponto #%i: %f %f %f\n', i, r.tunes(i,1), r.tunes(i,2), r.tunes(i,1)-r.tunes(i,2)); 
end
setsp(quad_families{1}, originalSP{1});
setsp(quad_families{2}, originalSP{2});
r.machineconfig_final = getmachineconfig;
r.timestamp_final = clock;
sleep(sp_wait);

r.nr_points = nr_points;
r.quad_families = quad_families;
r.delta_amps = DeltaAmps;
