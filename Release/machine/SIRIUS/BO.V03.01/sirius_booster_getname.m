function  [ChannelName, ErrorFlag] = sirius_booster_getname(Family, Field, DeviceList)
% ChannelName = getname_sirius(Family, Field, DeviceList)
%
%   INPUTS
%   1. Family name
%   2. Field
%   3. DeviceList ([Sector Device #] or [element #]) (default: whole family)
%
%   OUTPUTS
%   1. ChannelName = IOC channel name corresponding to the family and DeviceList


if nargin == 0
    error('Must have at least one input (''Family'')!');
end
if nargin < 2
    Field = 'Monitor';
end
if nargin < 3
    DeviceList = [];
end

%
%if isempty(DeviceList)
%   DeviceList = getlist(Family);
%elseif (size(DeviceList,2) == 1)
%   DeviceList = elem2dev(Family, DeviceList);
%end

ChannelName = [];

switch lower(Family)
    
    case {'bpmx', 'bpmy'}
        if (strcmpi(Field, 'Monitor') || strcmpi(Field, 'CommonNames'))
            ChannelName = [
                'BODI-BPM-01-U'; 'BODI-BPM-02-U'; 'BODI-BPM-03-U'; 'BODI-BPM-04-U' ;...
                'BODI-BPM-05-U'; 'BODI-BPM-06-U'; 'BODI-BPM-07-U'; 'BODI-BPM-08-U' ;...
                'BODI-BPM-09-U'; 'BODI-BPM-10-U'; 'BODI-BPM-11-U'; 'BODI-BPM-12-U' ;...
                'BODI-BPM-13-U'; 'BODI-BPM-14-U'; 'BODI-BPM-15-U'; 'BODI-BPM-16-U' ;...
                'BODI-BPM-17-U'; 'BODI-BPM-18-U'; 'BODI-BPM-19-U'; 'BODI-BPM-20-U' ;...
                'BODI-BPM-21-U'; 'BODI-BPM-22-U'; 'BODI-BPM-23-U'; 'BODI-BPM-24-U' ;...
                'BODI-BPM-25-U'; 'BODI-BPM-26-U'; 'BODI-BPM-27-U'; 'BODI-BPM-28-U' ;...
                'BODI-BPM-29-U'; 'BODI-BPM-30-U'; 'BODI-BPM-31-U'; 'BODI-BPM-32-U' ;...
                'BODI-BPM-33-U'; 'BODI-BPM-34-U'; 'BODI-BPM-35-U'; 'BODI-BPM-36-U' ;...
                'BODI-BPM-37-U'; 'BODI-BPM-38-U'; 'BODI-BPM-39-U'; 'BODI-BPM-40-U' ;...
                'BODI-BPM-41-U'; 'BODI-BPM-42-U'; 'BODI-BPM-43-U'; 'BODI-BPM-44-U' ;...
                'BODI-BPM-45-U'; 'BODI-BPM-46-U'; 'BODI-BPM-47-U'; 'BODI-BPM-48-U' ;...
                'BODI-BPM-49-U'; 'BODI-BPM-50-U'; ];
            if strcmpi(Family, 'bpmx')
                ChannelName = strcat(ChannelName, '-X');
            else
                ChannelName = strcat(ChannelName, '-Y');                
            end
        else
            error('Don''t know how to make the channel name for family %s', Family);
        end
        
	case 'qd_fam'
		ChannelName = 'BOPS-QD-FAM';

	case 'qd'
		ChannelName = [
			'BOPS-QD-02-D'; 'BOPS-QD-04-D'; 'BOPS-QD-06-D'; 'BOPS-QD-08-D' ;...
			'BOPS-QD-10-D'; 'BOPS-QD-12-D'; 'BOPS-QD-14-D'; 'BOPS-QD-16-D' ;...
			'BOPS-QD-18-D'; 'BOPS-QD-20-D'; 'BOPS-QD-22-D'; 'BOPS-QD-24-D' ;...
			'BOPS-QD-26-D'; 'BOPS-QD-28-D'; 'BOPS-QD-30-D'; 'BOPS-QD-32-D' ;...
			'BOPS-QD-34-D'; 'BOPS-QD-36-D'; 'BOPS-QD-38-D'; 'BOPS-QD-40-D' ;...
			'BOPS-QD-42-D'; 'BOPS-QD-44-D'; 'BOPS-QD-46-D'; 'BOPS-QD-48-D' ;...
			'BOPS-QD-50-D'; ];

	case 'qf_fam'
		ChannelName = 'BOPS-QF-FAM';

	case 'qf'
		ChannelName = [
			'BOPS-QF-01'; 'BOPS-QF-02'; 'BOPS-QF-03'; 'BOPS-QF-04' ;...
			'BOPS-QF-05'; 'BOPS-QF-06'; 'BOPS-QF-07'; 'BOPS-QF-08' ;...
			'BOPS-QF-09'; 'BOPS-QF-10'; 'BOPS-QF-11'; 'BOPS-QF-12' ;...
			'BOPS-QF-13'; 'BOPS-QF-14'; 'BOPS-QF-15'; 'BOPS-QF-16' ;...
			'BOPS-QF-17'; 'BOPS-QF-18'; 'BOPS-QF-19'; 'BOPS-QF-20' ;...
			'BOPS-QF-21'; 'BOPS-QF-22'; 'BOPS-QF-23'; 'BOPS-QF-24' ;...
			'BOPS-QF-25'; 'BOPS-QF-26'; 'BOPS-QF-27'; 'BOPS-QF-28' ;...
			'BOPS-QF-29'; 'BOPS-QF-30'; 'BOPS-QF-31'; 'BOPS-QF-32' ;...
			'BOPS-QF-33'; 'BOPS-QF-34'; 'BOPS-QF-35'; 'BOPS-QF-36' ;...
			'BOPS-QF-37'; 'BOPS-QF-38'; 'BOPS-QF-39'; 'BOPS-QF-40' ;...
			'BOPS-QF-41'; 'BOPS-QF-42'; 'BOPS-QF-43'; 'BOPS-QF-44' ;...
			'BOPS-QF-45'; 'BOPS-QF-46'; 'BOPS-QF-47'; 'BOPS-QF-48' ;...
			'BOPS-QF-49'; 'BOPS-QF-50'; ];

    case 'qsb_fam'
		ChannelName = 'BOPS-QSB-FAM';

	case 'qsb'
		ChannelName = 'BOPS-QSB-02';
        
	case 'sf_fam'
		ChannelName = 'BOPS-SF-FAM';

	case 'sf'
		ChannelName = [
			'BOPS-SF-02-U'; 'BOPS-SF-04-U'; 'BOPS-SF-06-U'; 'BOPS-SF-08-U' ;...
			'BOPS-SF-10-U'; 'BOPS-SF-12-U'; 'BOPS-SF-14-U'; 'BOPS-SF-16-U' ;...
			'BOPS-SF-18-U'; 'BOPS-SF-20-U'; 'BOPS-SF-22-U'; 'BOPS-SF-24-U' ;...
			'BOPS-SF-26-U'; 'BOPS-SF-28-U'; 'BOPS-SF-30-U'; 'BOPS-SF-32-U' ;...
			'BOPS-SF-34-U'; 'BOPS-SF-36-U'; 'BOPS-SF-38-U'; 'BOPS-SF-40-U' ;...
			'BOPS-SF-42-U'; 'BOPS-SF-44-U'; 'BOPS-SF-46-U'; 'BOPS-SF-48-U' ;...
			'BOPS-SF-50-U'; ];

	case 'sd_fam'
		ChannelName = 'BOPS-SD-FAM';

	case 'sd'
		ChannelName = [
			'BOPS-SD-03-U'; 'BOPS-SD-08-U'; 'BOPS-SD-13-U'; 'BOPS-SD-18-U' ;...
			'BOPS-SD-23-U'; 'BOPS-SD-28-U'; 'BOPS-SD-33-U'; 'BOPS-SD-38-U' ;...
			'BOPS-SD-43-U'; 'BOPS-SD-48-U'; ];

	case  {'cv', 'vcm'}
		ChannelName = [
			'BOPS-CV-01-U'; 'BOPS-CV-03-U'; 'BOPS-CV-05-U'; 'BOPS-CV-07-U' ;...
			'BOPS-CV-09-U'; 'BOPS-CV-11-U'; 'BOPS-CV-13-U'; 'BOPS-CV-15-U' ;...
			'BOPS-CV-17-U'; 'BOPS-CV-19-U'; 'BOPS-CV-21-U'; 'BOPS-CV-23-U' ;...
			'BOPS-CV-25-U'; 'BOPS-CV-27-U'; 'BOPS-CV-29-U'; 'BOPS-CV-31-U' ;...
			'BOPS-CV-33-U'; 'BOPS-CV-35-U'; 'BOPS-CV-37-U'; 'BOPS-CV-39-U' ;...
			'BOPS-CV-41-U'; 'BOPS-CV-43-U'; 'BOPS-CV-45-U'; 'BOPS-CV-47-U' ;...
			'BOPS-CV-49-U'; ];

	case  {'ch', 'hcm'}
		ChannelName = [
			'BOPS-CH-01-U'; 'BOPS-CH-03-U'; 'BOPS-CH-05-U'; 'BOPS-CH-07-U' ;...
			'BOPS-CH-09-U'; 'BOPS-CH-11-U'; 'BOPS-CH-13-U'; 'BOPS-CH-15-U' ;...
			'BOPS-CH-17-U'; 'BOPS-CH-19-U'; 'BOPS-CH-21-U'; 'BOPS-CH-23-U' ;...
			'BOPS-CH-25-U'; 'BOPS-CH-27-U'; 'BOPS-CH-29-U'; 'BOPS-CH-31-U' ;...
			'BOPS-CH-33-U'; 'BOPS-CH-35-U'; 'BOPS-CH-37-U'; 'BOPS-CH-39-U' ;...
			'BOPS-CH-41-U'; 'BOPS-CH-43-U'; 'BOPS-CH-45-U'; 'BOPS-CH-47-U' ;...
			'BOPS-CH-49-D'; ];
        
    case 'rf'
        ChannelName = 'BORF-FREQUENCY';
    
    case 'bend_a'
		ChannelName = 'BOPS-BEND-FAM-A';
 
    case 'bend_b'
		ChannelName ='BOPS-BEND-FAM-B';
        
    case 'dcct'
        ChannelName = 'BODI-CURRENT';
            
    case 'tune'
        ChannelName = ['BODI-TUNEH'; 'BODI-TUNEV'; 'BODI-TUNES'];
        
    otherwise
        error('Don''t know how to make the channel name for family %s', Family);
        
end

if any(strcmpi(Family, {'bpmx', 'bpmy', 'DCCT', 'tune'}))
    
else
    if strcmpi(Field, 'Monitor')
        ChannelName = strcat(ChannelName, '-RB');
    elseif strcmpi(Field, 'Setpoint')
        ChannelName = strcat(ChannelName, '-SP');
    end
end

end


