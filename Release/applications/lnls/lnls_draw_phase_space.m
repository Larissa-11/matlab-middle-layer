function lnls_draw_phase_space(the_ring,x_amps,y_amps,en_amps,nturns, resons)
% lnls_draw_phase_space(the_ring,x_amps,y_amps,en_amps,nturns, resons)
%
% Plota os espacos de fase horizontal e vertical e monta o diagrama de
% tuneshifts com as amplitudes horizontal e vertical e com a energia:
% 
% ring   = modelo do anel para o qual os calculos serao feitos;
% x_amps = vetor com as amplitudes horizontais para as quais o calculo sera
%          realizado [m];
% y_amps = vetor com as amplitudes verticais para as quais o calculo sera
%          realizado [m];
% en_amps= vetor com os desvios de energia para o calculo dos tuneshifts 
%          com o momentum;
% nturns = numero de voltas usado para o calculo;
% resons = ordens de ressonan para fazer o grafico (ex. 1:3).
%
% Como padrao, a funcao usa o algoritmo NAFF para os calculos de sintonia.
% Por isso, o numero real de voltas usado sera tal que satisfaca a seguinte
% formula nt = mod(2^nextpow2(nturns),6)==0

% escolha do metodo para calculo das sintonias:
meth = 'naff';

% ajuste do numero de voltas para que seja compativel com o naff
nt = nextpow2(nturns);
nturns = 2^nt + 6 - mod(2^nt,6);



orb = findorbit6(the_ring);
if any(isnan(orb))
    orb = [findorbit4(the_ring,0);0;0];
end
% calula os tunes do anel
[~, tunes] = twissring(the_ring, 0, 1:length(the_ring)+1);

