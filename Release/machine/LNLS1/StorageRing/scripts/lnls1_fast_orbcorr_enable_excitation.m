function lnls1_fast_orbcorr_enable_excitation
%Habilita excitacao das corretoras pelo OPER1
%
%History: 
%
%2015-03-11: coment�rios iniciais no c�digo.

if strcmpi(getmode('BEND'), 'online')
    msg.AFOFB_CR_ON = 1;
    lnls1_comm_write(msg);
else
    fprintf('lnls1_fast_orbcorr_enable_excitation: simulation mode!\n');
end
