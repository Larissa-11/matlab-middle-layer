function lnls1_monmags(varargin)
%Diagn�stico de fontes
%
%Hist�ria: 
%
%2010-09-13: coment�rios iniciais no c�digo.
%

nr_points = 1;
reading_interval = 0.0;

if ~strcmpi(getmode('BEND'), 'Online'), switch2online; end

lnls1_slow_orbcorr_off;
lnls1_fast_orbcorr_off;
setbpmaverages(reading_interval,nr_points);

disp([get_date_str ': in�cio da medida de flutua��o das fontes']);

if isempty(varargin)
    monmags([], 'Archive', '');
    %monmags(FileName, , UnitsFlag)
else
    monmags(varargin{:});
end

disp([get_date_str ': fim da medida de flutua��o das fontes']);


function r = get_date_str
r = datestr(now, 'yyyy-mm-dd_HH-MM-SS');
