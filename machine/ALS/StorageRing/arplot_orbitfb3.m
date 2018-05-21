function arplot_orbitfb3(monthStr, days, year1, month2Str, days2, year2)
% arplot_orbitfb3(Month1 String, Days1, Year1, Month2 String, Days2, Year2)
% 
% Plots archived data about the orbit feedback, specifically the AM-AC of the
% 		correctors used. The AM channel is the sum of the trim value plus the normal AM,
%		while the AC is just the normal AC, so the resulting plot represents the action
%		of the orbit feedback systems together.
%		- this modified version by T. Scarvie, June 2004
%
% Example:  arplots_orbitfb3('January',22:24, 2008);
%           plots data from 1/22, 1/23, and 1/24 in 2008
%
% C. Steier, May 2002

% Modified for new ML 2007-11-19, T.Scarvie

tightaxis = 1; % change to 1 if you want the vertical axis auto-scaled

HCMlist = [1 2;1 8;2 1;2 8;3 1;3 7;3 8;4 1;4 2;4 8;5 1;5 8;6 1;6 8; ...
      7 1;7 8;8 1;8 8;9 1;9 8;10 1;10 8;11 1;11 8;12 1;12 7];
VCMlist = getlist('VCM','Trim');

HCMCHICANElist = [4 2;6 2;11 2];
VCMCHICANElist = [4 2;6 2;11 2];

BPMlist = getlist('BPMx');
BPMlist = [BPMlist;4 3;4 4;11 3;11 4];

Sx1 = getrespmat('BPMx',BPMlist,'HCM',HCMlist,[],1.9);
Sy1 = getrespmat('BPMy',BPMlist,'VCM',VCMlist,[],1.9);
% Sx2 = getrespmat('BPMx',BPMlist,'HCMCHICANE',HCMCHICANElist,[],1.9);
% Sy2 = getrespmat('BPMy',BPMlist,'VCMCHICANE',VCMCHICANElist,[],1.9);

Sx = [Sx1];
Sy = [Sy1];
% Sx = [Sx1 Sx2];
% Sy = [Sy1 Sy2];

% Inputs
if nargin < 2
   error('ARPLOTS:  You need at least two input arguments.');
elseif nargin == 2
   tmp = clock;
   year1 = tmp(1);
   monthStr2 = [];
   days2 = [];
   year2 = [];
elseif nargin == 3
   monthStr2 = [];
   days2 = [];
   year2 = [];
elseif nargin == 4
   error('ARPLOTS:  You need 2, 3, 5, or 6 input arguments.');
elseif nargin == 5
   tmp = clock;
   year2 = tmp(1);
elseif nargin == 6
else
   error('ARPLOTS:  Inputs incorrect.');
end


arglobal


t=[];

hcm12 = []; hcm18 = []; hcm21 = []; hcm28 = []; hcm31 = []; hcm37 = []; hcm38 = []; hcmu42 = []; hcm41 = []; hcm42 = [];  hcm48 = [];
hcm12am=[]; hcm18am=[]; hcm21am=[]; hcm28am=[]; hcm31am=[]; hcm37am = []; hcm38am=[]; hcmu42am=[]; hcm41am=[]; hcm42am = [];  hcm48am=[];
hcm51 = []; hcm58 = []; hcm61 = []; hcm68 = []; hcm71 = []; hcm78 = []; hcm81 = []; hcm88 = [];
hcm51am=[]; hcm58am=[]; hcm61am=[]; hcm68am=[]; hcm71am=[]; hcm78am=[]; hcm81am=[]; hcm88am=[];
hcm91 = []; hcm98 = []; hcm101 = []; hcm108 = []; hcmu112 = []; hcm111 = []; hcm118 = []; hcm121 = []; hcm127 = [];
hcm91am=[]; hcm98am=[]; hcm101am=[]; hcm108am=[]; hcmu112am=[]; hcm111am=[]; hcm118am=[]; hcm121am=[]; hcm127am=[];

vcm12 = []; vcm17 = []; vcm18 = []; vcm21 = []; vcm22 = []; vcm27 = []; vcm28 = []; 
vcm12am=[]; vcm17am=[]; vcm18am=[]; vcm21am=[]; vcm22am=[]; vcm27am=[]; vcm28am=[]; 
vcm31 = []; vcm32 = []; vcm37 = []; vcm38 = []; vcmu42 = []; vcm41 = []; vcm42 = []; vcm47 = []; vcm48 = [];
vcm31am=[]; vcm32am=[]; vcm37am=[]; vcm38am=[]; vcmu42am=[]; vcm41am=[]; vcm42am=[]; vcm47am=[]; vcm48am=[];
vcm51 = []; vcm52 = []; vcm57 = []; vcm58 = []; vcm61 = []; vcm62 = []; vcm67 = []; vcm68 = [];
vcm51am=[]; vcm52am=[]; vcm57am=[]; vcm58am=[]; vcm61am=[]; vcm62am=[]; vcm67am=[]; vcm68am=[];
vcm71 = []; vcm72 = []; vcm77 = []; vcm78 = []; vcm81 = []; vcm82 = []; vcm87 = []; vcm88 = [];
vcm71am=[]; vcm72am=[]; vcm77am=[]; vcm78am=[]; vcm81am=[]; vcm82am=[]; vcm87am=[]; vcm88am=[];
vcm91 = []; vcm92 = []; vcm97 = []; vcm98 = []; vcm101 = []; vcm102 = []; vcm107 = []; vcm108 = [];
vcm91am=[]; vcm92am=[]; vcm97am=[]; vcm98am=[]; vcm101am=[]; vcm102am=[]; vcm107am=[]; vcm108am=[];
vcmu112 = []; vcm111 = []; vcm112 = []; vcm117 = []; vcm118 = []; vcm121 = []; vcm122 = []; vcm127 = [];

vcmu112am=[]; vcm111am=[]; vcm112am=[]; vcm117am=[]; vcm118am=[]; vcm121am=[]; vcm122am=[]; vcm127am=[];

if isempty(days2)
   if length(days) == [1]
      month  = mon2num(monthStr);
      NumDays = length(days);
      StartDayStr = [monthStr, ' ', num2str(days(1)),', ', num2str(year1)];
      EndDayStr =   [''];
      titleStr = [StartDayStr];
   else
      month  = mon2num(monthStr);
      NumDays = length(days);
      StartDayStr = [monthStr, ' ', num2str(days(1)),', ', num2str(year1)];
      EndDayStr =   [monthStr, ' ', num2str(days(length(days))),', ', num2str(year1)];
      titleStr = [StartDayStr,' to ', EndDayStr,' (', num2str(NumDays),' days)'];
   end
else
   month  = mon2num(monthStr);
   month2 = mon2num(month2Str);
   NumDays = length(days) + length(days2);
   StartDayStr = [monthStr, ' ', num2str(days(1)),', ', num2str(year1)];
   EndDayStr =   [month2Str, ' ', num2str(days2(length(days2))),', ', num2str(year2)];
   
   titleStr = [StartDayStr,' to ', EndDayStr,' (', num2str(NumDays),' days)'];
end


StartDay = days(1);
EndDay = days(length(days));
N=0;

