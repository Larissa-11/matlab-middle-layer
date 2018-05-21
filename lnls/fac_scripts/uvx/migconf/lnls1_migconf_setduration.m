function r = lnls1_migconf_setduration(r0, factor)
% Multiplica tempo total de rampa por um fator
%
% Ajusta tempo total da rampa multiplicando a taxa de repeti��o de cada
% configura��o na rampa pelo fator 'factor'.
%
% Historico:
%
% 2010-09-16: coment�rios iniciais no c�digo (Ximenes R. Resende)

r = r0;
for i=1:length(r.configs)
    r.configs{i}.rep_rate = r.configs{i}.rep_rate * factor;
end

