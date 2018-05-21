function lnls1_grff02_set_off
%Coloca o gerador de RF no modo de leitura.
%
%History: 
%
%2010-09-13: coment�rios iniciais no c�digo.

setpv('GRFF02_OP',1);
sleep(0.5);
op = getpv('GRFF02_OP');
if op ~= 1
    error('N�o foi poss�vel configurar gerador de RF no modo de leitura!');
end