for day = days
   day;
   %t0=clock;
   year1str = num2str(year1);
   if year1 < 2000
      year1str = year1str(3:4);
      FileName = sprintf('%2s%02d%02d', year1str, month, day);
   else
      FileName = sprintf('%4s%02d%02d', year1str, month, day);
   end
   FileName = sprintf('%2s%02d%02d', year1str, month, day);
   arread(FileName);
   %readtime = etime(clock, t0)
   
   [y1, i] = arselect('SR01C___HCM2___AC0');
   hcm12 = [hcm12 y1];
   [y1, i] = arselect('SR01C___HCM2___AM');
   hcm12am = [hcm12am y1];
   
   [y1, i] = arselect('SR01C___HCM4___AC0');
   hcm18 = [hcm18 y1];
   [y1, i] = arselect('SR01C___HCM4___AM');
   hcm18am = [hcm18am y1];
   
   [y1, i] = arselect('SR02C___HCM1___AC0');
   hcm21 = [hcm21 y1];
   [y1, i] = arselect('SR02C___HCM1___AM');
   hcm21am = [hcm21am y1];
   
   [y1, i] = arselect('SR02C___HCM4___AC0');
   hcm28 = [hcm28 y1];
   [y1, i] = arselect('SR02C___HCM4___AM');
   hcm28am = [hcm28am y1];
      
   [y1, i] = arselect('SR03C___HCM1___AC0');
   hcm31 = [hcm31 y1];
   [y1, i] = arselect('SR03C___HCM1___AM');
   hcm31am = [hcm31am y1];
   
   [y1, i] = arselect('SR03C___HCM3___AC0');
   hcm37 = [hcm37 y1];
   [y1, i] = arselect('SR03C___HCM3___AM');
   hcm37am = [hcm37am y1];
   
   [y1, i] = arselect('SR03C___HCM4___AC0');
   hcm38 = [hcm38 y1];
   [y1, i] = arselect('SR03C___HCM4___AM');
   hcm38am = [hcm38am y1];
   
   [y1, i] = arselect('SR04U___HCM2___AM');
   hcmu42 = [hcmu42 y1];
   [y1, i] = arselect('SR04U___HCM2___AM');
   hcmu42am = [hcmu42am y1];
   
   [y1, i] = arselect('SR04C___HCM1___AC0');
   hcm41 = [hcm41 y1];   
   [y1, i] = arselect('SR04C___HCM1___AM');
   hcm41am = [hcm41am y1];   
   
   [y1, i] = arselect('SR04C___HCM2___AC0');
   hcm42 = [hcm42 y1];   
   [y1, i] = arselect('SR04C___HCM2___AM');
   hcm42am = [hcm42am y1];   
   
   [y1, i] = arselect('SR04C___HCM4___AC0');
   hcm48 = [hcm48 y1];
   [y1, i] = arselect('SR04C___HCM4___AM');
   hcm48am = [hcm48am y1];
   
   [y1, i] = arselect('SR05C___HCM1___AC0');
   hcm51 = [hcm51 y1];
   [y1, i] = arselect('SR05C___HCM1___AM');
   hcm51am = [hcm51am y1];
   
   [y1, i] = arselect('SR05C___HCM4___AC0');
   hcm58 = [hcm58 y1];
   [y1, i] = arselect('SR05C___HCM4___AM');
   hcm58am = [hcm58am y1];
   
   [y1, i] = arselect('SR06C___HCM1___AC0');
   hcm61 = [hcm61 y1];
   [y1, i] = arselect('SR06C___HCM1___AM');
   hcm61am = [hcm61am y1];
   
   [y1, i] = arselect('SR06C___HCM4___AC0');
   hcm68 = [hcm68 y1];
   [y1, i] = arselect('SR06C___HCM4___AM');
   hcm68am = [hcm68am y1];
   
   [y1, i] = arselect('SR07C___HCM1___AC0');
   hcm71 = [hcm71 y1];
   [y1, i] = arselect('SR07C___HCM1___AM');
   hcm71am = [hcm71am y1];
   
   [y1, i] = arselect('SR07C___HCM4___AC0');
   hcm78 = [hcm78 y1];
   [y1, i] = arselect('SR07C___HCM4___AM');
   hcm78am = [hcm78am y1];
   
   [y1, i] = arselect('SR08C___HCM1___AC0');
   hcm81 = [hcm81 y1];
   [y1, i] = arselect('SR08C___HCM1___AM');
   hcm81am = [hcm81am y1];
   
   [y1, i] = arselect('SR08C___HCM4___AC0');
   hcm88 = [hcm88 y1];
   [y1, i] = arselect('SR08C___HCM4___AM');
   hcm88am = [hcm88am y1];
   
   [y1, i] = arselect('SR09C___HCM1___AC0');
   hcm91 = [hcm91 y1];
   [y1, i] = arselect('SR09C___HCM1___AM');
   hcm91am = [hcm91am y1];
   
   [y1, i] = arselect('SR09C___HCM4___AC0');
   hcm98 = [hcm98 y1];
   [y1, i] = arselect('SR09C___HCM4___AM');
   hcm98am = [hcm98am y1];
   
   [y1, i] = arselect('SR10C___HCM1___AC0');
   hcm101 = [hcm101 y1];
   [y1, i] = arselect('SR10C___HCM1___AM');
   hcm101am = [hcm101am y1];
   
   [y1, i] = arselect('SR10C___HCM4___AC0');
   hcm108 = [hcm108 y1];
   [y1, i] = arselect('SR10C___HCM4___AM');
   hcm108am = [hcm108am y1];
   
   [y1, i] = arselect('SR11U___HCM2___AM');
   hcmu112 = [hcmu112 y1];
   [y1, i] = arselect('SR11U___HCM2___AM');
   hcmu112am = [hcmu112am y1];
   
   [y1, i] = arselect('SR11C___HCM1___AC0');
   hcm111 = [hcm111 y1];
   [y1, i] = arselect('SR11C___HCM1___AM');
   hcm111am = [hcm111am y1];
   
   [y1, i] = arselect('SR11C___HCM4___AC0');
   hcm118 = [hcm118 y1];
   [y1, i] = arselect('SR11C___HCM4___AM');
   hcm118am = [hcm118am y1];
   
   [y1, i] = arselect('SR12C___HCM1___AC0');
   hcm121 = [hcm121 y1];
   [y1, i] = arselect('SR12C___HCM1___AM');
   hcm121am = [hcm121am y1];
   
   [y1, i] = arselect('SR12C___HCM3___AC0');
   hcm127 = [hcm127 y1];
   [y1, i] = arselect('SR12C___HCM3___AM');
   hcm127am = [hcm127am y1];
   
   [y1, i] = arselect('SR01C___VCM2___AC0');
   vcm12 = [vcm12 y1];
   [y1, i] = arselect('SR01C___VCM2___AM');
   vcm12am = [vcm12am y1];
   
   [y1, i] = arselect('SR01C___VCM3___AC0');
   vcm17 = [vcm17 y1];
   [y1, i] = arselect('SR01C___VCM3___AM');
   vcm17am = [vcm17am y1];
   
   [y1, i] = arselect('SR01C___VCM4___AC0');
   vcm18 = [vcm18 y1];
   [y1, i] = arselect('SR01C___VCM4___AM');
   vcm18am = [vcm18am y1];
   
   [y1, i] = arselect('SR02C___VCM1___AC0');
   vcm21 = [vcm21 y1];
   [y1, i] = arselect('SR02C___VCM1___AM');
   vcm21am = [vcm21am y1];
   
   [y1, i] = arselect('SR02C___VCM2___AC0');
   vcm22 = [vcm22 y1];
   [y1, i] = arselect('SR02C___VCM2___AM');
   vcm22am = [vcm22am y1];
      
   [y1, i] = arselect('SR02C___VCM3___AC0');
   vcm27 = [vcm27 y1];
   [y1, i] = arselect('SR02C___VCM3___AM');
   vcm27am = [vcm27am y1];
   
   [y1, i] = arselect('SR02C___VCM4___AC0');
   vcm28 = [vcm28 y1];
   [y1, i] = arselect('SR02C___VCM4___AM');
   vcm28am = [vcm28am y1];
      
   [y1, i] = arselect('SR03C___VCM1___AC0');
   vcm31 = [vcm31 y1];
   [y1, i] = arselect('SR03C___VCM1___AM');
   vcm31am = [vcm31am y1];
   
   [y1, i] = arselect('SR03C___VCM2___AC0');
   vcm32 = [vcm32 y1];
   [y1, i] = arselect('SR03C___VCM2___AM');
   vcm32am = [vcm32am y1];
      
   [y1, i] = arselect('SR03C___VCM3___AC0');
   vcm37 = [vcm37 y1];
   [y1, i] = arselect('SR03C___VCM3___AM');
   vcm37am = [vcm37am y1];
   
   [y1, i] = arselect('SR03C___VCM4___AC0');
   vcm38 = [vcm38 y1];
   [y1, i] = arselect('SR03C___VCM4___AM');
   vcm38am = [vcm38am y1];
   
   [y1, i] = arselect('SR04U___VCM2___AM');
   vcmu42 = [vcmu42 y1];
   [y1, i] = arselect('SR04U___VCM2___AM');
   vcmu42am = [vcmu42am y1];
   
   [y1, i] = arselect('SR04C___VCM1___AC0');
   vcm41 = [vcm41 y1];
   [y1, i] = arselect('SR04C___VCM1___AM');
   vcm41am = [vcm41am y1];
   
   [y1, i] = arselect('SR04C___VCM2___AC0');
   vcm42 = [vcm42 y1];
   [y1, i] = arselect('SR04C___VCM2___AM');
   vcm42am = [vcm42am y1];
   
   [y1, i] = arselect('SR04C___VCM3___AC0');
   vcm47 = [vcm47 y1];
   [y1, i] = arselect('SR04C___VCM3___AM');
   vcm47am = [vcm47am y1];
   
   [y1, i] = arselect('SR04C___VCM4___AC0');
   vcm48 = [vcm48 y1];
   [y1, i] = arselect('SR04C___VCM4___AM');
   vcm48am = [vcm48am y1];
   
   [y1, i] = arselect('SR05C___VCM1___AC0');
   vcm51 = [vcm51 y1];
   [y1, i] = arselect('SR05C___VCM1___AM');
   vcm51am = [vcm51am y1];
   
   [y1, i] = arselect('SR05C___VCM2___AC0');
   vcm52 = [vcm52 y1];
   [y1, i] = arselect('SR05C___VCM2___AM');
   vcm52am = [vcm52am y1];
   
   [y1, i] = arselect('SR05C___VCM3___AC0');
   vcm57 = [vcm57 y1];
   [y1, i] = arselect('SR05C___VCM3___AM');
   vcm57am = [vcm57am y1];
   
   [y1, i] = arselect('SR05C___VCM4___AC0');
   vcm58 = [vcm58 y1];
   [y1, i] = arselect('SR05C___VCM4___AM');
   vcm58am = [vcm58am y1];
   
   [y1, i] = arselect('SR06C___VCM1___AC0');
   vcm61 = [vcm61 y1];
   [y1, i] = arselect('SR06C___VCM1___AM');
   vcm61am = [vcm61am y1];
   
   [y1, i] = arselect('SR06C___VCM2___AC0');
   vcm62 = [vcm62 y1];
   [y1, i] = arselect('SR06C___VCM2___AM');
   vcm62am = [vcm62am y1];
   
   [y1, i] = arselect('SR06C___VCM3___AC0');
   vcm67 = [vcm67 y1];
   [y1, i] = arselect('SR06C___VCM3___AM');
   vcm67am = [vcm67am y1];
   
   [y1, i] = arselect('SR06C___VCM4___AC0');
   vcm68 = [vcm68 y1];
   [y1, i] = arselect('SR06C___VCM4___AM');
   vcm68am = [vcm68am y1];
   
   [y1, i] = arselect('SR07C___VCM1___AC0');
   vcm71 = [vcm71 y1];
   [y1, i] = arselect('SR07C___VCM1___AM');
   vcm71am = [vcm71am y1];
   
   [y1, i] = arselect('SR07C___VCM2___AC0');
   vcm72 = [vcm72 y1];
   [y1, i] = arselect('SR07C___VCM2___AM');
   vcm72am = [vcm72am y1];
   
   [y1, i] = arselect('SR07C___VCM3___AC0');
   vcm77 = [vcm77 y1];
   [y1, i] = arselect('SR07C___VCM3___AM');
   vcm77am = [vcm77am y1];
   
   [y1, i] = arselect('SR07C___VCM4___AC0');
   vcm78 = [vcm78 y1];
   [y1, i] = arselect('SR07C___VCM4___AM');
   vcm78am = [vcm78am y1];
   
   [y1, i] = arselect('SR08C___VCM1___AC0');
   vcm81 = [vcm81 y1];
   [y1, i] = arselect('SR08C___VCM1___AM');
   vcm81am = [vcm81am y1];
   
   [y1, i] = arselect('SR08C___VCM2___AC0');
   vcm82 = [vcm82 y1];
   [y1, i] = arselect('SR08C___VCM2___AM');
   vcm82am = [vcm82am y1];
   
   [y1, i] = arselect('SR08C___VCM3___AC0');
   vcm87 = [vcm87 y1];
   [y1, i] = arselect('SR08C___VCM3___AM');
   vcm87am = [vcm87am y1];
   
   [y1, i] = arselect('SR08C___VCM4___AC0');
   vcm88 = [vcm88 y1];
   [y1, i] = arselect('SR08C___VCM4___AM');
   vcm88am = [vcm88am y1];
   
   [y1, i] = arselect('SR09C___VCM1___AC0');
   vcm91 = [vcm91 y1];
   [y1, i] = arselect('SR09C___VCM1___AM');
   vcm91am = [vcm91am y1];
   
   [y1, i] = arselect('SR09C___VCM2___AC0');
   vcm92 = [vcm92 y1];
   [y1, i] = arselect('SR09C___VCM2___AM');
   vcm92am = [vcm92am y1];
   
   [y1, i] = arselect('SR09C___VCM3___AC0');
   vcm97 = [vcm97 y1];
   [y1, i] = arselect('SR09C___VCM3___AM');
   vcm97am = [vcm97am y1];
   
   [y1, i] = arselect('SR09C___VCM4___AC0');
   vcm98 = [vcm98 y1];
   [y1, i] = arselect('SR09C___VCM4___AM');
   vcm98am = [vcm98am y1];
   
   [y1, i] = arselect('SR10C___VCM1___AC0');
   vcm101 = [vcm101 y1];
   [y1, i] = arselect('SR10C___VCM1___AM');
   vcm101am = [vcm101am y1];
   
   [y1, i] = arselect('SR10C___VCM2___AC0');
   vcm102 = [vcm102 y1];
   [y1, i] = arselect('SR10C___VCM2___AM');
   vcm102am = [vcm102am y1];
   
   [y1, i] = arselect('SR10C___VCM3___AC0');
   vcm107 = [vcm107 y1];
   [y1, i] = arselect('SR10C___VCM3___AM');
   vcm107am = [vcm107am y1];
   
   [y1, i] = arselect('SR10C___VCM4___AC0');
   vcm108 = [vcm108 y1];
   [y1, i] = arselect('SR10C___VCM4___AM');
   vcm108am = [vcm108am y1];
      
   [y1, i] = arselect('SR11U___VCM2___AM');
   vcmu112 = [vcmu112 y1];
   [y1, i] = arselect('SR11U___VCM2___AM');
   vcmu112am = [vcmu112am y1];
   
   [y1, i] = arselect('SR11C___VCM1___AC0');
   vcm111 = [vcm111 y1];
   [y1, i] = arselect('SR11C___VCM1___AM');
   vcm111am = [vcm111am y1];
   
   [y1, i] = arselect('SR11C___VCM2___AC0');
   vcm112 = [vcm112 y1];
   [y1, i] = arselect('SR11C___VCM2___AM');
   vcm112am = [vcm112am y1];
   
   [y1, i] = arselect('SR11C___VCM3___AC0');
   vcm117 = [vcm117 y1];
   [y1, i] = arselect('SR11C___VCM3___AM');
   vcm117am = [vcm117am y1];
   
   [y1, i] = arselect('SR11C___VCM4___AC0');
   vcm118 = [vcm118 y1];
   [y1, i] = arselect('SR11C___VCM4___AM');
   vcm118am = [vcm118am y1];
   
   [y1, i] = arselect('SR12C___VCM1___AC0');
   vcm121 = [vcm121 y1];
   [y1, i] = arselect('SR12C___VCM1___AM');
   vcm121am = [vcm121am y1];
   
   [y1, i] = arselect('SR12C___VCM2___AC0');
   vcm122 = [vcm122 y1];
   [y1, i] = arselect('SR12C___VCM2___AM');
   vcm122am = [vcm122am y1];
   
   [y1, i] = arselect('SR12C___VCM3___AC0');
   vcm127 = [vcm127 y1];
   [y1, i] = arselect('SR12C___VCM3___AM');
   vcm127am = [vcm127am y1];
   
   
   t    = [t  ARt+(day-StartDay)*24*60*60];
   
   disp(' ');
