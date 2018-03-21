function  [ChannelName, ErrorFlag] = sirius_si_getname(Family, Field, DeviceList)
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

ChannelName = [];

prefix = getenv('VACA_PREFIX');

switch Family

    case {'BPMx', 'BPMy'}
        if (strcmpi(Field, 'Monitor') || strcmpi(Field, 'CommonNames'))
            ChannelName = [
                'SI-01M2:DI-BPM  '; 'SI-01C1:DI-BPM-1'; 'SI-01C1:DI-BPM-2'; 'SI-01C2:DI-BPM  '; ...
                'SI-01C3:DI-BPM-1'; 'SI-01C3:DI-BPM-2'; 'SI-01C4:DI-BPM  '; 'SI-02M1:DI-BPM  '; ...
                'SI-02M2:DI-BPM  '; 'SI-02C1:DI-BPM-1'; 'SI-02C1:DI-BPM-2'; 'SI-02C2:DI-BPM  '; ...
                'SI-02C3:DI-BPM-1'; 'SI-02C3:DI-BPM-2'; 'SI-02C4:DI-BPM  '; 'SI-03M1:DI-BPM  '; ...
                'SI-03M2:DI-BPM  '; 'SI-03C1:DI-BPM-1'; 'SI-03C1:DI-BPM-2'; 'SI-03C2:DI-BPM  '; ...
                'SI-03C3:DI-BPM-1'; 'SI-03C3:DI-BPM-2'; 'SI-03C4:DI-BPM  '; 'SI-04M1:DI-BPM  '; ...
                'SI-04M2:DI-BPM  '; 'SI-04C1:DI-BPM-1'; 'SI-04C1:DI-BPM-2'; 'SI-04C2:DI-BPM  '; ...
                'SI-04C3:DI-BPM-1'; 'SI-04C3:DI-BPM-2'; 'SI-04C4:DI-BPM  '; 'SI-05M1:DI-BPM  '; ...
                'SI-05M2:DI-BPM  '; 'SI-05C1:DI-BPM-1'; 'SI-05C1:DI-BPM-2'; 'SI-05C2:DI-BPM  '; ...
                'SI-05C3:DI-BPM-1'; 'SI-05C3:DI-BPM-2'; 'SI-05C4:DI-BPM  '; 'SI-06M1:DI-BPM  '; ...
                'SI-06M2:DI-BPM  '; 'SI-06C1:DI-BPM-1'; 'SI-06C1:DI-BPM-2'; 'SI-06C2:DI-BPM  '; ...
                'SI-06C3:DI-BPM-1'; 'SI-06C3:DI-BPM-2'; 'SI-06C4:DI-BPM  '; 'SI-07M1:DI-BPM  '; ...
                'SI-07M2:DI-BPM  '; 'SI-07C1:DI-BPM-1'; 'SI-07C1:DI-BPM-2'; 'SI-07C2:DI-BPM  '; ...
                'SI-07C3:DI-BPM-1'; 'SI-07C3:DI-BPM-2'; 'SI-07C4:DI-BPM  '; 'SI-08M1:DI-BPM  '; ...
                'SI-08M2:DI-BPM  '; 'SI-08C1:DI-BPM-1'; 'SI-08C1:DI-BPM-2'; 'SI-08C2:DI-BPM  '; ...
                'SI-08C3:DI-BPM-1'; 'SI-08C3:DI-BPM-2'; 'SI-08C4:DI-BPM  '; 'SI-09M1:DI-BPM  '; ...
                'SI-09M2:DI-BPM  '; 'SI-09C1:DI-BPM-1'; 'SI-09C1:DI-BPM-2'; 'SI-09C2:DI-BPM  '; ...
                'SI-09C3:DI-BPM-1'; 'SI-09C3:DI-BPM-2'; 'SI-09C4:DI-BPM  '; 'SI-10M1:DI-BPM  '; ...
                'SI-10M2:DI-BPM  '; 'SI-10C1:DI-BPM-1'; 'SI-10C1:DI-BPM-2'; 'SI-10C2:DI-BPM  '; ...
                'SI-10C3:DI-BPM-1'; 'SI-10C3:DI-BPM-2'; 'SI-10C4:DI-BPM  '; 'SI-11M1:DI-BPM  '; ...
                'SI-11M2:DI-BPM  '; 'SI-11C1:DI-BPM-1'; 'SI-11C1:DI-BPM-2'; 'SI-11C2:DI-BPM  '; ...
                'SI-11C3:DI-BPM-1'; 'SI-11C3:DI-BPM-2'; 'SI-11C4:DI-BPM  '; 'SI-12M1:DI-BPM  '; ...
                'SI-12M2:DI-BPM  '; 'SI-12C1:DI-BPM-1'; 'SI-12C1:DI-BPM-2'; 'SI-12C2:DI-BPM  '; ...
                'SI-12C3:DI-BPM-1'; 'SI-12C3:DI-BPM-2'; 'SI-12C4:DI-BPM  '; 'SI-13M1:DI-BPM  '; ...
                'SI-13M2:DI-BPM  '; 'SI-13C1:DI-BPM-1'; 'SI-13C1:DI-BPM-2'; 'SI-13C2:DI-BPM  '; ...
                'SI-13C3:DI-BPM-1'; 'SI-13C3:DI-BPM-2'; 'SI-13C4:DI-BPM  '; 'SI-14M1:DI-BPM  '; ...
                'SI-14M2:DI-BPM  '; 'SI-14C1:DI-BPM-1'; 'SI-14C1:DI-BPM-2'; 'SI-14C2:DI-BPM  '; ...
                'SI-14C3:DI-BPM-1'; 'SI-14C3:DI-BPM-2'; 'SI-14C4:DI-BPM  '; 'SI-15M1:DI-BPM  '; ...
                'SI-15M2:DI-BPM  '; 'SI-15C1:DI-BPM-1'; 'SI-15C1:DI-BPM-2'; 'SI-15C2:DI-BPM  '; ...
                'SI-15C3:DI-BPM-1'; 'SI-15C3:DI-BPM-2'; 'SI-15C4:DI-BPM  '; 'SI-16M1:DI-BPM  '; ...
                'SI-16M2:DI-BPM  '; 'SI-16C1:DI-BPM-1'; 'SI-16C1:DI-BPM-2'; 'SI-16C2:DI-BPM  '; ...
                'SI-16C3:DI-BPM-1'; 'SI-16C3:DI-BPM-2'; 'SI-16C4:DI-BPM  '; 'SI-17M1:DI-BPM  '; ...
                'SI-17M2:DI-BPM  '; 'SI-17C1:DI-BPM-1'; 'SI-17C1:DI-BPM-2'; 'SI-17C2:DI-BPM  '; ...
                'SI-17C3:DI-BPM-1'; 'SI-17C3:DI-BPM-2'; 'SI-17C4:DI-BPM  '; 'SI-18M1:DI-BPM  '; ...
                'SI-18M2:DI-BPM  '; 'SI-18C1:DI-BPM-1'; 'SI-18C1:DI-BPM-2'; 'SI-18C2:DI-BPM  '; ...
                'SI-18C3:DI-BPM-1'; 'SI-18C3:DI-BPM-2'; 'SI-18C4:DI-BPM  '; 'SI-19M1:DI-BPM  '; ...
                'SI-19M2:DI-BPM  '; 'SI-19C1:DI-BPM-1'; 'SI-19C1:DI-BPM-2'; 'SI-19C2:DI-BPM  '; ...
                'SI-19C3:DI-BPM-1'; 'SI-19C3:DI-BPM-2'; 'SI-19C4:DI-BPM  '; 'SI-20M1:DI-BPM  '; ...
                'SI-20M2:DI-BPM  '; 'SI-20C1:DI-BPM-1'; 'SI-20C1:DI-BPM-2'; 'SI-20C2:DI-BPM  '; ...
                'SI-20C3:DI-BPM-1'; 'SI-20C3:DI-BPM-2'; 'SI-20C4:DI-BPM  '; 'SI-01M1:DI-BPM  ';
                ];

            if strcmpi(Family, 'BPMx')
                ChannelName = strcat(ChannelName, ':PosX-Mon');
            else
                ChannelName = strcat(ChannelName, ':PosY-Mon');
            end
        else
            error('Don''t know how to make the channel name for family %s', Family);
        end

	case 'QFAFam'
		ChannelName = repmat('SI-Fam:MA-QFA', size(DeviceList,1), 1);

    case 'QFATrim'
		ChannelName = [
			'SI-01M2:MA-QFA'; 'SI-05M1:MA-QFA'; ...
            'SI-05M2:MA-QFA'; 'SI-09M1:MA-QFA'; ...
			'SI-09M2:MA-QFA'; 'SI-13M1:MA-QFA'; ...
			'SI-13M2:MA-QFA'; 'SI-17M1:MA-QFA'; ...
			'SI-17M2:MA-QFA'; 'SI-01M1:MA-QFA'; ...
      ];

	case 'QDAFam'
		ChannelName = repmat('SI-Fam:MA-QDA', size(DeviceList,1), 1);

	case 'QDATrim'
		ChannelName = [
			'SI-01M2:MA-QDA'; 'SI-05M1:MA-QDA'; ...
			'SI-05M2:MA-QDA'; 'SI-09M1:MA-QDA'; ...
			'SI-09M2:MA-QDA'; 'SI-13M1:MA-QDA'; ...
			'SI-13M2:MA-QDA'; 'SI-17M1:MA-QDA'; ...
			'SI-17M2:MA-QDA'; 'SI-01M1:MA-QDA'; ...
      ];

	case 'Q1Fam'
		ChannelName = repmat('SI-Fam:MA-Q1', size(DeviceList,1), 1);

	case 'Q1Trim'
		ChannelName = [
			'SI-01C1:MA-Q1'; 'SI-01C4:MA-Q1'; 'SI-02C1:MA-Q1'; 'SI-02C4:MA-Q1' ;...
			'SI-03C1:MA-Q1'; 'SI-03C4:MA-Q1'; 'SI-04C1:MA-Q1'; 'SI-04C4:MA-Q1' ;...
			'SI-05C1:MA-Q1'; 'SI-05C4:MA-Q1'; 'SI-06C1:MA-Q1'; 'SI-06C4:MA-Q1' ;...
			'SI-07C1:MA-Q1'; 'SI-07C4:MA-Q1'; 'SI-08C1:MA-Q1'; 'SI-08C4:MA-Q1' ;...
			'SI-09C1:MA-Q1'; 'SI-09C4:MA-Q1'; 'SI-10C1:MA-Q1'; 'SI-10C4:MA-Q1' ;...
			'SI-11C1:MA-Q1'; 'SI-11C4:MA-Q1'; 'SI-12C1:MA-Q1'; 'SI-12C4:MA-Q1' ;...
			'SI-13C1:MA-Q1'; 'SI-13C4:MA-Q1'; 'SI-14C1:MA-Q1'; 'SI-14C4:MA-Q1' ;...
			'SI-15C1:MA-Q1'; 'SI-15C4:MA-Q1'; 'SI-16C1:MA-Q1'; 'SI-16C4:MA-Q1' ;...
			'SI-17C1:MA-Q1'; 'SI-17C4:MA-Q1'; 'SI-18C1:MA-Q1'; 'SI-18C4:MA-Q1' ;...
			'SI-19C1:MA-Q1'; 'SI-19C4:MA-Q1'; 'SI-20C1:MA-Q1'; 'SI-20C4:MA-Q1' ;...
			];

	case  'Q2Fam'
		ChannelName = repmat('SI-Fam:MA-Q2', size(DeviceList,1), 1);

	case  'Q2Trim'
		ChannelName = [
			'SI-01C1:MA-Q2'; 'SI-01C4:MA-Q2'; 'SI-02C1:MA-Q2'; 'SI-02C4:MA-Q2' ;...
			'SI-03C1:MA-Q2'; 'SI-03C4:MA-Q2'; 'SI-04C1:MA-Q2'; 'SI-04C4:MA-Q2' ;...
			'SI-05C1:MA-Q2'; 'SI-05C4:MA-Q2'; 'SI-06C1:MA-Q2'; 'SI-06C4:MA-Q2' ;...
			'SI-07C1:MA-Q2'; 'SI-07C4:MA-Q2'; 'SI-08C1:MA-Q2'; 'SI-08C4:MA-Q2' ;...
			'SI-09C1:MA-Q2'; 'SI-09C4:MA-Q2'; 'SI-10C1:MA-Q2'; 'SI-10C4:MA-Q2' ;...
			'SI-11C1:MA-Q2'; 'SI-11C4:MA-Q2'; 'SI-12C1:MA-Q2'; 'SI-12C4:MA-Q2' ;...
			'SI-13C1:MA-Q2'; 'SI-13C4:MA-Q2'; 'SI-14C1:MA-Q2'; 'SI-14C4:MA-Q2' ;...
			'SI-15C1:MA-Q2'; 'SI-15C4:MA-Q2'; 'SI-16C1:MA-Q2'; 'SI-16C4:MA-Q2' ;...
			'SI-17C1:MA-Q2'; 'SI-17C4:MA-Q2'; 'SI-18C1:MA-Q2'; 'SI-18C4:MA-Q2' ;...
			'SI-19C1:MA-Q2'; 'SI-19C4:MA-Q2'; 'SI-20C1:MA-Q2'; 'SI-20C4:MA-Q2' ;...
			];

	case  'Q3Fam'
		ChannelName = repmat('SI-Fam:MA-Q3', size(DeviceList,1), 1);

	case  'Q3Trim'
		ChannelName = [
			'SI-01C2:MA-Q3'; 'SI-01C3:MA-Q3'; 'SI-02C2:MA-Q3'; 'SI-02C3:MA-Q3' ;...
			'SI-03C2:MA-Q3'; 'SI-03C3:MA-Q3'; 'SI-04C2:MA-Q3'; 'SI-04C3:MA-Q3' ;...
			'SI-05C2:MA-Q3'; 'SI-05C3:MA-Q3'; 'SI-06C2:MA-Q3'; 'SI-06C3:MA-Q3' ;...
			'SI-07C2:MA-Q3'; 'SI-07C3:MA-Q3'; 'SI-08C2:MA-Q3'; 'SI-08C3:MA-Q3' ;...
			'SI-09C2:MA-Q3'; 'SI-09C3:MA-Q3'; 'SI-10C2:MA-Q3'; 'SI-10C3:MA-Q3' ;...
			'SI-11C2:MA-Q3'; 'SI-11C3:MA-Q3'; 'SI-12C2:MA-Q3'; 'SI-12C3:MA-Q3' ;...
			'SI-13C2:MA-Q3'; 'SI-13C3:MA-Q3'; 'SI-14C2:MA-Q3'; 'SI-14C3:MA-Q3' ;...
			'SI-15C2:MA-Q3'; 'SI-15C3:MA-Q3'; 'SI-16C2:MA-Q3'; 'SI-16C3:MA-Q3' ;...
			'SI-17C2:MA-Q3'; 'SI-17C3:MA-Q3'; 'SI-18C2:MA-Q3'; 'SI-18C3:MA-Q3' ;...
			'SI-19C2:MA-Q3'; 'SI-19C3:MA-Q3'; 'SI-20C2:MA-Q3'; 'SI-20C3:MA-Q3' ;...
			];

	case  'Q4Fam'
		ChannelName = repmat('SI-Fam:MA-Q4', size(DeviceList,1), 1);

	case  'Q4Trim'
		ChannelName = [
			'SI-01C2:MA-Q4'; 'SI-01C3:MA-Q4'; 'SI-02C2:MA-Q4'; 'SI-02C3:MA-Q4' ;...
			'SI-03C2:MA-Q4'; 'SI-03C3:MA-Q4'; 'SI-04C2:MA-Q4'; 'SI-04C3:MA-Q4' ;...
			'SI-05C2:MA-Q4'; 'SI-05C3:MA-Q4'; 'SI-06C2:MA-Q4'; 'SI-06C3:MA-Q4' ;...
			'SI-07C2:MA-Q4'; 'SI-07C3:MA-Q4'; 'SI-08C2:MA-Q4'; 'SI-08C3:MA-Q4' ;...
			'SI-09C2:MA-Q4'; 'SI-09C3:MA-Q4'; 'SI-10C2:MA-Q4'; 'SI-10C3:MA-Q4' ;...
			'SI-11C2:MA-Q4'; 'SI-11C3:MA-Q4'; 'SI-12C2:MA-Q4'; 'SI-12C3:MA-Q4' ;...
			'SI-13C2:MA-Q4'; 'SI-13C3:MA-Q4'; 'SI-14C2:MA-Q4'; 'SI-14C3:MA-Q4' ;...
			'SI-15C2:MA-Q4'; 'SI-15C3:MA-Q4'; 'SI-16C2:MA-Q4'; 'SI-16C3:MA-Q4' ;...
			'SI-17C2:MA-Q4'; 'SI-17C3:MA-Q4'; 'SI-18C2:MA-Q4'; 'SI-18C3:MA-Q4' ;...
			'SI-19C2:MA-Q4'; 'SI-19C3:MA-Q4'; 'SI-20C2:MA-Q4'; 'SI-20C3:MA-Q4' ;...
			];

	case  'QDB1Fam'
		ChannelName = repmat('SI-Fam:MA-QDB1', size(DeviceList,1), 1);

	case  'QDB1Trim'
		ChannelName = [
			'SI-02M1:MA-QDB1'; 'SI-02M2:MA-QDB1'; 'SI-04M1:MA-QDB1'; 'SI-04M2:MA-QDB1' ;...
			'SI-06M1:MA-QDB1'; 'SI-06M2:MA-QDB1'; 'SI-08M1:MA-QDB1'; 'SI-08M2:MA-QDB1' ;...
			'SI-10M1:MA-QDB1'; 'SI-10M2:MA-QDB1'; 'SI-12M1:MA-QDB1'; 'SI-12M2:MA-QDB1' ;...
			'SI-14M1:MA-QDB1'; 'SI-14M2:MA-QDB1'; 'SI-16M1:MA-QDB1'; 'SI-16M2:MA-QDB1' ;...
			'SI-18M1:MA-QDB1'; 'SI-18M2:MA-QDB1'; 'SI-20M1:MA-QDB1'; 'SI-20M2:MA-QDB1' ;...
			];

	case  'QFBFam'
		ChannelName = repmat('SI-Fam:MA-QFB', size(DeviceList,1), 1);

	case  'QFBTrim'
		ChannelName = [
			'SI-02M1:MA-QFB'; 'SI-02M2:MA-QFB'; 'SI-04M1:MA-QFB'; 'SI-04M2:MA-QFB' ;...
			'SI-06M1:MA-QFB'; 'SI-06M2:MA-QFB'; 'SI-08M1:MA-QFB'; 'SI-08M2:MA-QFB' ;...
			'SI-10M1:MA-QFB'; 'SI-10M2:MA-QFB'; 'SI-12M1:MA-QFB'; 'SI-12M2:MA-QFB' ;...
			'SI-14M1:MA-QFB'; 'SI-14M2:MA-QFB'; 'SI-16M1:MA-QFB'; 'SI-16M2:MA-QFB' ;...
			'SI-18M1:MA-QFB'; 'SI-18M2:MA-QFB'; 'SI-20M1:MA-QFB'; 'SI-20M2:MA-QFB' ;...
			];

	case  'QDB2Fam'
		ChannelName = repmat('SI-Fam:MA-QDB2', size(DeviceList,1), 1);

	case  'QDB2Trim'
		ChannelName = [
			'SI-02M1:MA-QDB2'; 'SI-02M2:MA-QDB2'; 'SI-04M1:MA-QDB2'; 'SI-04M2:MA-QDB2' ;...
			'SI-06M1:MA-QDB2'; 'SI-06M2:MA-QDB2'; 'SI-08M1:MA-QDB2'; 'SI-08M2:MA-QDB2' ;...
			'SI-10M1:MA-QDB2'; 'SI-10M2:MA-QDB2'; 'SI-12M1:MA-QDB2'; 'SI-12M2:MA-QDB2' ;...
			'SI-14M1:MA-QDB2'; 'SI-14M2:MA-QDB2'; 'SI-16M1:MA-QDB2'; 'SI-16M2:MA-QDB2' ;...
			'SI-18M1:MA-QDB2'; 'SI-18M2:MA-QDB2'; 'SI-20M1:MA-QDB2'; 'SI-20M2:MA-QDB2' ;...
			];
    case  'QDP1Fam'
		ChannelName = repmat('SI-Fam:MA-QDP1', size(DeviceList,1), 1);

	case  'QDP1Trim'
		ChannelName = [
			'SI-03M1:MA-QDP1'; 'SI-03M2:MA-QDP1'; ...
			'SI-07M1:MA-QDP1'; 'SI-07M2:MA-QDP1'; ...
			'SI-11M1:MA-QDP1'; 'SI-11M2:MA-QDP1'; ...
			'SI-15M1:MA-QDP1'; 'SI-15M2:MA-QDP1'; ...
			'SI-19M1:MA-QDP1'; 'SI-19M2:MA-QDP1'; ...
			];

	case  'QFPFam'
		ChannelName = repmat('SI-Fam:MA-QFP', size(DeviceList,1), 1);

	case  'QFPTrim'
		ChannelName = [
			'SI-03M1:MA-QFB'; 'SI-03M2:MA-QFB'; ...
			'SI-07M1:MA-QFB'; 'SI-07M2:MA-QFB'; ...
			'SI-11M1:MA-QFB'; 'SI-11M2:MA-QFB'; ...
			'SI-15M1:MA-QFB'; 'SI-15M2:MA-QFB'; ...
			'SI-19M1:MA-QFB'; 'SI-19M2:MA-QFB'; ...
			];

	case  'QDP2Fam'
		ChannelName = repmat('SI-Fam:MA-QDP2', size(DeviceList,1), 1);

	case  'QDP2Trim'
		ChannelName = [
			'SI-03M1:MA-QDP2'; 'SI-03M2:MA-QDP2'; ...
			'SI-07M1:MA-QDP2'; 'SI-07M2:MA-QDP2'; ...
			'SI-11M1:MA-QDP2'; 'SI-11M2:MA-QDP2'; ...
			'SI-15M1:MA-QDP2'; 'SI-15M2:MA-QDP2'; ...
			'SI-19M1:MA-QDP2'; 'SI-19M2:MA-QDP2'; ...
			];

    case  'SFA0'
        ChannelName = repmat('SI-Fam:MA-SFA0', size(DeviceList,1), 1);

    case  'SFB0'
        ChannelName = repmat('SI-Fam:MA-SFB0', size(DeviceList,1), 1);

    case  'SFP0'
        ChannelName = repmat('SI-Fam:MA-SFP0', size(DeviceList,1), 1);

    case  'SFA1'
        ChannelName = repmat('SI-Fam:MA-SFA1', size(DeviceList,1), 1);

    case  'SFB1'
        ChannelName = repmat('SI-Fam:MA-SFB1', size(DeviceList,1), 1);

    case  'SFP1'
        ChannelName = repmat('SI-Fam:MA-SFP1', size(DeviceList,1), 1);

    case  'SFA2'
        ChannelName = repmat('SI-Fam:MA-SFA2', size(DeviceList,1), 1);

    case  'SFB2'
        ChannelName = repmat('SI-Fam:MA-SFB2', size(DeviceList,1), 1);

    case  'SFP2'
        ChannelName = repmat('SI-Fam:MA-SFP2', size(DeviceList,1), 1);

    case  'SDA0'
        ChannelName = repmat('SI-Fam:MA-SDA0', size(DeviceList,1), 1);

    case  'SDB0'
        ChannelName = repmat('SI-Fam:MA-SDB0', size(DeviceList,1), 1);

    case  'SDP0'
        ChannelName = repmat('SI-Fam:MA-SDP0', size(DeviceList,1), 1);

    case  'SDA1'
        ChannelName = repmat('SI-Fam:MA-SDA1', size(DeviceList,1), 1);

    case  'SDB1'
        ChannelName = repmat('SI-Fam:MA-SDB1', size(DeviceList,1), 1);

    case  'SDP1'
        ChannelName = repmat('SI-Fam:MA-SDP1', size(DeviceList,1), 1);

    case  'SDA2'
        ChannelName = repmat('SI-Fam:MA-SDA2', size(DeviceList,1), 1);

    case  'SDB2'
        ChannelName = repmat('SI-Fam:MA-SDB2', size(DeviceList,1), 1);

    case  'SDP2'
        ChannelName = repmat('SI-Fam:MA-SDP2', size(DeviceList,1), 1);

    case  'SDA3'
        ChannelName = repmat('SI-Fam:MA-SDA3', size(DeviceList,1), 1);

    case  'SDB3'
        ChannelName = repmat('SI-Fam:MA-SDB3', size(DeviceList,1), 1);

    case  'SDP3'
        ChannelName = repmat('SI-Fam:MA-SDP3', size(DeviceList,1), 1);

    case {'hcm', 'CH'}
		ChannelName = [
            'SI-01M2:MA-CH'; 'SI-01C1:MA-CH'; 'SI-01C2:MA-CH'; 'SI-01C3:MA-CH'; 'SI-01C4:MA-CH'; 'SI-02M1:MA-CH'; ...
            'SI-02M2:MA-CH'; 'SI-02C1:MA-CH'; 'SI-02C2:MA-CH'; 'SI-02C3:MA-CH'; 'SI-02C4:MA-CH'; 'SI-03M1:MA-CH'; ...
            'SI-03M2:MA-CH'; 'SI-03C1:MA-CH'; 'SI-03C2:MA-CH'; 'SI-03C3:MA-CH'; 'SI-03C4:MA-CH'; 'SI-04M1:MA-CH'; ...
			'SI-04M2:MA-CH'; 'SI-04C1:MA-CH'; 'SI-04C2:MA-CH'; 'SI-04C3:MA-CH'; 'SI-04C4:MA-CH'; 'SI-05M1:MA-CH'; ...
            'SI-05M2:MA-CH'; 'SI-05C1:MA-CH'; 'SI-05C2:MA-CH'; 'SI-05C3:MA-CH'; 'SI-05C4:MA-CH'; 'SI-06M1:MA-CH'; ...
			'SI-06M2:MA-CH'; 'SI-06C1:MA-CH'; 'SI-06C2:MA-CH'; 'SI-06C3:MA-CH'; 'SI-06C4:MA-CH'; 'SI-07M1:MA-CH'; ...
            'SI-07M2:MA-CH'; 'SI-07C1:MA-CH'; 'SI-07C2:MA-CH'; 'SI-07C3:MA-CH'; 'SI-07C4:MA-CH'; 'SI-08M1:MA-CH'; ...
			'SI-08M2:MA-CH'; 'SI-08C1:MA-CH'; 'SI-08C2:MA-CH'; 'SI-08C3:MA-CH'; 'SI-08C4:MA-CH'; 'SI-09M1:MA-CH'; ...
            'SI-09M2:MA-CH'; 'SI-09C1:MA-CH'; 'SI-09C2:MA-CH'; 'SI-09C3:MA-CH'; 'SI-09C4:MA-CH'; 'SI-10M1:MA-CH'; ...
			'SI-10M2:MA-CH'; 'SI-10C1:MA-CH'; 'SI-10C2:MA-CH'; 'SI-10C3:MA-CH'; 'SI-10C4:MA-CH'; 'SI-11M1:MA-CH'; ...
            'SI-11M2:MA-CH'; 'SI-11C1:MA-CH'; 'SI-11C2:MA-CH'; 'SI-11C3:MA-CH'; 'SI-11C4:MA-CH'; 'SI-12M1:MA-CH'; ...
			'SI-12M2:MA-CH'; 'SI-12C1:MA-CH'; 'SI-12C2:MA-CH'; 'SI-12C3:MA-CH'; 'SI-12C4:MA-CH'; 'SI-13M1:MA-CH'; ...
            'SI-13M2:MA-CH'; 'SI-13C1:MA-CH'; 'SI-13C2:MA-CH'; 'SI-13C3:MA-CH'; 'SI-13C4:MA-CH'; 'SI-14M1:MA-CH'; ...
			'SI-14M2:MA-CH'; 'SI-14C1:MA-CH'; 'SI-14C2:MA-CH'; 'SI-14C3:MA-CH'; 'SI-14C4:MA-CH'; 'SI-15M1:MA-CH'; ...
            'SI-15M2:MA-CH'; 'SI-15C1:MA-CH'; 'SI-15C2:MA-CH'; 'SI-15C3:MA-CH'; 'SI-15C4:MA-CH'; 'SI-16M1:MA-CH'; ...
			'SI-16M2:MA-CH'; 'SI-16C1:MA-CH'; 'SI-16C2:MA-CH'; 'SI-16C3:MA-CH'; 'SI-16C4:MA-CH'; 'SI-17M1:MA-CH'; ...
            'SI-17M2:MA-CH'; 'SI-17C1:MA-CH'; 'SI-17C2:MA-CH'; 'SI-17C3:MA-CH'; 'SI-17C4:MA-CH'; 'SI-18M1:MA-CH'; ...
			'SI-18M2:MA-CH'; 'SI-18C1:MA-CH'; 'SI-18C2:MA-CH'; 'SI-18C3:MA-CH'; 'SI-18C4:MA-CH'; 'SI-19M1:MA-CH'; ...
            'SI-19M2:MA-CH'; 'SI-19C1:MA-CH'; 'SI-19C2:MA-CH'; 'SI-19C3:MA-CH'; 'SI-19C4:MA-CH'; 'SI-20M1:MA-CH'; ...
			'SI-20M2:MA-CH'; 'SI-20C1:MA-CH'; 'SI-20C2:MA-CH'; 'SI-20C3:MA-CH'; 'SI-20C4:MA-CH'; 'SI-01M1:MA-CH';
            ];

    case {'vcm', 'CV'}
        ChannelName = [
			'SI-01M2:MA-CV  '; 'SI-01C1:MA-CV  '; 'SI-01C2:MA-CV-1'; 'SI-01C2:MA-CV-2'; ...
			'SI-01C3:MA-CV-1'; 'SI-01C3:MA-CV-2'; 'SI-01C4:MA-CV  '; 'SI-02M1:MA-CV  '; ...
			'SI-02M2:MA-CV  '; 'SI-02C1:MA-CV  '; 'SI-02C2:MA-CV-1'; 'SI-02C2:MA-CV-2'; ...
			'SI-02C3:MA-CV-1'; 'SI-02C3:MA-CV-2'; 'SI-02C4:MA-CV  '; 'SI-03M1:MA-CV  '; ...
			'SI-03M2:MA-CV  '; 'SI-03C1:MA-CV  '; 'SI-03C2:MA-CV-1'; 'SI-03C2:MA-CV-2'; ...
			'SI-03C3:MA-CV-1'; 'SI-03C3:MA-CV-2'; 'SI-03C4:MA-CV  '; 'SI-04M1:MA-CV  '; ...
			'SI-04M2:MA-CV  '; 'SI-04C1:MA-CV  '; 'SI-04C2:MA-CV-1'; 'SI-04C2:MA-CV-2'; ...
			'SI-04C3:MA-CV-1'; 'SI-04C3:MA-CV-2'; 'SI-04C4:MA-CV  '; 'SI-05M1:MA-CV  '; ...
			'SI-05M2:MA-CV  '; 'SI-05C1:MA-CV  '; 'SI-05C2:MA-CV-1'; 'SI-05C2:MA-CV-2'; ...
			'SI-05C3:MA-CV-1'; 'SI-05C3:MA-CV-2'; 'SI-05C4:MA-CV  '; 'SI-06M1:MA-CV  '; ...
			'SI-06M2:MA-CV  '; 'SI-06C1:MA-CV  '; 'SI-06C2:MA-CV-1'; 'SI-06C2:MA-CV-2'; ...
			'SI-06C3:MA-CV-1'; 'SI-06C3:MA-CV-2'; 'SI-06C4:MA-CV  '; 'SI-07M1:MA-CV  '; ...
			'SI-07M2:MA-CV  '; 'SI-07C1:MA-CV  '; 'SI-07C2:MA-CV-1'; 'SI-07C2:MA-CV-2'; ...
			'SI-07C3:MA-CV-1'; 'SI-07C3:MA-CV-2'; 'SI-07C4:MA-CV  '; 'SI-08M1:MA-CV  '; ...
			'SI-08M2:MA-CV  '; 'SI-08C1:MA-CV  '; 'SI-08C2:MA-CV-1'; 'SI-08C2:MA-CV-2'; ...
			'SI-08C3:MA-CV-1'; 'SI-08C3:MA-CV-2'; 'SI-08C4:MA-CV  '; 'SI-09M1:MA-CV  '; ...
			'SI-09M2:MA-CV  '; 'SI-09C1:MA-CV  '; 'SI-09C2:MA-CV-1'; 'SI-09C2:MA-CV-2'; ...
			'SI-09C3:MA-CV-1'; 'SI-09C3:MA-CV-2'; 'SI-09C4:MA-CV  '; 'SI-10M1:MA-CV  '; ...
			'SI-10M2:MA-CV  '; 'SI-10C1:MA-CV  '; 'SI-10C2:MA-CV-1'; 'SI-10C2:MA-CV-2'; ...
			'SI-10C3:MA-CV-1'; 'SI-10C3:MA-CV-2'; 'SI-10C4:MA-CV  '; 'SI-11M1:MA-CV  '; ...
			'SI-11M2:MA-CV  '; 'SI-11C1:MA-CV  '; 'SI-11C2:MA-CV-1'; 'SI-11C2:MA-CV-2'; ...
			'SI-11C3:MA-CV-1'; 'SI-11C3:MA-CV-2'; 'SI-11C4:MA-CV  '; 'SI-12M1:MA-CV  '; ...
			'SI-12M2:MA-CV  '; 'SI-12C1:MA-CV  '; 'SI-12C2:MA-CV-1'; 'SI-12C2:MA-CV-2'; ...
			'SI-12C3:MA-CV-1'; 'SI-12C3:MA-CV-2'; 'SI-12C4:MA-CV  '; 'SI-13M1:MA-CV  '; ...
			'SI-13M2:MA-CV  '; 'SI-13C1:MA-CV  '; 'SI-13C2:MA-CV-1'; 'SI-13C2:MA-CV-2'; ...
			'SI-13C3:MA-CV-1'; 'SI-13C3:MA-CV-2'; 'SI-13C4:MA-CV  '; 'SI-14M1:MA-CV  '; ...
			'SI-14M2:MA-CV  '; 'SI-14C1:MA-CV  '; 'SI-14C2:MA-CV-1'; 'SI-14C2:MA-CV-2'; ...
			'SI-14C3:MA-CV-1'; 'SI-14C3:MA-CV-2'; 'SI-14C4:MA-CV  '; 'SI-15M1:MA-CV  '; ...
			'SI-15M2:MA-CV  '; 'SI-15C1:MA-CV  '; 'SI-15C2:MA-CV-1'; 'SI-15C2:MA-CV-2'; ...
			'SI-15C3:MA-CV-1'; 'SI-15C3:MA-CV-2'; 'SI-15C4:MA-CV  '; 'SI-16M1:MA-CV  '; ...
			'SI-16M2:MA-CV  '; 'SI-16C1:MA-CV  '; 'SI-16C2:MA-CV-1'; 'SI-16C2:MA-CV-2'; ...
			'SI-16C3:MA-CV-1'; 'SI-16C3:MA-CV-2'; 'SI-16C4:MA-CV  '; 'SI-17M1:MA-CV  '; ...
			'SI-17M2:MA-CV  '; 'SI-17C1:MA-CV  '; 'SI-17C2:MA-CV-1'; 'SI-17C2:MA-CV-2'; ...
			'SI-17C3:MA-CV-1'; 'SI-17C3:MA-CV-2'; 'SI-17C4:MA-CV  '; 'SI-18M1:MA-CV  '; ...
			'SI-18M2:MA-CV  '; 'SI-18C1:MA-CV  '; 'SI-18C2:MA-CV-1'; 'SI-18C2:MA-CV-2'; ...
			'SI-18C3:MA-CV-1'; 'SI-18C3:MA-CV-2'; 'SI-18C4:MA-CV  '; 'SI-19M1:MA-CV  '; ...
			'SI-19M2:MA-CV  '; 'SI-19C1:MA-CV  '; 'SI-19C2:MA-CV-1'; 'SI-19C2:MA-CV-2'; ...
			'SI-19C3:MA-CV-1'; 'SI-19C3:MA-CV-2'; 'SI-19C4:MA-CV  '; 'SI-20M1:MA-CV  '; ...
			'SI-20M2:MA-CV  '; 'SI-20C1:MA-CV  '; 'SI-20C2:MA-CV-1'; 'SI-20C2:MA-CV-2'; ...
			'SI-20C3:MA-CV-1'; 'SI-20C3:MA-CV-2'; 'SI-20C4:MA-CV  '; 'SI-01M1:MA-CV  ';
			];

    case  'FCH'
		ChannelName = [
			'SI-01M2:MA-FCH'; 'SI-01C2:MA-FCH'; 'SI-01C3:MA-FCH'; 'SI-02M1:MA-FCH'; ...
			'SI-02M2:MA-FCH'; 'SI-02C2:MA-FCH'; 'SI-02C3:MA-FCH'; 'SI-03M1:MA-FCH'; ...
			'SI-03M2:MA-FCH'; 'SI-03C2:MA-FCH'; 'SI-03C3:MA-FCH'; 'SI-04M1:MA-FCH'; ...
			'SI-04M2:MA-FCH'; 'SI-04C2:MA-FCH'; 'SI-04C3:MA-FCH'; 'SI-05M1:MA-FCH'; ...
			'SI-05M2:MA-FCH'; 'SI-05C2:MA-FCH'; 'SI-05C3:MA-FCH'; 'SI-06M1:MA-FCH'; ...
			'SI-06M2:MA-FCH'; 'SI-06C2:MA-FCH'; 'SI-06C3:MA-FCH'; 'SI-07M1:MA-FCH'; ...
			'SI-07M2:MA-FCH'; 'SI-07C2:MA-FCH'; 'SI-07C3:MA-FCH'; 'SI-08M1:MA-FCH'; ...
			'SI-08M2:MA-FCH'; 'SI-08C2:MA-FCH'; 'SI-08C3:MA-FCH'; 'SI-09M1:MA-FCH'; ...
			'SI-09M2:MA-FCH'; 'SI-09C2:MA-FCH'; 'SI-09C3:MA-FCH'; 'SI-10M1:MA-FCH'; ...
			'SI-10M2:MA-FCH'; 'SI-10C2:MA-FCH'; 'SI-10C3:MA-FCH'; 'SI-11M1:MA-FCH'; ...
			'SI-11M2:MA-FCH'; 'SI-11C2:MA-FCH'; 'SI-11C3:MA-FCH'; 'SI-12M1:MA-FCH'; ...
			'SI-12M2:MA-FCH'; 'SI-12C2:MA-FCH'; 'SI-12C3:MA-FCH'; 'SI-13M1:MA-FCH'; ...
			'SI-13M2:MA-FCH'; 'SI-13C2:MA-FCH'; 'SI-13C3:MA-FCH'; 'SI-14M1:MA-FCH'; ...
			'SI-14M2:MA-FCH'; 'SI-14C2:MA-FCH'; 'SI-14C3:MA-FCH'; 'SI-15M1:MA-FCH'; ...
			'SI-15M2:MA-FCH'; 'SI-15C2:MA-FCH'; 'SI-15C3:MA-FCH'; 'SI-16M1:MA-FCH'; ...
			'SI-16M2:MA-FCH'; 'SI-16C2:MA-FCH'; 'SI-16C3:MA-FCH'; 'SI-17M1:MA-FCH'; ...
			'SI-17M2:MA-FCH'; 'SI-17C2:MA-FCH'; 'SI-17C3:MA-FCH'; 'SI-18M1:MA-FCH'; ...
			'SI-18M2:MA-FCH'; 'SI-18C2:MA-FCH'; 'SI-18C3:MA-FCH'; 'SI-19M1:MA-FCH'; ...
			'SI-19M2:MA-FCH'; 'SI-19C2:MA-FCH'; 'SI-19C3:MA-FCH'; 'SI-20M1:MA-FCH'; ...
			'SI-20M2:MA-FCH'; 'SI-20C2:MA-FCH'; 'SI-20C3:MA-FCH'; 'SI-01M1:MA-FCH';
			];

	case  'FCV'
		ChannelName = [
			'SI-01M2:MA-FCV'; 'SI-01C2:MA-FCV'; 'SI-01C3:MA-FCV'; 'SI-02M1:MA-FCV'; ...
			'SI-02M2:MA-FCV'; 'SI-02C2:MA-FCV'; 'SI-02C3:MA-FCV'; 'SI-03M1:MA-FCV'; ...
			'SI-03M2:MA-FCV'; 'SI-03C2:MA-FCV'; 'SI-03C3:MA-FCV'; 'SI-04M1:MA-FCV'; ...
			'SI-04M2:MA-FCV'; 'SI-04C2:MA-FCV'; 'SI-04C3:MA-FCV'; 'SI-05M1:MA-FCV'; ...
			'SI-05M2:MA-FCV'; 'SI-05C2:MA-FCV'; 'SI-05C3:MA-FCV'; 'SI-06M1:MA-FCV'; ...
			'SI-06M2:MA-FCV'; 'SI-06C2:MA-FCV'; 'SI-06C3:MA-FCV'; 'SI-07M1:MA-FCV'; ...
			'SI-07M2:MA-FCV'; 'SI-07C2:MA-FCV'; 'SI-07C3:MA-FCV'; 'SI-08M1:MA-FCV'; ...
			'SI-08M2:MA-FCV'; 'SI-08C2:MA-FCV'; 'SI-08C3:MA-FCV'; 'SI-09M1:MA-FCV'; ...
			'SI-09M2:MA-FCV'; 'SI-09C2:MA-FCV'; 'SI-09C3:MA-FCV'; 'SI-10M1:MA-FCV'; ...
			'SI-10M2:MA-FCV'; 'SI-10C2:MA-FCV'; 'SI-10C3:MA-FCV'; 'SI-11M1:MA-FCV'; ...
			'SI-11M2:MA-FCV'; 'SI-11C2:MA-FCV'; 'SI-11C3:MA-FCV'; 'SI-12M1:MA-FCV'; ...
			'SI-12M2:MA-FCV'; 'SI-12C2:MA-FCV'; 'SI-12C3:MA-FCV'; 'SI-13M1:MA-FCV'; ...
			'SI-13M2:MA-FCV'; 'SI-13C2:MA-FCV'; 'SI-13C3:MA-FCV'; 'SI-14M1:MA-FCV'; ...
			'SI-14M2:MA-FCV'; 'SI-14C2:MA-FCV'; 'SI-14C3:MA-FCV'; 'SI-15M1:MA-FCV'; ...
			'SI-15M2:MA-FCV'; 'SI-15C2:MA-FCV'; 'SI-15C3:MA-FCV'; 'SI-16M1:MA-FCV'; ...
			'SI-16M2:MA-FCV'; 'SI-16C2:MA-FCV'; 'SI-16C3:MA-FCV'; 'SI-17M1:MA-FCV'; ...
			'SI-17M2:MA-FCV'; 'SI-17C2:MA-FCV'; 'SI-17C3:MA-FCV'; 'SI-18M1:MA-FCV'; ...
			'SI-18M2:MA-FCV'; 'SI-18C2:MA-FCV'; 'SI-18C3:MA-FCV'; 'SI-19M1:MA-FCV'; ...
			'SI-19M2:MA-FCV'; 'SI-19C2:MA-FCV'; 'SI-19C3:MA-FCV'; 'SI-20M1:MA-FCV'; ...
			'SI-20M2:MA-FCV'; 'SI-20C2:MA-FCV'; 'SI-20C3:MA-FCV'; 'SI-01M1:MA-FCV';
			];

    case  {'skewquad', 'QS'}
        ChannelName = [
            'SI-01M2:MA-QS'; 'SI-01C1:MA-QS'; 'SI-01C2:MA-QS'; 'SI-01C3:MA-QS'; 'SI-02M1:MA-QS'; ...
            'SI-02M2:MA-QS'; 'SI-02C1:MA-QS'; 'SI-02C2:MA-QS'; 'SI-02C3:MA-QS'; 'SI-03M1:MA-QS'; ...
            'SI-03M2:MA-QS'; 'SI-03C1:MA-QS'; 'SI-03C2:MA-QS'; 'SI-03C3:MA-QS'; 'SI-04M1:MA-QS'; ...
            'SI-04M2:MA-QS'; 'SI-04C1:MA-QS'; 'SI-04C2:MA-QS'; 'SI-04C3:MA-QS'; 'SI-05M1:MA-QS'; ...
            'SI-05M2:MA-QS'; 'SI-05C1:MA-QS'; 'SI-05C2:MA-QS'; 'SI-05C3:MA-QS'; 'SI-06M1:MA-QS'; ...
            'SI-06M2:MA-QS'; 'SI-06C1:MA-QS'; 'SI-06C2:MA-QS'; 'SI-06C3:MA-QS'; 'SI-07M1:MA-QS'; ...
            'SI-07M2:MA-QS'; 'SI-07C1:MA-QS'; 'SI-07C2:MA-QS'; 'SI-07C3:MA-QS'; 'SI-08M1:MA-QS'; ...
            'SI-08M2:MA-QS'; 'SI-08C1:MA-QS'; 'SI-08C2:MA-QS'; 'SI-08C3:MA-QS'; 'SI-09M1:MA-QS'; ...
            'SI-09M2:MA-QS'; 'SI-09C1:MA-QS'; 'SI-09C2:MA-QS'; 'SI-09C3:MA-QS'; 'SI-10M1:MA-QS'; ...
            'SI-10M2:MA-QS'; 'SI-10C1:MA-QS'; 'SI-10C2:MA-QS'; 'SI-10C3:MA-QS'; 'SI-11M1:MA-QS'; ...
            'SI-11M2:MA-QS'; 'SI-11C1:MA-QS'; 'SI-11C2:MA-QS'; 'SI-11C3:MA-QS'; 'SI-12M1:MA-QS'; ...
            'SI-12M2:MA-QS'; 'SI-12C1:MA-QS'; 'SI-12C2:MA-QS'; 'SI-12C3:MA-QS'; 'SI-13M1:MA-QS'; ...
            'SI-13M2:MA-QS'; 'SI-13C1:MA-QS'; 'SI-13C2:MA-QS'; 'SI-13C3:MA-QS'; 'SI-14M1:MA-QS'; ...
            'SI-14M2:MA-QS'; 'SI-14C1:MA-QS'; 'SI-14C2:MA-QS'; 'SI-14C3:MA-QS'; 'SI-15M1:MA-QS'; ...
            'SI-15M2:MA-QS'; 'SI-15C1:MA-QS'; 'SI-15C2:MA-QS'; 'SI-15C3:MA-QS'; 'SI-16M1:MA-QS'; ...
            'SI-16M2:MA-QS'; 'SI-16C1:MA-QS'; 'SI-16C2:MA-QS'; 'SI-16C3:MA-QS'; 'SI-17M1:MA-QS'; ...
            'SI-17M2:MA-QS'; 'SI-17C1:MA-QS'; 'SI-17C2:MA-QS'; 'SI-17C3:MA-QS'; 'SI-18M1:MA-QS'; ...
            'SI-18M2:MA-QS'; 'SI-18C1:MA-QS'; 'SI-18C2:MA-QS'; 'SI-18C3:MA-QS'; 'SI-19M1:MA-QS'; ...
            'SI-19M2:MA-QS'; 'SI-19C1:MA-QS'; 'SI-19C2:MA-QS'; 'SI-19C3:MA-QS'; 'SI-20M1:MA-QS'; ...
            'SI-20M2:MA-QS'; 'SI-20C1:MA-QS'; 'SI-20C2:MA-QS'; 'SI-20C3:MA-QS'; 'SI-01M1:MA-QS';
            ];

    case 'RF'
        % if operating with Superconductor cavity
        % ChannelName = 'SI-03SP:RF-SRFCav:Frequency';
        % if operating with PETRA-7 cavity
        ChannelName = 'SI-02SB:RF-P7Cav';

    case {'B1', 'B2'}
        ChannelName = 'SI-Fam:MA-B1B2';

    case 'DCCT'
        ChannelName = ['SI-13C4:DI-DCCT:Current-Mon';
                       'SI-14C4:DI-DCCT:Current-Mon' ];

    case 'TUNE'
        ChannelName = ['SI-17C4:DI-VTuneP:TuneY-Mon';
                       'SI-18SB:DI-HTuneP:TuneX-Mon' ];

    otherwise
        error('Don''t know how to make the channel name for family %s', Family);