%%
% faz o tracking nas amplitudes horizontais especificadas no input, setando
% a posicao vertical inicial para 1e-5 para evitar singularidades do mapa
% de transferencia e tornar possivel a obtencao da sintonia vertical
x_amps = x_amps(:);
Rinx  = [x_amps'+orb(1); zeros(1,length(x_amps))+orb(2); 1e-5*ones(1,length(x_amps))+orb(3); zeros(3,length(x_amps))+repmat(orb(4:6),1,length(x_amps))];
Routx = ringpass(the_ring,Rinx,nturns);
coordx_x  = reshape(Routx(1,:),length(x_amps),nturns);
coordxl_x = reshape(Routx(2,:),length(x_amps),nturns);
coordy_x  = reshape(Routx(3,:),length(x_amps),nturns);
coordyl_x = reshape(Routx(4,:),length(x_amps),nturns);

% exclui as particulas perdidas e calcula a sintonia
ind = ~isnan(coordx_x(:,end));
tunex_x = NaN*ind; tuney_x = NaN*ind;
if strcmp(meth,'fft')
    tunex_x(ind) = intfft(coordx_x(ind,:)')';
    tuney_x(ind) = intfft(coordy_x(ind,:)')';
else
    tunex_x(ind) = lnls_calcnaff(coordx_x(ind,:), coordxl_x(ind,:));
    tuney_x(ind) = lnls_calcnaff(coordy_x(ind,:), coordyl_x(ind,:));
end
fprintf('Na varredura x as coordenadas iniciais:  ');
fprintf('%6.1f',x_amps(~ind)*1e3);
fprintf(' [mm] nao sobreviveram\n');


%%
% a mesma coisa que foi feita para a horizontal eh repetida para vertical
y_amps = y_amps(:);
Riny  = [1e-5*ones(1,length(y_amps))+orb(1); zeros(1,length(y_amps))+orb(2); y_amps'+orb(3); zeros(3,length(y_amps))+repmat(orb(4:6),1,length(y_amps))];
Routy = ringpass(the_ring,Riny,nturns);
coordx_y  = reshape(Routy(1,:),length(y_amps),nturns);
coordxl_y = reshape(Routy(2,:),length(y_amps),nturns);
coordy_y  = reshape(Routy(3,:),length(y_amps),nturns);
coordyl_y = reshape(Routy(4,:),length(y_amps),nturns);

ind = ~isnan(coordx_y(:,end));
tunex_y = NaN*ind; tuney_y = NaN*ind;
if strcmp(meth,'fft')
    tunex_y(ind) = intfft(coordx_y(ind,:)')';
    tuney_y(ind) = intfft(coordy_y(ind,:)')';
else
    tunex_y(ind) = lnls_calcnaff(coordx_y(ind,:), coordxl_y(ind,:));
    tuney_y(ind) = lnls_calcnaff(coordy_y(ind,:), coordyl_y(ind,:));
end

fprintf('Na varredura y as coordenadas iniciais:  ');
fprintf('%6.1f',y_amps(~ind)*1e3);
fprintf(' [mm] nao sobreviveram\n');

%%
% e agora para as amplitudes de energia
en_amps = en_amps(:);
Rinen  = [1e-4*ones(1,length(en_amps))+orb(1); zeros(1,length(en_amps))+orb(2); ...
          1e-4*ones(1,length(en_amps))+orb(3); zeros(1,length(en_amps))+orb(4); ...
          en_amps'+orb(5); zeros(1,length(en_amps))+orb(6)];
Routen = ringpass(the_ring,Rinen,nturns);
coordx_en  = reshape(Routen(1,:),length(en_amps),nturns);
coordxl_en = reshape(Routen(2,:),length(en_amps),nturns);
coordy_en  = reshape(Routen(3,:),length(en_amps),nturns);
coordyl_en = reshape(Routen(4,:),length(en_amps),nturns);

ind = ~isnan(coordx_en(:,end));
tunex_en = NaN*ind; tuney_en = NaN*ind;
if strcmp(meth,'fft')
    tunex_en(ind) = intfft(coordx_en(ind,:)')';
    tuney_en(ind) = intfft(coordy_en(ind,:)')';
else
    tunex_en(ind) = lnls_calcnaff(coordx_en(ind,:), coordxl_en(ind,:));
    tuney_en(ind) = lnls_calcnaff(coordy_en(ind,:), coordyl_en(ind,:));
end

fprintf('Na varredura em energia as coordenadas iniciais:  ');
fprintf('%6.1f',en_amps(~ind)*1e2);
fprintf(' %% nao sobreviveram\n');
%%
% Agora, temos que determinar a parte inteira da sintonia
if mod(tunes(1),1)>0.5
    tunex_en = ceil(tunes(1)) - tunex_en;
    tunex_y  = ceil(tunes(1)) - tunex_y;
    tunex_x  = ceil(tunes(1)) - tunex_x;
else
    tunex_en = floor(tunes(1)) + tunex_en;
    tunex_y  = floor(tunes(1)) + tunex_y;
    tunex_x  = floor(tunes(1)) + tunex_x;
end
if mod(tunes(2),1)>0.5
    tuney_en = ceil(tunes(2)) - tuney_en;
    tuney_y  = ceil(tunes(2)) - tuney_y;
    tuney_x  = ceil(tunes(2)) - tuney_x;
else
    tuney_en = floor(tunes(2)) + tuney_en;
    tuney_y  = floor(tunes(2)) + tuney_y;
    tuney_x  = floor(tunes(2)) + tuney_x;
end


%%
% Por fim, fazemos alguns graficos.
scrsz = get(0,'ScreenSize');
scrsz = scrsz.*[1, 1, 1/2, 1/2];
figure1 = figure('OuterPosition', scrsz);

% Primeiro o espaco de fase x
axes11 = subplot(1,3,1,'Parent',figure1,'FontSize',16);
box(axes11,'on');
hold(axes11,'all');
ylabel(axes11,'xl [mrad]'); xlabel(axes11,'x [mm]');
plot(coordx_x'*1e3,coordxl_x'*1e3,'b.','Parent',axes11);
plot(coordx_y'*1e3,coordxl_y'*1e3,'r.','Parent',axes11);

% Agora o y
axes12 = subplot(1,3,2,'Parent',figure1,'FontSize',16);
box(axes12,'on');
hold(axes12,'all');
ylabel(axes12,'yl [mrad]'); xlabel(axes12,'y [mm]');
plot(coordy_y'*1e3,coordyl_y'*1e3,'r.','Parent',axes12);
plot(coordy_x'*1e3,coordyl_x'*1e3,'b.','Parent',axes12);

% e por fim o diagrama de sintonias
axes13 = subplot(1,3,3,'Parent',figure1,'FontSize',16);
ylabel(axes13,'\nu_y'); xlabel(axes13,'\nu_x');
tunespaceplot(floor(tunes(1))+[-0.05 +0.55], floor(tunes(2))+[-0.05 +0.55],resons,axes13);
hold(axes13,'all');
plot(tunex_y,tuney_y,'r.','Parent',axes13);
plot(tunex_x,tuney_x,'b.','Parent',axes13);
plot(tunex_en,tuney_en,'m.','Parent',axes13);