end


if ~isempty(days2)
   
	StartDay = days2(1);
	EndDay = days2(length(days2));
   
   for day = days2
      
      year2str = num2str(year2);
      
	   if year2 < 2000
   		   year2str = year2str(3:4);
   		   FileName = sprintf('%2s%02d%02d', year2str, month2, day);
	   else
   		   FileName = sprintf('%4s%02d%02d', year2str, month2, day);
         end
         
         FileName = sprintf('%2s%02d%02d', year2str, month2, day);
                  
	   arread(FileName);
	   %readtime = etime(clock, t0)
   
   [y1, i] = arselect('SR01C___HCM2___AC0');
   hcm12 = [hcm12 y1];
   [y1, i] = arselect('SR01C___HCM2___AM');
   hcm12am = [hcm12am y1];
   
   [y1, i] = arselect('SR01C___HCM4___AC0');
   hcm18 = [hcm18 y1];
   [y1, i] = arselect('SR01C___HCM4___AM');
   hcm18am = [hcm18am y1];
   
   [y1, i] = arselect('SR02C___HCM1___AC0');
   hcm21 = [hcm21 y1];
   [y1, i] = arselect('SR02C___HCM1___AM');
   hcm21am = [hcm21am y1];
   
   [y1, i] = arselect('SR02C___HCM4___AC0');
   hcm28 = [hcm28 y1];
   [y1, i] = arselect('SR02C___HCM4___AM');
   hcm28am = [hcm28am y1];
      
   [y1, i] = arselect('SR03C___HCM1___AC0');
   hcm31 = [hcm31 y1];
   [y1, i] = arselect('SR03C___HCM1___AM');
   hcm31am = [hcm31am y1];
   
   [y1, i] = arselect('SR03C___HCM3___AC0');
   hcm37 = [hcm37 y1];
   [y1, i] = arselect('SR03C___HCM3___AM');
   hcm37am = [hcm37am y1];
   
   [y1, i] = arselect('SR03C___HCM4___AC0');
   hcm38 = [hcm38 y1];
   [y1, i] = arselect('SR03C___HCM4___AM');
   hcm38am = [hcm38am y1];
   
   [y1, i] = arselect('SR04U___HCM2___AM');
   hcmu42 = [hcmu42 y1];
   [y1, i] = arselect('SR04U___HCM2___AM');
   hcmu42am = [hcmu42am y1];
   
   [y1, i] = arselect('SR04C___HCM1___AC0');
   hcm41 = [hcm41 y1];   
   [y1, i] = arselect('SR04C___HCM1___AM');
   hcm41am = [hcm41am y1];   
   
   [y1, i] = arselect('SR04C___HCM2___AC0');
   hcm42 = [hcm42 y1];   
   [y1, i] = arselect('SR04C___HCM2___AM');
   hcm42am = [hcm42am y1];   
   
   [y1, i] = arselect('SR04C___HCM4___AC0');
   hcm48 = [hcm48 y1];
   [y1, i] = arselect('SR04C___HCM4___AM');
   hcm48am = [hcm48am y1];
   
   [y1, i] = arselect('SR05C___HCM1___AC0');
   hcm51 = [hcm51 y1];
   [y1, i] = arselect('SR05C___HCM1___AM');
   hcm51am = [hcm51am y1];
   
   [y1, i] = arselect('SR05C___HCM4___AC0');
   hcm58 = [hcm58 y1];
   [y1, i] = arselect('SR05C___HCM4___AM');
   hcm58am = [hcm58am y1];
   
   [y1, i] = arselect('SR06C___HCM1___AC0');
   hcm61 = [hcm61 y1];
   [y1, i] = arselect('SR06C___HCM1___AM');
   hcm61am = [hcm61am y1];
   
   [y1, i] = arselect('SR06C___HCM4___AC0');
   hcm68 = [hcm68 y1];
   [y1, i] = arselect('SR06C___HCM4___AM');
   hcm68am = [hcm68am y1];
   
   [y1, i] = arselect('SR07C___HCM1___AC0');
   hcm71 = [hcm71 y1];
   [y1, i] = arselect('SR07C___HCM1___AM');
   hcm71am = [hcm71am y1];
   
   [y1, i] = arselect('SR07C___HCM4___AC0');
   hcm78 = [hcm78 y1];
   [y1, i] = arselect('SR07C___HCM4___AM');
   hcm78am = [hcm78am y1];
   
   [y1, i] = arselect('SR08C___HCM1___AC0');
   hcm81 = [hcm81 y1];
   [y1, i] = arselect('SR08C___HCM1___AM');
   hcm81am = [hcm81am y1];
   
   [y1, i] = arselect('SR08C___HCM4___AC0');
   hcm88 = [hcm88 y1];
   [y1, i] = arselect('SR08C___HCM4___AM');
   hcm88am = [hcm88am y1];
   
   [y1, i] = arselect('SR09C___HCM1___AC0');
   hcm91 = [hcm91 y1];
   [y1, i] = arselect('SR09C___HCM1___AM');
   hcm91am = [hcm91am y1];
   
   [y1, i] = arselect('SR09C___HCM4___AC0');
   hcm98 = [hcm98 y1];
   [y1, i] = arselect('SR09C___HCM4___AM');
   hcm98am = [hcm98am y1];
   
   [y1, i] = arselect('SR10C___HCM1___AC0');
   hcm101 = [hcm101 y1];
   [y1, i] = arselect('SR10C___HCM1___AM');
   hcm101am = [hcm101am y1];
   
   [y1, i] = arselect('SR10C___HCM4___AC0');
   hcm108 = [hcm108 y1];
   [y1, i] = arselect('SR10C___HCM4___AM');
   hcm108am = [hcm108am y1];
   
   [y1, i] = arselect('SR11U___HCM2___AM');
   hcmu112 = [hcmu112 y1];
   [y1, i] = arselect('SR11U___HCM2___AM');
   hcmu112am = [hcmu112am y1];
   
   [y1, i] = arselect('SR11C___HCM1___AC0');
   hcm111 = [hcm111 y1];
   [y1, i] = arselect('SR11C___HCM1___AM');
   hcm111am = [hcm111am y1];
   
   [y1, i] = arselect('SR11C___HCM4___AC0');
   hcm118 = [hcm118 y1];
   [y1, i] = arselect('SR11C___HCM4___AM');
   hcm118am = [hcm118am y1];
   
   [y1, i] = arselect('SR12C___HCM1___AC0');
   hcm121 = [hcm121 y1];
   [y1, i] = arselect('SR12C___HCM1___AM');
   hcm121am = [hcm121am y1];
   
   [y1, i] = arselect('SR12C___HCM3___AC0');
   hcm127 = [hcm127 y1];
   [y1, i] = arselect('SR12C___HCM3___AM');
   hcm127am = [hcm127am y1];
   
   [y1, i] = arselect('SR01C___VCM2___AC0');
   vcm12 = [vcm12 y1];
   [y1, i] = arselect('SR01C___VCM2___AM');
   vcm12am = [vcm12am y1];
   
   [y1, i] = arselect('SR01C___VCM3___AC0');
   vcm17 = [vcm17 y1];
   [y1, i] = arselect('SR01C___VCM3___AM');
   vcm17am = [vcm17am y1];
   
   [y1, i] = arselect('SR01C___VCM4___AC0');
   vcm18 = [vcm18 y1];
   [y1, i] = arselect('SR01C___VCM4___AM');
   vcm18am = [vcm18am y1];
   
   [y1, i] = arselect('SR02C___VCM1___AC0');
   vcm21 = [vcm21 y1];
   [y1, i] = arselect('SR02C___VCM1___AM');
   vcm21am = [vcm21am y1];
   
   [y1, i] = arselect('SR02C___VCM2___AC0');
   vcm22 = [vcm22 y1];
   [y1, i] = arselect('SR02C___VCM2___AM');
   vcm22am = [vcm22am y1];
      
   [y1, i] = arselect('SR02C___VCM3___AC0');
   vcm27 = [vcm27 y1];
   [y1, i] = arselect('SR02C___VCM3___AM');
   vcm27am = [vcm27am y1];
   
   [y1, i] = arselect('SR02C___VCM4___AC0');
   vcm28 = [vcm28 y1];
   [y1, i] = arselect('SR02C___VCM4___AM');
   vcm28am = [vcm28am y1];
      
   [y1, i] = arselect('SR03C___VCM1___AC0');
   vcm31 = [vcm31 y1];
   [y1, i] = arselect('SR03C___VCM1___AM');
   vcm31am = [vcm31am y1];
   
   [y1, i] = arselect('SR03C___VCM2___AC0');
   vcm32 = [vcm32 y1];
   [y1, i] = arselect('SR03C___VCM2___AM');
   vcm32am = [vcm32am y1];
      
   [y1, i] = arselect('SR03C___VCM3___AC0');
   vcm37 = [vcm37 y1];
   [y1, i] = arselect('SR03C___VCM3___AM');
   vcm37am = [vcm37am y1];
   
   [y1, i] = arselect('SR03C___VCM4___AC0');
   vcm38 = [vcm38 y1];
   [y1, i] = arselect('SR03C___VCM4___AM');
   vcm38am = [vcm38am y1];
   
   [y1, i] = arselect('SR04U___VCM2___AM');
   vcmu42 = [vcmu42 y1];
   [y1, i] = arselect('SR04U___VCM2___AM');
   vcmu42am = [vcmu42am y1];
   
   [y1, i] = arselect('SR04C___VCM1___AC0');
   vcm41 = [vcm41 y1];
   [y1, i] = arselect('SR04C___VCM1___AM');
   vcm41am = [vcm41am y1];
   
   [y1, i] = arselect('SR04C___VCM2___AC0');
   vcm42 = [vcm42 y1];
   [y1, i] = arselect('SR04C___VCM2___AM');
   vcm42am = [vcm42am y1];
   
   [y1, i] = arselect('SR04C___VCM3___AC0');
   vcm47 = [vcm47 y1];
   [y1, i] = arselect('SR04C___VCM3___AM');
   vcm47am = [vcm47am y1];
   
   [y1, i] = arselect('SR04C___VCM4___AC0');
   vcm48 = [vcm48 y1];
   [y1, i] = arselect('SR04C___VCM4___AM');
   vcm48am = [vcm48am y1];
   
   [y1, i] = arselect('SR05C___VCM1___AC0');
   vcm51 = [vcm51 y1];
   [y1, i] = arselect('SR05C___VCM1___AM');
   vcm51am = [vcm51am y1];
   
   [y1, i] = arselect('SR05C___VCM2___AC0');
   vcm52 = [vcm52 y1];
   [y1, i] = arselect('SR05C___VCM2___AM');
   vcm52am = [vcm52am y1];
   
   [y1, i] = arselect('SR05C___VCM3___AC0');
   vcm57 = [vcm57 y1];
   [y1, i] = arselect('SR05C___VCM3___AM');
   vcm57am = [vcm57am y1];
   
   [y1, i] = arselect('SR05C___VCM4___AC0');
   vcm58 = [vcm58 y1];
   [y1, i] = arselect('SR05C___VCM4___AM');
   vcm58am = [vcm58am y1];
   
   [y1, i] = arselect('SR06C___VCM1___AC0');
   vcm61 = [vcm61 y1];
   [y1, i] = arselect('SR06C___VCM1___AM');
   vcm61am = [vcm61am y1];
   
   [y1, i] = arselect('SR06C___VCM2___AC0');
   vcm62 = [vcm62 y1];
   [y1, i] = arselect('SR06C___VCM2___AM');
   vcm62am = [vcm62am y1];
   
   [y1, i] = arselect('SR06C___VCM3___AC0');
   vcm67 = [vcm67 y1];
   [y1, i] = arselect('SR06C___VCM3___AM');
   vcm67am = [vcm67am y1];
   
   [y1, i] = arselect('SR06C___VCM4___AC0');
   vcm68 = [vcm68 y1];
   [y1, i] = arselect('SR06C___VCM4___AM');
   vcm68am = [vcm68am y1];
   
   [y1, i] = arselect('SR07C___VCM1___AC0');
   vcm71 = [vcm71 y1];
   [y1, i] = arselect('SR07C___VCM1___AM');
   vcm71am = [vcm71am y1];
   
   [y1, i] = arselect('SR07C___VCM2___AC0');
   vcm72 = [vcm72 y1];
   [y1, i] = arselect('SR07C___VCM2___AM');
   vcm72am = [vcm72am y1];
   
   [y1, i] = arselect('SR07C___VCM3___AC0');
   vcm77 = [vcm77 y1];
   [y1, i] = arselect('SR07C___VCM3___AM');
   vcm77am = [vcm77am y1];
   
   [y1, i] = arselect('SR07C___VCM4___AC0');
   vcm78 = [vcm78 y1];
   [y1, i] = arselect('SR07C___VCM4___AM');
   vcm78am = [vcm78am y1];
   
   [y1, i] = arselect('SR08C___VCM1___AC0');
   vcm81 = [vcm81 y1];
   [y1, i] = arselect('SR08C___VCM1___AM');
   vcm81am = [vcm81am y1];
   
   [y1, i] = arselect('SR08C___VCM2___AC0');
   vcm82 = [vcm82 y1];
   [y1, i] = arselect('SR08C___VCM2___AM');
   vcm82am = [vcm82am y1];
   
   [y1, i] = arselect('SR08C___VCM3___AC0');
   vcm87 = [vcm87 y1];
   [y1, i] = arselect('SR08C___VCM3___AM');
   vcm87am = [vcm87am y1];
   
   [y1, i] = arselect('SR08C___VCM4___AC0');
   vcm88 = [vcm88 y1];
   [y1, i] = arselect('SR08C___VCM4___AM');
   vcm88am = [vcm88am y1];
   
   [y1, i] = arselect('SR09C___VCM1___AC0');
   vcm91 = [vcm91 y1];
   [y1, i] = arselect('SR09C___VCM1___AM');
   vcm91am = [vcm91am y1];
   
   [y1, i] = arselect('SR09C___VCM2___AC0');
   vcm92 = [vcm92 y1];
   [y1, i] = arselect('SR09C___VCM2___AM');
   vcm92am = [vcm92am y1];
   
   [y1, i] = arselect('SR09C___VCM3___AC0');
   vcm97 = [vcm97 y1];
   [y1, i] = arselect('SR09C___VCM3___AM');
   vcm97am = [vcm97am y1];
   
   [y1, i] = arselect('SR09C___VCM4___AC0');
   vcm98 = [vcm98 y1];
   [y1, i] = arselect('SR09C___VCM4___AM');
   vcm98am = [vcm98am y1];
   
   [y1, i] = arselect('SR10C___VCM1___AC0');
   vcm101 = [vcm101 y1];
   [y1, i] = arselect('SR10C___VCM1___AM');
   vcm101am = [vcm101am y1];
   
   [y1, i] = arselect('SR10C___VCM2___AC0');
   vcm102 = [vcm102 y1];
   [y1, i] = arselect('SR10C___VCM2___AM');
   vcm102am = [vcm102am y1];
   
   [y1, i] = arselect('SR10C___VCM3___AC0');
   vcm107 = [vcm107 y1];
   [y1, i] = arselect('SR10C___VCM3___AM');
   vcm107am = [vcm107am y1];
   
   [y1, i] = arselect('SR10C___VCM4___AC0');
   vcm108 = [vcm108 y1];
   [y1, i] = arselect('SR10C___VCM4___AM');
   vcm108am = [vcm108am y1];
      
   [y1, i] = arselect('SR11U___VCM2___AM');
   vcmu112 = [vcmu112 y1];
   [y1, i] = arselect('SR11U___VCM2___AM');
   vcmu112am = [vcmu112am y1];
   
   [y1, i] = arselect('SR11C___VCM1___AC0');
   vcm111 = [vcm111 y1];
   [y1, i] = arselect('SR11C___VCM1___AM');
   vcm111am = [vcm111am y1];
   
   [y1, i] = arselect('SR11C___VCM2___AC0');
   vcm112 = [vcm112 y1];
   [y1, i] = arselect('SR11C___VCM2___AM');
   vcm112am = [vcm112am y1];
   
   [y1, i] = arselect('SR11C___VCM3___AC0');
   vcm117 = [vcm117 y1];
   [y1, i] = arselect('SR11C___VCM3___AM');
   vcm117am = [vcm117am y1];
   
   [y1, i] = arselect('SR11C___VCM4___AC0');
   vcm118 = [vcm118 y1];
   [y1, i] = arselect('SR11C___VCM4___AM');
   vcm118am = [vcm118am y1];
   
   [y1, i] = arselect('SR12C___VCM1___AC0');
   vcm121 = [vcm121 y1];
   [y1, i] = arselect('SR12C___VCM1___AM');
   vcm121am = [vcm121am y1];
   
   [y1, i] = arselect('SR12C___VCM2___AC0');
   vcm122 = [vcm122 y1];
   [y1, i] = arselect('SR12C___VCM2___AM');
   vcm122am = [vcm122am y1];
   
   [y1, i] = arselect('SR12C___VCM3___AC0');
   vcm127 = [vcm127 y1];
   [y1, i] = arselect('SR12C___VCM3___AM');
   vcm127am = [vcm127am y1];
      
	t = [t  ARt+(day-StartDay+(days(length(days))-days(1)+1))*24*60*60];
   
   disp(' ');

   end
