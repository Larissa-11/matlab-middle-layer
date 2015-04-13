function lnls1_monbpm(varargin)
%Mede flutua��o dos BPMs
%
%Hist�ria: 
%
%2010-09-13: coment�rios iniciais no c�digo.
%

nr_points = 1;
reading_interval = 0.0;

%if ~strcmpi(getmode('BEND'), 'Online'), switch2online; end

if strcmpi(getmode('BEND'), 'Online')
    lnls1_slow_orbcorr_off;
    lnls1_fast_orbcorr_off;  
end
setbpmaverages(reading_interval,nr_points);

disp([get_date_str ': in�cio da medida de flutua��o dos bpms']);

if isempty(varargin)
    monbpm([], 'Archive', '');
else
    monbpm(varargin{:});
end

disp([get_date_str ': fim da medida de flutua��o dos bpms']);

function r = get_date_str
r = datestr(now, 'yyyy-mm-dd_HH-MM-SS');
