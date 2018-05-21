function lnls1_fast_orbcorr_on
%Liga corre��o autom�tica de �rbita no OPR1
%
%History: 
%
%2010-09-13: coment�rios iniciais no c�digo.

if strcmpi(getmode('BEND'), 'online')
    msg.AFOFB_MODO_SP = 2;
    lnls1_comm_write(msg);
else
    fprintf('lnls1_fast_orbcorr_on: simulation mode!\n');
end