end


% Hours or days for the x-axis?
if t(end)/60/60/24 > 3
   t = t/60/60/24;
   xlabelstring = ['Date since ', StartDayStr, ' [Days]'];
   DayFlag = 1;
else
   t = t/60/60;
   xlabelstring = ['Time since ', StartDayStr, ' [Hours]'];
   DayFlag = 0;
end
Days = [days days2];
xmax = max(t);


figure

subplot(4,1,1)
plot(t,hcm12am-hcm12,t,hcm18am-hcm18);
legend('HCM 1.2 AM-SP','HCM 1.8 AM-SP',3);
ylabel('I [A]');
grid;
if tightaxis
   axis tight;
   xaxis([min(t) max(t)]);
else
   axis([min(t) max(t) -1 1]);
end
title(['HCM trim DACs ',titleStr]);
ChangeAxesLabel(t, Days, DayFlag);

subplot(4,1,2)
plot(t,hcm21am-hcm21,t,hcm28am-hcm28);
legend('HCM 2.1 AM-SP','HCM 2.8 AM-SP',3);
ylabel('I [A]');
grid;
if tightaxis
   axis tight;
   xaxis([min(t) max(t)]);
else
   axis([min(t) max(t) -1 1]);
end
ChangeAxesLabel(t, Days, DayFlag);