end

if any(strcmpi(Family, {'BPMx', 'BPMy', 'DCCT', 'TUNE'}))

elseif strcmpi(Family, 'RF')
    if strcmpi(Field, 'Monitor')
        ChannelName = strcat(prefix, ChannelName, ':Frequency-Mon');
    elseif strcmpi(Field, 'Setpoint')
        ChannelName = strcat(prefix, ChannelName, ':Frequency-SP');
    elseif strcmpi(Field, 'VoltageMonitor')
        ChannelName = strcat(prefix, ChannelName, ':Voltage-Mon');
    elseif strcmpi(Field, 'VoltageSetpoint')
        ChannelName = strcat(prefix, ChannelName, ':Voltage-SP');
    end

else %Bends, Quads, Sexts and Correctors
    if strcmpi(Field, 'Monitor')
        ChannelName = strcat(prefix, ChannelName, ':Current-Mon');
    elseif strcmpi(Field, 'Readback')
        ChannelName = strcat(prefix, ChannelName, ':Current-RB');
    elseif strcmpi(Field, 'Setpoint')
        ChannelName = strcat(prefix, ChannelName, ':Current-SP');
    elseif strcmpi(Field, 'ReferenceMonitor')
        ChannelName = strcat(prefix, ChannelName, ':CurrentRef-Mon');
    end
end

end
