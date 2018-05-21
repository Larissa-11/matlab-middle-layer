function  [ChannelName, ErrorFlag] = sirius_getname(Family, Field, DeviceList)
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

switch Family
    
    case 'BEND'
        ChannelName = [ ...
            'DI01_01';'DI01_02';'DI01_03';'DI01_04';'DI01_05';'DI01_06';'DI01_07';'DI01_08';'DI01_09';'DI01_10';'DI01_11';'DI01_12'; ...
            'DI02_01';'DI02_02';'DI02_03';'DI02_04';'DI02_05';'DI02_06';'DI02_07';'DI02_08';'DI02_09';'DI02_10';'DI02_11';'DI02_12'; ...
            'DI03_01';'DI03_02';'DI03_03';'DI03_04';'DI03_05';'DI03_06';'DI03_07';'DI03_08';'DI03_09';'DI03_10';'DI03_11';'DI03_12'; ...
            'DI04_01';'DI04_02';'DI04_03';'DI04_04';'DI04_05';'DI04_06';'DI04_07';'DI04_08';'DI04_09';'DI04_10';'DI04_11';'DI04_12'; ...
            'DI05_01';'DI05_02';'DI05_03';'DI05_04';'DI05_05';'DI05_06';'DI05_07';'DI05_08';'DI05_09';'DI05_10';'DI05_11';'DI05_12'; ...
            'DI06_01';'DI06_02';'DI06_03';'DI06_04';'DI06_05';'DI06_06';'DI06_07';'DI06_08';'DI06_09';'DI06_10';'DI06_11';'DI06_12'; ...
            'DI07_01';'DI07_02';'DI07_03';'DI07_04';'DI07_05';'DI07_06';'DI07_07';'DI07_08';'DI07_09';'DI07_10';'DI07_11';'DI07_12'; ...
            'DI08_01';'DI08_02';'DI08_03';'DI08_04';'DI08_05';'DI08_06';'DI08_07';'DI08_08';'DI08_09';'DI08_10';'DI08_11';'DI08_12'; ...
            'DI09_01';'DI09_02';'DI09_03';'DI09_04';'DI09_05';'DI09_06';'DI09_07';'DI09_08';'DI09_09';'DI09_10';'DI09_11';'DI09_12'; ...
            'DI10_01';'DI10_02';'DI10_03';'DI10_04';'DI10_05';'DI10_06';'DI10_07';'DI10_08';'DI10_09';'DI10_10';'DI10_11';'DI10_12' ...
            ];

            
            
        
        
    case {'BPMx','BPMy'}
        if (strcmpi(Field, 'Monitor') || strcmpi(Field, 'CommonNames'))
            ChannelName = ['AMP01B'; ...
                'AMP02A'; 'AMP02B'; 'AMP03A'; 'AMP03B'; ...
                'AMP04A'; 'AMP04B'; 'AMP05A'; 'AMP05B'; ...
                'AMP06A'; 'AMP06B'; 'AMP07A'; 'AMP07B'; ...
                'AMP08A'; 'AMP08B'; 'AMP09A'; 'AMP09B'; ...
                'AMP10A'; 'AMP10B'; 'AMP11A'; 'AMU11A'; ...
                'AMU11B'; 'AMP11B'; 'AMP12A'; 'AMP12B'; ...
                'AMP01A'
                ];
            if strcmpi(Family, 'BPMx')
                ChannelName = strcat(ChannelName, '_H');
            else
                ChannelName = strcat(ChannelName, '_V');                
            end
        else
            error('Don''t know how to make the channel name for family %s', Family);
        end
    case 'HCM'
        ChannelName = [
            'ACH01B'; ...
            'ACH02 ';  'ACH03A'; 'ACH03B'; 'ACH04 ';  'ACH05A'; 'ACH05B'; ...
            'ACH06 ';  'ACH07A'; 'ACH07B'; 'ACH08 ';  'ACH09A'; 'ACH09B'; ...
            'ACH10 ';  'ACH11A'; 'ACH11B'; 'ACH12 '; ...
            'ACH01A'];
    case 'VCM'
        ChannelName = [
            'ACV01B'; ...
            'ALV02A'; 'ALV02B'; 'ACV03A'; 'ACV03B'; ...
            'ALV04A'; 'ALV04B'; 'ACV05A'; 'ACV05B'; ...
            'ALV06A'; 'ALV06B'; 'ACV07A'; 'ACV07B'; ...
            'ALV08A'; 'ALV08B'; 'ACV09A'; 'ACV09B'; ...
            'ALV10A'; 'ALV10B'; 'ACV11A'; 'ACV11B'; ...
            'ALV12A'; 'ALV12B'; ...
            'ACV01A'];
        
    case 'QF_Families'
        ChannelName = ['A2QF01';'A2QF03';'A2QF03';'A2QF05';'A2QF05';'A2QF07';'A2QF07';'A2QF09';'A2QF09';'A2QF11';'A2QF11';'A2QF01'];
    case 'QF_Shunts'
        ChannelName = [ ...
            'AQF01B'; ...
            'AQF03A';'AQF03B'; ...
            'AQF05A';'AQF05B'; ...
            'AQF07A';'AQF07B'; ...
            'AQF09A';'AQF09B'; ...
            'AQF11A';'AQF11B'; ...
            'AQF01A' ...
        ];
 
    case 'QD_Families'
        ChannelName = ['A2QD01';'A2QD03';'A2QD03';'A2QD05';'A2QD05';'A2QD07';'A2QD07';'A2QD09';'A2QD09';'A2QD11';'A2QD11';'A2QD01'];
    case 'QD_Shunts'
        ChannelName = [ ...
            'AQD01B'; ...
            'AQD03A';'AQD03B'; ...
            'AQD05A';'AQD05B'; ...
            'AQD07A';'AQD07B'; ...
            'AQD09A';'AQD09B'; ...
            'AQD11A';'AQD11B'; ...
            'AQD01A' ...
        ];

    case 'QFC_Families'
        ChannelName = ['A6QF01';'A6QF02';'A6QF02';'A6QF01';'A6QF01';'A6QF02';'A6QF02';'A6QF01';'A6QF01';'A6QF02';'A6QF02';'A6QF01'];
    case 'QFC_Shunts'
        ChannelName = [ ...
            'AQF02A';'AQF02B'; ...
            'AQF04A';'AQF04B'; ...
            'AQF06A';'AQF06B'; ...
            'AQF08A';'AQF08B'; ...
            'AQF10B';'AQF10A'; ...
            'AQF12A';'AQF12B' ...
        ];
    
    case 'SKEWQUAD'
        ChannelName = ['A2QS05';'A2QS05'];
    case 'SF'
        ChannelName = ['A6SF';'A6SF';'A6SF';'A6SF';'A6SF';'A6SF']; 
    case 'SD'
        ChannelName = ['A6SD01';'A6SD02'; 'A6SD02';'A6SD01'; 'A6SD01';'A6SD02'; 'A6SD02';'A6SD01'; 'A6SD01';'A6SD02'; 'A6SD02';'A6SD01'];        
    
    case 'TUNE'
        ChannelName = ['ASINT_H'; 'ASINT_V'; 'ASINT_S'];
    case 'RF'
        ChannelName = ['GRFF02_FREQ'];           
        
end

if any(strcmpi(Family, {'HCM', 'VCM', 'QF', 'QF_Shunts', 'QF_Families', 'QFC', 'QFC_Shunts', 'QFC_Families', 'QD', 'QD_Shunts', 'QD_Families', 'SKEWQUAD', 'SF', 'SD', 'BEND','RF'}))
    if strcmpi(Field, 'Monitor')
        ChannelName = strcat(ChannelName, '_AM');
    elseif strcmpi(Field, 'Setpoint')
        ChannelName = strcat(ChannelName, '_SP');
    elseif strcmpi(Field, 'CommonNames')
    else
        error('Don''t know how to make the channel name for family %s', Family);
    end
end