subplot(4,1,3)
plot(t,hcm31am-hcm31,t,hcm37am-hcm37,t,hcm38am-hcm38);
legend('HCM 3.1 AM-SP','HCM 3.7 AM-SP','HCM 3.8 AM-SP',3);
ylabel('I [A]');
grid;
if tightaxis
   axis tight;
   xaxis([min(t) max(t)]);
else
   axis([min(t) max(t) -1 1]);
end
ChangeAxesLabel(t, Days, DayFlag);

subplot(4,1,4)
plot(t,hcm41am-hcm41,t,hcm42am-hcm42,t,hcm48am-hcm48,t,hcmu42/10);
legend('HCM 4.1 AM-SP','HCM 4.2 AM-SP','HCM 4.8 AM-SP','HCMCHIC 4.2/10',3);
ylabel('I [A]');
grid;
if tightaxis
   axis tight;
   xaxis([min(t) max(t)]);
else
   axis([min(t) max(t) -1 1]);
end
xlabel(xlabelstring);
ChangeAxesLabel(t, Days, DayFlag);

orient tall;


figure

subplot(4,1,1)
plot(t,hcm51am-hcm51,t,hcm58am-hcm58);
legend('HCM 5.1 AM-SP','HCM 5.8 AM-SP',3);
ylabel('I [A]');
grid;
if tightaxis
   axis tight;
   xaxis([min(t) max(t)]);
else
   axis([min(t) max(t) -1 1]);
end
title(['HCM trim DACs ',titleStr]);
ChangeAxesLabel(t, Days, DayFlag);

subplot(4,1,2)
plot(t,hcm61am-hcm61,t,hcm68am-hcm68);
legend('HCM 6.1 AM-SP','HCM 6.8 AM-SP',3);
ylabel('I [A]');
grid;
if tightaxis
   axis tight;
   xaxis([min(t) max(t)]);
else
   axis([min(t) max(t) -1 1]);
end
ChangeAxesLabel(t, Days, DayFlag);

subplot(4,1,3)
plot(t,hcm71am-hcm71,t,hcm78am-hcm78);
legend('HCM 7.1 AM-SP','HCM 7.8 AM-SP',3);
ylabel('I [A]');
grid;
if tightaxis
   axis tight;
   xaxis([min(t) max(t)]);
else
   axis([min(t) max(t) -1 1]);
end
ChangeAxesLabel(t, Days, DayFlag);

subplot(4,1,4)
plot(t,hcm81am-hcm81,t,hcm88am-hcm88);
legend('HCM 8.1 AM-SP','HCM 8.8 AM-SP',3);
ylabel('I [A]');
grid;
if tightaxis
   axis tight;
   xaxis([min(t) max(t)]);
else
   axis([min(t) max(t) -1 1]);
end
xlabel(xlabelstring);
ChangeAxesLabel(t, Days, DayFlag);

orient tall;


figure

subplot(4,1,1)
plot(t,hcm91am-hcm91,t,hcm98-hcm98am);
legend('HCM 9.1 AM-SP','HCM 9.8 AM-SP',3);
ylabel('I [A]');
grid;
if tightaxis
   axis tight;
   xaxis([min(t) max(t)]);
else
   axis([min(t) max(t) -1 1]);
end
title(['HCM trim DACs ',titleStr]);
ChangeAxesLabel(t, Days, DayFlag);

subplot(4,1,2)
plot(t,hcm101am-hcm101,t,hcm108am-hcm108);
legend('HCM 10.1 AM-SP','HCM 10.8 AM-SP',3);
ylabel('I [A]');
grid;
if tightaxis
   axis tight;
   xaxis([min(t) max(t)]);
else
   axis([min(t) max(t) -1 1]);
end
ChangeAxesLabel(t, Days, DayFlag);

subplot(4,1,3)
plot(t,hcm111am-hcm111,t,hcm118am-hcm118,t,hcmu112/10);
legend('HCM 11.1 AM-SP','HCM 11.8 AM-SP','HCMCHIC 11.2/10',3);
ylabel('I [A]');
grid;
if tightaxis
   axis tight;
   xaxis([min(t) max(t)]);
else
   axis([min(t) max(t) -1 1]);
end
ChangeAxesLabel(t, Days, DayFlag);

subplot(4,1,4)
plot(t,hcm121am-hcm121,t,hcm127am-hcm127);
legend('HCM 12.1 AM-SP','HCM 12.7 AM-SP',3);
ylabel('I [A]');
grid;
if tightaxis
   axis tight;
   xaxis([min(t) max(t)]);
else
   axis([min(t) max(t) -1 1]);
end
xlabel(xlabelstring);
ChangeAxesLabel(t, Days, DayFlag);

orient tall;

figure

subplot(4,1,1)
plot(t,vcm12am-vcm12,t,vcm18am-vcm18,t,vcm17am-vcm17);
legend('VCM 1.2 AM-SP','VCM 1.8 AM-SP','VCM 1.7 AM-SP',3);
ylabel('I [A]');
grid;
if tightaxis
   axis tight;
   xaxis([min(t) max(t)]);
else
   axis([min(t) max(t) -2 2]);
end
title(['VCM trim DACs ',titleStr]);
ChangeAxesLabel(t, Days, DayFlag);

subplot(4,1,2)
plot(t,vcm21am-vcm21,t,vcm28am-vcm28,t,vcm22am-vcm22,t,vcm27am-vcm27);
legend('VCM 2.1 AM-SP','VCM 2.8 AM-SP','VCM 2.2 AM-SP','VCM 2.7 AM-SP',3);
ylabel('I [A]');
grid;
if tightaxis
   axis tight;
   xaxis([min(t) max(t)]);
else
   axis([min(t) max(t) -2 2]);
end
ChangeAxesLabel(t, Days, DayFlag);

subplot(4,1,3)
plot(t,vcm31am-vcm31,t,vcm38am-vcm38,t,vcm32am-vcm32,t,vcm37am-vcm37);
legend('VCM 3.1 AM-SP','VCM 3.8 AM-SP','VCM 3.2 AM-SP','VCM 3.7 AM-SP',3);
ylabel('I [A]');
grid;
if tightaxis
   axis tight;
   xaxis([min(t) max(t)]);
else
   axis([min(t) max(t) -2 2]);
end
ChangeAxesLabel(t, Days, DayFlag);

subplot(4,1,4)
plot(t,vcm41am-vcm41,t,vcm48am-vcm48,t,vcmu42/10,t,vcm42am-vcm42,t,vcm47am-vcm47);
legend('VCM 4.1 AM-SP','VCM 4.8 AM-SP','VCMCHIC 4.2/10','VCM 4.2 AM-SP','VCM 4.7 AM-SP',3);
ylabel('I [A]');
grid;
if tightaxis
   axis tight;
   xaxis([min(t) max(t)]);
else
   axis([min(t) max(t) -2 2]);
end
xlabel(xlabelstring);
ChangeAxesLabel(t, Days, DayFlag);

orient tall;

figure

subplot(4,1,1)
plot(t,vcm51am-vcm51,t,vcm58am-vcm58,t,vcm52am-vcm52,t,vcm57am-vcm57);
legend('VCM 5.1 AM-SP','VCM 5.8 AM-SP','VCM 5.2 AM-SP','VCM 5.7 AM-SP',3);
ylabel('I [A]');
grid;
if tightaxis
   axis tight;
   xaxis([min(t) max(t)]);
else
   axis([min(t) max(t) -2 2]);
end
title(['VCM trim DACs ',titleStr]);
ChangeAxesLabel(t, Days, DayFlag);

subplot(4,1,2)
plot(t,vcm61am-vcm61,t,vcm68am-vcm68,t,vcm62am-vcm62,t,vcm67am-vcm67);
legend('VCM 6.1 AM-SP','VCM 6.8 AM-SP','VCM 6.2 AM-SP','VCM 6.7 AM-SP',3);
ylabel('I [A]');
grid;
if tightaxis
   axis tight;
   xaxis([min(t) max(t)]);
else
   axis([min(t) max(t) -2 2]);
end
ChangeAxesLabel(t, Days, DayFlag);

subplot(4,1,3)
plot(t,vcm71am-vcm71,t,vcm78am-vcm78,t,vcm72am-vcm72,t,vcm77am-vcm77);
legend('VCM 7.1 AM-SP','VCM 7.8 AM-SP','VCM 7.2 AM-SP','VCM 7.7 AM-SP',3);
ylabel('I [A]');
grid;
if tightaxis
   axis tight;
   xaxis([min(t) max(t)]);
else
   axis([min(t) max(t) -2 2]);
end
ChangeAxesLabel(t, Days, DayFlag);

subplot(4,1,4)
plot(t,vcm81am-vcm81,t,vcm88am-vcm88,t,vcm82am-vcm82,t,vcm87am-vcm87);
legend('VCM 8.1 AM-SP','VCM 8.8 AM-SP','VCM 8.2 AM-SP','VCM 8.7 AM-SP',3);
ylabel('I [A]');
grid;
if tightaxis
   axis tight;
   xaxis([min(t) max(t)]);
else
   axis([min(t) max(t) -2 2]);
end
xlabel(xlabelstring);
ChangeAxesLabel(t, Days, DayFlag);

orient tall;


figure

subplot(4,1,1)
plot(t,vcm91am-vcm91,t,vcm98am-vcm98,t,vcm92am-vcm92,t,vcm97am-vcm97);
legend('VCM 9.1 AM-SP','VCM 9.8 AM-SP','VCM 9.2 AM-SP','VCM 9.7 AM-SP',3);
ylabel('I [A]');
grid;
if tightaxis
   axis tight;
   xaxis([min(t) max(t)]);
else
   axis([min(t) max(t) -2 2]);
end
title(['VCM trim DACs ',titleStr]);
ChangeAxesLabel(t, Days, DayFlag);

subplot(4,1,2)
plot(t,vcm101am-vcm101,t,vcm108am-vcm108,t,vcm102am-vcm102,t,vcm107am-vcm107);
legend('VCM 10.1 AM-SP','VCM 10.8 AM-SP','VCM 10.2 AM-SP','VCM 10.7 AM-SP',3);
ylabel('I [A]');
grid;
if tightaxis
   axis tight;
   xaxis([min(t) max(t)]);
else
   axis([min(t) max(t) -2 2]);
end
ChangeAxesLabel(t, Days, DayFlag);

subplot(4,1,3)
plot(t,vcm111am-vcm111,t,vcm118am-vcm118,t,vcmu112/10,t,vcm112am-vcm112,t,vcm117am-vcm117);
legend('VCM 11.1 AM-SP','VCM 11.8 AM-SP','VCMCHIC 11.2/10','VCM 11.2 AM-SP','VCM 11.7 AM-SP',3);
ylabel('I [A]');
grid;
if tightaxis
   axis tight;
   xaxis([min(t) max(t)]);
else
   axis([min(t) max(t) -2 2]);
end
ChangeAxesLabel(t, Days, DayFlag);

subplot(4,1,4)
plot(t,vcm121am-vcm121,t,vcm127am-vcm127,t,vcm122am-vcm122);
legend('VCM 12.1 AM-SP','VCM 12.7 AM-SP','VCM 12.2 AM-SP',3);
ylabel('I [A]');
grid;
if tightaxis
   axis tight;
   xaxis([min(t) max(t)]);
else
   axis([min(t) max(t) -2 2]);
end
xlabel(xlabelstring);
ChangeAxesLabel(t, Days, DayFlag);

orient tall;

if 0
	HCM = [hcm12;hcm18;hcm21;hcm28;hcm31;hcm38;hcm41;hcm48;hcm51;hcm58;hcm61;hcm68; ...
			hcm71;hcm78;hcm81;hcm88;hcm91;hcm98;hcm101;hcm108;hcm111;hcm118;hcm121;hcm127;hcmu42;hcmu112];
	VCM = [vcm12;vcm17;vcm18;vcm21;vcm22;vcm27;vcm28;vcm31;vcm32;vcm37;vcm38; ...
			vcm41;vcm42;vcm47;vcm48;vcm51;vcm52;vcm57;vcm58;vcm61;vcm62;vcm67;vcm68; ...
			vcm71;vcm72;vcm77;vcm78;vcm81;vcm82;vcm87;vcm88;vcm91;vcm92;vcm97;vcm98; ...
			vcm101;vcm102;vcm107;vcm108;vcm111;vcm112;vcm117;vcm118;vcm121;vcm122;vcm127;vcmu42;vcmu112];

	IDBPMx = Sx*HCM;
	IDBPMy = Sy*VCM;
	BBPMx = Sbx*HCM;
	BBPMy = Sby*VCM;

	for loop=1:size(IDBPMx,1)
		figure;
		plot(IDBPMx(loop,:))
		legend(getname('IDBPMx',IDBPMlist(loop,:)))
	end
	for loop=1:size(IDBPMy,1)
		figure;
		plot(IDBPMy(loop,:))
		legend(getname('IDBPMy',IDBPMlist(loop,:)))
	end
	for loop=1:size(BBPMx,1)
		figure;
		plot(BBPMx(loop,:))
		legend(getname('BBPMx',BBPMlist(loop,:)))
	end
	for loop=1:size(BBPMy,1)
		figure;
		plot(BBPMy(loop,:))
		legend(getname('BBPMy',BBPMlist(loop,:)))
	end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ChangeAxesLabel(t, Days, DayFlag)
if DayFlag
   if size(Days,2) > 1
      Days = Days'; % Make a column vector
   end
   
   MaxDay = round(max(t));
   set(gca,'XTick',[0:MaxDay]');
   
   if length(Days) < MaxDay-1
      % Days were skipped 
      set(gca,'XTickLabel',strvcat(num2str([0:MaxDay-1]'+Days(1)),' '));  
   else
      % All days plotted
      set(gca,'XTickLabel',strvcat(num2str(Days),' '));  
   end
   
   XTickLabelString = get(gca,'XTickLabel');
   if MaxDay < 20
      % ok
   elseif MaxDay < 40
      set(gca,'XTick',[0:2:MaxDay]');       
      set(gca,'XTickLabel',XTickLabelString(1:2:MaxDay-1,:));       
   elseif MaxDay < 63
      set(gca,'XTick',[0:3:MaxDay]');       
      set(gca,'XTickLabel',XTickLabelString(1:3:MaxDay-1,:));       
   elseif MaxDay < 80
      set(gca,'XTick',[0:4:MaxDay]');       
      set(gca,'XTickLabel',XTickLabelString(1:4:MaxDay-1,:));       
   end
end
