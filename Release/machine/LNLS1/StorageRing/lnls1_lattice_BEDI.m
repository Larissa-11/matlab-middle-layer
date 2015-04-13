function r = lnls1_lattice_BEDI(energy)
%LNLS1_LATTICE - LNLS1 Lattice Model (automatically created with <build_lattice_model>

% Modelo calibrado pelo LOCO em 2014-07-16
% Sextupolos calibrados pela medida de cromaticidade.

%%% HEADER SECTION %%%

global THERING
if ~exist('energy', 'var')
    energy = 1.37;
end

%%% TEMPLATE SECTION %%%

% MARKER Template %
e1 = marker('MARKER', 'IdentityPass');
MARKER_element = [e1];

% A2QF01 Template %
quad_strength = 2.773723424942506;
e1 = quadrupole('A2QF01', 0.27/2, quad_strength, 'QuadLinearPass');
e2 = quadrupole('A2QF01', 0.27/2, quad_strength, 'QuadLinearPass');
A2QF01_element = [e1 e2];

% A2QF03 Template %
quad_strength = 2.778028887538696;
e1 = quadrupole('A2QF03', 0.27/2, quad_strength, 'QuadLinearPass');
e2 = quadrupole('A2QF03', 0.27/2, quad_strength, 'QuadLinearPass');
A2QF03_element = [e1 e2];

% A2QF05 Template %
quad_strength = 2.773906874926019;
e1 = quadrupole('A2QF05', 0.27/2, quad_strength, 'QuadLinearPass');
e2 = quadrupole('A2QF05', 0.27/2, quad_strength, 'QuadLinearPass');
A2QF05_element = [e1 e2];

% A2QF07 Template %
quad_strength = 2.779482318470177;
e1 = quadrupole('A2QF07', 0.27/2, quad_strength, 'QuadLinearPass');
e2 = quadrupole('A2QF07', 0.27/2, quad_strength, 'QuadLinearPass');
A2QF07_element = [e1 e2];

% A2QF09 Template %
quad_strength = 2.785659540513870;
e1 = quadrupole('A2QF09', 0.27/2, quad_strength, 'QuadLinearPass');
e2 = quadrupole('A2QF09', 0.27/2, quad_strength, 'QuadLinearPass');
A2QF09_element = [e1 e2];

% A2QF11 Template %
quad_strength = 2.776734046100072;
e1 = quadrupole('A2QF11', 0.27/2, quad_strength, 'QuadLinearPass');
e2 = quadrupole('A2QF11', 0.27/2, quad_strength, 'QuadLinearPass');
A2QF11_element = [e1 e2];

% A2QD01 Template %
quad_strength = -2.940334245422351;
e1 = quadrupole('A2QD01', 0.27/2, quad_strength, 'QuadLinearPass');
e2 = quadrupole('A2QD01', 0.27/2, quad_strength, 'QuadLinearPass');
A2QD01_element = [e1 e2];

% A2QD03 Template %
quad_strength = -2.948986906916831;
e1 = quadrupole('A2QD03', 0.27/2, quad_strength, 'QuadLinearPass');
e2 = quadrupole('A2QD03', 0.27/2, quad_strength, 'QuadLinearPass');
A2QD03_element = [e1 e2];

% A2QD05 Template %
quad_strength = -2.947200441993257;
e1 = quadrupole('A2QD05', 0.27/2, quad_strength, 'QuadLinearPass');
e2 = quadrupole('A2QD05', 0.27/2, quad_strength, 'QuadLinearPass');
A2QD05_element = [e1 e2];

% A2QD07 Template %
quad_strength = -2.947811865679129;
e1 = quadrupole('A2QD07', 0.27/2, quad_strength, 'QuadLinearPass');
e2 = quadrupole('A2QD07', 0.27/2, quad_strength, 'QuadLinearPass');
A2QD07_element = [e1 e2];

% A2QD09 Template %
quad_strength = -2.965044862057199;
e1 = quadrupole('A2QD09', 0.27/2, quad_strength, 'QuadLinearPass');
e2 = quadrupole('A2QD09', 0.27/2, quad_strength, 'QuadLinearPass');
A2QD09_element = [e1 e2];

% A2QD11 Template %
quad_strength = -2.939194780176979;
e1 = quadrupole('A2QD11', 0.27/2, quad_strength, 'QuadLinearPass');
e2 = quadrupole('A2QD11', 0.27/2, quad_strength, 'QuadLinearPass');
A2QD11_element = [e1 e2];

% A6QF01 Template %
quad_strength = 1.854818793020486;
e1 = quadrupole('A6QF01', 0.27/2, quad_strength, 'QuadLinearPass');
e2 = corrector  ('VCM', 0.00000, [0 0], 'CorrectorPass');
e3 = quadrupole('A6QF01', 0.27/2, quad_strength, 'QuadLinearPass');
A6QF01_element = [e1 e2 e3];

% A6QF02 Template %
quad_strength = 1.849513674801983;
e1 = quadrupole('A6QF02', 0.27/2, quad_strength, 'QuadLinearPass');
e2 = corrector  ('VCM', 0.00000, [0 0], 'CorrectorPass');
e3 = quadrupole('A6QF02', 0.27/2,quad_strength, 'QuadLinearPass');
A6QF02_element = [e1 e2 e3];

% SKEWQUAD Template %
e1 = quadrupole('SKEWQUAD', 0.1/2, 0, 'QuadLinearPass');
e2 = quadrupole('SKEWQUAD', 0.1/2, 0, 'QuadLinearPass');
SKEWQUAD_element = [e1 e2];

% SKEWCORR Template %
e1 = quadrupole('SKEWCORR', 0.025/2, 0, 'QuadLinearPass');
e2 = quadrupole('SKEWCORR', 0.025/2, 0, 'QuadLinearPass');
SKEWCORR_element = [e1 e2];

% A12DI Template %
e1 = rbend('BEND', 1.432*(4/30),  (2*pi/12)*(4/30), (2*pi/12)/2, 0, 0, 'BndMPoleSymplectic4Pass');
e2 = marker('RAD4G', 'IdentityPass');
e3 = rbend('BEND', 1.432*(11/30), (2*pi/12)*(11/30), 0, 0, 0, 'BndMPoleSymplectic4Pass');
e4 = marker('RAD15G', 'IdentityPass');
e5 = rbend('BEND', 1.432*(15/30), (2*pi/12)*(15/30), 0, (2*pi/12)/2, 0, 'BndMPoleSymplectic4Pass');
A12DI_element = [e1 e2 e3 e4 e5];

% A6SF Template %
% e1 = sextupole('A6SF', 0.1/2, 84.331291009094002, 'StrMPoleSymplectic4Pass');
% e2 = marker('SCENTER', 'IdentityPass');
% e3 = sextupole('A6SF', 0.1/2, 84.331291009094002, 'StrMPoleSymplectic4Pass');
e1 = sextupole('A6SF', 0.1/2, 80.926379613506398, 'StrMPoleSymplectic4Pass');
e2 = marker('SCENTER', 'IdentityPass');
e3 = sextupole('A6SF', 0.1/2, 80.926379613506398, 'StrMPoleSymplectic4Pass');
A6SF_element = [e1 e2 e3];

% A6SD01 Template %
e1 = sextupole('A6SD01', 0.1/2, -56.560903175078344, 'StrMPoleSymplectic4Pass');
e2 = sextupole('A6SD01', 0.1/2, -56.560903175078344, 'StrMPoleSymplectic4Pass');
A6SD01_element = [e1 e2];


% A6SD02 Template %
e1 = sextupole('A6SD02', 0.1/2, -56.560903175078344, 'StrMPoleSymplectic4Pass');
e2 = sextupole('A6SD02', 0.1/2, -56.560903175078344, 'StrMPoleSymplectic4Pass');
A6SD02_element = [e1 e2];

% LCENTER Template %
e1 = marker('LCENTER', 'IdentityPass');
LCENTER_element = [e1];

% RF Template %
e1 = rfcavity('RF', 0, 0.25e+6, 476065680, 148, 'CavityPass');
RF_element = [e1];

% BPM Template %
e1 = marker('BPM', 'IdentityPass');
BPM_element = [e1];

% ACH Template %
e1 = corrector('HCM', 0*0.081, [0 0], 'CorrectorPass');
ACH_element = [e1];

% ACV Template %
e1 = corrector('VCM', 0*0.081, [0 0], 'CorrectorPass');
ACV_element = [e1];

% INJKICKER Template %
e1 = corrector('INJKICKER', 0, [0 0], 'CorrectorPass');
INJKICKER_element = [e1];

% AWG01 Template %
ID_length = 2.7;
e1 = drift('AWG01', ID_length/2, 'DriftPass');
e2 = marker('BEGIN', 'IdentityPass');
e3 = marker('LCENTER', 'IdentityPass');
e4 = drift('AWG01', ID_length/2, 'DriftPass');
AWG01_element = [ e1 e2 e3 e4 ];

% AON11 Template %
ID_length = 2.85;
e1 = drift('AON11', ID_length/2, 'DriftPass');
e2 = marker('LCENTER', 'IdentityPass');
e3 = drift('AON11', ID_length/2, 'DriftPass');
AON11_element = [ e1 e2 e3 ];

% AWG09 Template %
ID_length = 1.02;
e1 = drift('AWG09', ID_length/2, 'DriftPass');
e2 = marker('LCENTER', 'IdentityPass');
e3 = drift('AWG09', ID_length/2, 'DriftPass');
AWG09_element = [ e1 e2 e3 ];

% SCRAPPER Template %
e1 = marker('SCRAPPER', 'IdentityPass');
SCRAPPER_element = [e1];

%%% LATTICE SECTION %%%

% CELL: TR01

TR01_1 = drift('ATR', 0.830460086, 'DriftPass');
AQD01A = A2QD01_element;
TR01_2 = drift('ATR', 0.17553, 'DriftPass');
ACV01A = ACV_element;
TR01_3 = drift('ATR', 0.1615, 'DriftPass');
SK7 = SKEWCORR_element;
TR01_4 = drift('ATR', 0.00797, 'DriftPass');
AQF01A = A2QF01_element;
TR01_5 = drift('ATR', 0.17249, 'DriftPass');
AMP01A = BPM_element;
TR01_6 = drift('ATR', 0.13204, 'DriftPass');
ACH01A = ACH_element;
TR01_7 = drift('ATR', 0.733141291, 'DriftPass');
AWG01 = AWG01_element;
TR01_8 = drift('ATR', 0.735141291, 'DriftPass');
ACH01B = ACH_element;
TR01_9 = drift('ATR', 0.17272, 'DriftPass');
AMP01B = BPM_element;
TR01_10 = drift('ATR', 0.12981, 'DriftPass');
AQF01B = A2QF01_element;
TR01_11 = drift('ATR', 0.19147, 'DriftPass');
ACV01B = ACV_element;
TR01_12 = drift('ATR', 0.17853, 'DriftPass');
AQD01B = A2QD01_element;
TR01_13 = drift('ATR', 0.830460086, 'DriftPass');
TR01 = [TR01_1 AQD01A TR01_2 ACV01A TR01_3 SK7 TR01_4 AQF01A TR01_5 AMP01A TR01_6 ACH01A TR01_7 AWG01 TR01_8 ACH01B TR01_9 AMP01B TR01_10 AQF01B TR01_11 ACV01B TR01_12 AQD01B TR01_13 ];


% CELL: ADI01

ADI01 = A12DI_element;
ADI01 = [ADI01 ];


% CELL: TR02

TR02_1 = drift('ATR', 0.7205, 'DriftPass');
ASD02A = A6SD01_element;
TR02_2 = drift('ATR', 0.1875, 'DriftPass');
AMP02A = BPM_element;
TR02_3 = drift('ATR', 0.1065, 'DriftPass');
AQF02A = A6QF01_element;
TR02_4 = drift('ATR', 0.4245, 'DriftPass');
AKC02 = INJKICKER_element;
TR02_5 = drift('ATR', 0.3495, 'DriftPass');
ASF02 = A6SF_element;
TR02_6 = drift('ATR', 0.2845, 'DriftPass');
ACH02 = ACH_element;
TR02_7 = drift('ATR', 0.4855, 'DriftPass');
AQF02B = A6QF02_element;
TR02_8 = drift('ATR', 0.13, 'DriftPass');
AMP02B = BPM_element;
TR02_9 = drift('ATR', 0.171, 'DriftPass');
ASD02B = A6SD02_element;
TR02_10 = drift('ATR', 0.7135, 'DriftPass');
TR02 = [TR02_1 ASD02A TR02_2 AMP02A TR02_3 AQF02A TR02_4 AKC02 TR02_5 ASF02 TR02_6 ACH02 TR02_7 AQF02B TR02_8 AMP02B TR02_9 ASD02B TR02_10 ];


% CELL: ADI02

ADI02 = A12DI_element;
ADI02 = [ADI02 ];


% CELL: TR03

TR03_1 = drift('ATR', 0.830460086, 'DriftPass');
AQD03A = A2QD03_element;
TR03_2 = drift('ATR', 0.17753, 'DriftPass');
ACV03A = ACV_element;
TR03_3 = drift('ATR', 0.19247, 'DriftPass');
AQF03A = A2QF03_element;
TR03_4 = drift('ATR', 0.16629, 'DriftPass');
AMP03A = BPM_element;
TR03_5 = drift('ATR', 0.14024, 'DriftPass');
ACH03A = ACH_element;
TR03_6 = drift('ATR', 0.477184, 'DriftPass');
AKC03 = INJKICKER_element;
TR03_7 = drift('ATR', 1.603986, 'DriftPass');
TR03_CENTER = LCENTER_element;
TR03_8 = drift('ATR', 1.770772, 'DriftPass');
AMP03B = BPM_element;
TR03_9 = drift('ATR', 0.311398, 'DriftPass');
ACH03B = ACH_element;
TR03_10 = drift('ATR', 0.30553, 'DriftPass');
AQF03B = A2QF03_element;
TR03_11 = drift('ATR', 0.1423, 'DriftPass');
ACV03B = ACV_element;
TR03_12 = drift('ATR', 0.2277, 'DriftPass');
AQD03B = A2QD03_element;
TR03_13 = drift('ATR', 0.517252, 'DriftPass');
AMP03C = BPM_element;
TR03_14 = drift('ATR', 0.313208086, 'DriftPass');
TR03 = [TR03_1 AQD03A TR03_2 ACV03A TR03_3 AQF03A TR03_4 AMP03A TR03_5 ACH03A TR03_6 AKC03 TR03_7 TR03_CENTER TR03_8 AMP03B TR03_9 ACH03B TR03_10 AQF03B TR03_11 ACV03B TR03_12 AQD03B TR03_13 AMP03C TR03_14 ];


% CELL: ADI03

ADI03 = A12DI_element;
ADI03 = [ADI03 ];


% CELL: TR04

TR04_1 = drift('ATR', 0.717, 'DriftPass');
ASD04A = A6SD02_element;
TR04_2 = drift('ATR', 0.1665, 'DriftPass');
AMP04A = BPM_element;
TR04_3 = drift('ATR', 0.131, 'DriftPass');
AQF04A = A6QF02_element;
TR04_4 = drift('ATR', 0.47096, 'DriftPass');
AKC04 = INJKICKER_element;
TR04_5 = drift('ATR', 0.30254, 'DriftPass');
ASF04 = A6SF_element;
TR04_6 = drift('ATR', 0.2045, 'DriftPass');
ACH04 = ACH_element;
TR04_7 = drift('ATR', 0.566, 'DriftPass');
AQF04B = A6QF01_element;
TR04_8 = drift('ATR', 0.13205, 'DriftPass');
AMP04B = BPM_element;
TR04_9 = drift('ATR', 0.16845, 'DriftPass');
ASD04B = A6SD01_element;
TR04_10 = drift('ATR', 0.714, 'DriftPass');
TR04 = [TR04_1 ASD04A TR04_2 AMP04A TR04_3 AQF04A TR04_4 AKC04 TR04_5 ASF04 TR04_6 ACH04 TR04_7 AQF04B TR04_8 AMP04B TR04_9 ASD04B TR04_10 ];


% CELL: ADI04

ADI04 = A12DI_element;
ADI04 = [ADI04 ];


% CELL: TR05

TR05_1 = drift('ATR', 0.830460086, 'DriftPass');
AQD05A = A2QD05_element;
TR05_2 = drift('ATR', 0.16536, 'DriftPass');
ACV05A = ACV_element;
TR05_3 = drift('ATR', 0.20464, 'DriftPass');
AQF05A = A2QF05_element;
TR05_4 = drift('ATR', 0.15742, 'DriftPass');
AMP05A = BPM_element;
TR05_5 = drift('ATR', 0.13794, 'DriftPass');
ACH05A = ACH_element;
TR05_6 = drift('ATR', 0.1435, 'DriftPass');
AQS05A = SKEWQUAD_element;
TR05_7 = drift('ATR', 1.05024, 'DriftPass');
FENDAS = SCRAPPER_element;
TR05_8 = drift('ATR', 0.77361, 'DriftPass');
ACB05 = RF_element;
TR05_9 = drift('ATR', 0.02499, 'DriftPass');
TR05_CENTER = LCENTER_element;
TR05_10 = drift('ATR', 0.92147, 'DriftPass');
ACA05 = RF_element;
TR05_11 = drift('ATR', 0.92737, 'DriftPass');
AQS05B = SKEWQUAD_element;
TR05_12 = drift('ATR', 0.1435, 'DriftPass');
ACH05B = ACH_element;
TR05_13 = drift('ATR', 0.19004, 'DriftPass');
AMP05B = BPM_element;
TR05_14 = drift('ATR', 0.10532, 'DriftPass');
AQF05B = A2QF05_element;
TR05_15 = drift('ATR', 0.17264, 'DriftPass');
ACV05B = ACV_element;
TR05_16 = drift('ATR', 0.19736, 'DriftPass');
AQD05B = A2QD05_element;
TR05_17 = drift('ATR', 0.830460086, 'DriftPass');
TR05 = [TR05_1 AQD05A TR05_2 ACV05A TR05_3 AQF05A TR05_4 AMP05A TR05_5 ACH05A TR05_6 AQS05A TR05_7 FENDAS TR05_8 ACB05 TR05_9 TR05_CENTER TR05_10 ACA05 TR05_11 AQS05B TR05_12 ACH05B TR05_13 AMP05B TR05_14 AQF05B TR05_15 ACV05B TR05_16 AQD05B TR05_17 ];


% CELL: ADI05

ADI05 = A12DI_element;
ADI05 = [ADI05 ];


% CELL: TR06

TR06_1 = drift('ATR', 0.716, 'DriftPass');
ASD06A = A6SD01_element;
TR06_2 = drift('ATR', 0.1665, 'DriftPass');
AMP06A = BPM_element;
TR06_3 = drift('ATR', 0.132, 'DriftPass');
AQF06A = A6QF01_element;
TR06_4 = drift('ATR', 0.7735, 'DriftPass');
ASF06 = A6SF_element;
TR06_5 = drift('ATR', 0.2015, 'DriftPass');
ACH06 = ACH_element;
TR06_6 = drift('ATR', 0.569, 'DriftPass');
AQF06B = A6QF02_element;
TR06_7 = drift('ATR', 0.13726, 'DriftPass');
AMP06B = BPM_element;
TR06_8 = drift('ATR', 0.16424, 'DriftPass');
ASD06B = A6SD02_element;
TR06_9 = drift('ATR', 0.713, 'DriftPass');
TR06 = [TR06_1 ASD06A TR06_2 AMP06A TR06_3 AQF06A TR06_4 ASF06 TR06_5 ACH06 TR06_6 AQF06B TR06_7 AMP06B TR06_8 ASD06B TR06_9 ];


% CELL: ADI06

ADI06 = A12DI_element;
ADI06 = [ADI06 ];


% CELL: TR07

TR07_1 = drift('ATR', 0.830460086, 'DriftPass');
AQD07A = A2QD07_element;
TR07_2 = drift('ATR', 0.1815, 'DriftPass');
ACV07A = ACV_element;
TR07_3 = drift('ATR', 0.1885, 'DriftPass');
AQF07A = A2QF07_element;
TR07_4 = drift('ATR', 0.15759, 'DriftPass');
AMP07A = BPM_element;
TR07_5 = drift('ATR', 0.15191, 'DriftPass');
ACH07A = ACH_element;
TR07_6 = drift('ATR', 2.0782, 'DriftPass');
TR07_CENTER = LCENTER_element;
TR07_7 = drift('ATR', 2.0732, 'DriftPass');
ACH07B = ACH_element;
TR07_8 = drift('ATR', 0.1914, 'DriftPass');
AMP07B = BPM_element;
TR07_9 = drift('ATR', 0.1231, 'DriftPass');
AQF07B = A2QF07_element;
TR07_10 = drift('ATR', 0.1825, 'DriftPass');
ACV07B = ACV_element;
TR07_11 = drift('ATR', 0.1875, 'DriftPass');
AQD07B = A2QD07_element;
TR07_12 = drift('ATR', 0.830460086, 'DriftPass');
TR07 = [TR07_1 AQD07A TR07_2 ACV07A TR07_3 AQF07A TR07_4 AMP07A TR07_5 ACH07A TR07_6 TR07_CENTER TR07_7 ACH07B TR07_8 AMP07B TR07_9 AQF07B TR07_10 ACV07B TR07_11 AQD07B TR07_12 ];


% CELL: ADI07

ADI07 = A12DI_element;
ADI07 = [ADI07 ];


% CELL: TR08

TR08_1 = drift('ATR', 0.7145, 'DriftPass');
ASD08A = A6SD02_element;
TR08_2 = drift('ATR', 0.175, 'DriftPass');
AMP08A = BPM_element;
TR08_3 = drift('ATR', 0.125, 'DriftPass');
AQF08A = A6QF02_element;
TR08_4 = drift('ATR', 0.7686, 'DriftPass');
ASF08 = A6SF_element;
TR08_5 = drift('ATR', 0.1959, 'DriftPass');
ACH08 = ACH_element;
TR08_6 = drift('ATR', 0.5795, 'DriftPass');
AQF08B = A6QF01_element;
TR08_7 = drift('ATR', 0.1254, 'DriftPass');
AMP08B = BPM_element;
TR08_8 = drift('ATR', 0.1766, 'DriftPass');
ASD08B = A6SD01_element;
TR08_9 = drift('ATR', 0.7125, 'DriftPass');
TR08 = [TR08_1 ASD08A TR08_2 AMP08A TR08_3 AQF08A TR08_4 ASF08 TR08_5 ACH08 TR08_6 AQF08B TR08_7 AMP08B TR08_8 ASD08B TR08_9 ];


% CELL: ADI08

ADI08 = A12DI_element;
ADI08 = [ADI08 ];


% CELL: TR09

TR09_1 = drift('ATR', 0.830460086, 'DriftPass');
AQD09A = A2QD09_element;
TR09_2 = drift('ATR', 0.1833, 'DriftPass');
ACV09A = ACV_element;
TR09_3 = drift('ATR', 0.1867, 'DriftPass');
AQF09A = A2QF09_element;
TR09_4 = drift('ATR', 0.1659, 'DriftPass');
AMP09A = BPM_element;
TR09_5 = drift('ATR', 0.1444, 'DriftPass');
ACH09A = ACH_element;
TR09_6 = drift('ATR', 0.115, 'DriftPass');
AQS09 = SKEWCORR_element;
TR09_7 = drift('ATR', 1.42739518, 'DriftPass');
AWG09 = AWG09_element;
TR09_8 = drift('ATR', 1.57039518, 'DriftPass');
ACH09B = ACH_element;
TR09_9 = drift('ATR', 0.1914, 'DriftPass');
AMP09B = BPM_element;
TR09_10 = drift('ATR', 0.1159, 'DriftPass');
AQF09B = A2QF09_element;
TR09_11 = drift('ATR', 0.1827, 'DriftPass');
ACV09B = ACV_element;
TR09_12 = drift('ATR', 0.1873, 'DriftPass');
AQD09B = A2QD09_element;
TR09_13 = drift('ATR', 0.830460086, 'DriftPass');
TR09 = [TR09_1 AQD09A TR09_2 ACV09A TR09_3 AQF09A TR09_4 AMP09A TR09_5 ACH09A TR09_6 AQS09 TR09_7 AWG09 TR09_8 ACH09B TR09_9 AMP09B TR09_10 AQF09B TR09_11 ACV09B TR09_12 AQD09B TR09_13 ];


% CELL: ADI09

ADI09 = A12DI_element;
ADI09 = [ADI09 ];


% CELL: TR10

TR10_1 = drift('ATR', 0.7155, 'DriftPass');
ASD10A = A6SD01_element;
TR10_2 = drift('ATR', 0.1732, 'DriftPass');
AMP10A = BPM_element;
TR10_3 = drift('ATR', 0.1258, 'DriftPass');
AQF10A = A6QF01_element;
TR10_4 = drift('ATR', 0.774, 'DriftPass');
ASF10 = A6SF_element;
TR10_5 = drift('ATR', 0.2295, 'DriftPass');
ACH10 = ACH_element;
TR10_6 = drift('ATR', 0.5405, 'DriftPass');
AQF10B = A6QF02_element;
TR10_7 = drift('ATR', 0.1408, 'DriftPass');
AMP10B = BPM_element;
TR10_8 = drift('ATR', 0.1602, 'DriftPass');
ASD10B = A6SD02_element;
TR10_9 = drift('ATR', 0.7135, 'DriftPass');
TR10 = [TR10_1 ASD10A TR10_2 AMP10A TR10_3 AQF10A TR10_4 ASF10 TR10_5 ACH10 TR10_6 AQF10B TR10_7 AMP10B TR10_8 ASD10B TR10_9 ];


% CELL: ADI10

ADI10 = A12DI_element;
ADI10 = [ADI10 ];


% CELL: TR11

TR11_1 = drift('ATR', 0.830460086, 'DriftPass');
AQD11A = A2QD11_element;
TR11_2 = drift('ATR', 0.183, 'DriftPass');
ACV11A = ACV_element;
TR11_3 = drift('ATR', 0.187, 'DriftPass');
AQF11A = A2QF11_element;
TR11_4 = drift('ATR', 0.1877, 'DriftPass');
AMP11A = MARKER_element;
TR11_5 = drift('ATR', 0.1213, 'DriftPass');
ACH11A = ACH_element;
TR11_6 = drift('ATR', 0.115, 'DriftPass');
SK11A = SKEWCORR_element;
TR11_7 = drift('ATR', 0.27242, 'DriftPass');
AMU11A = BPM_element;
TR11_8 = drift('ATR', 0.241279865, 'DriftPass');
AON11 = AON11_element;
TR11_9 = drift('ATR', 0.240689865, 'DriftPass');
AMU11B = BPM_element;
TR11_10 = drift('ATR', 0.41301, 'DriftPass');
ACH11B = ACH_element;
TR11_11 = drift('ATR', 0.2126, 'DriftPass');
AMP11B = MARKER_element;
TR11_12 = drift('ATR', 0.0964, 'DriftPass');
AQF11B = A2QF11_element;
TR11_13 = drift('ATR', 0.18, 'DriftPass');
ACV11B = ACV_element;
TR11_14 = drift('ATR', 0.19, 'DriftPass');
AQD11B = A2QD11_element;
TR11_15 = drift('ATR', 0.830460086, 'DriftPass');
TR11 = [TR11_1 AQD11A TR11_2 ACV11A TR11_3 AQF11A TR11_4 AMP11A TR11_5 ACH11A TR11_6 SK11A TR11_7 AMU11A TR11_8 AON11 TR11_9 AMU11B TR11_10 ACH11B TR11_11 AMP11B TR11_12 AQF11B TR11_13 ACV11B TR11_14 AQD11B TR11_15 ];

% CELL: ADI11

ADI11 = A12DI_element;
ADI11 = [ADI11 ];


% CELL: TR12

TR12_1 = drift('ATR', 0.718, 'DriftPass');
ASD12A = A6SD02_element;
TR12_2 = drift('ATR', 0.1858, 'DriftPass');
AMP12A = BPM_element;
TR12_3 = drift('ATR', 0.1107, 'DriftPass');
AQF12A = A6QF02_element;
TR12_4 = drift('ATR', 0.523, 'DriftPass');
ACH12 = ACH_element;
TR12_5 = drift('ATR', 0.2485, 'DriftPass');
ASF12 = A6SF_element;
TR12_6 = drift('ATR', 0.7725, 'DriftPass');
AQF12B = A6QF01_element;
TR12_7 = drift('ATR', 0.133055, 'DriftPass');
AMP12B = BPM_element;
TR12_8 = drift('ATR', 0.170445, 'DriftPass');
ASD12B = A6SD01_element;
TR12_9 = drift('ATR', 0.711, 'DriftPass');
TR12 = [TR12_1 ASD12A TR12_2 AMP12A TR12_3 AQF12A TR12_4 ACH12 TR12_5 ASF12 TR12_6 AQF12B TR12_7 AMP12B TR12_8 ASD12B TR12_9 ];


% CELL: ADI12

ADI012 = A12DI_element;
ADI12 = [ADI012 ];


%%% TAIL SECTION %%%

elist = [TR01 ADI01 TR02 ADI02 TR03 ADI03 TR04 ADI04 TR05 ADI05 TR06 ADI06 TR07 ADI07 TR08 ADI08 TR09 ADI09 TR10 ADI10 TR11 ADI11 TR12 ADI12 ];
THERING = buildlat(elist);
mbegin = findcells(THERING, 'FamName', 'BEGIN');
if ~isempty(mbegin), THERING = circshift(THERING, [0 -(mbegin(1)-1)]); end
THERING{end+1} = struct('FamName','END','Length',0,'PassMethod','IdentityPass');
THERING = setcellstruct(THERING, 'Energy', 1:length(THERING), 1e9*energy);
r = THERING;

% Compute total length and RF frequency
L0_tot = findspos(THERING, length(THERING)+1);
fprintf('   Length: %.6f m   (design length 93.1999 m)\n', L0_tot);

% Just in case...
not_ready = true;
while not_ready
    try
        atpass(THERING, [0 0 0 0 0 0]',1,1);
        not_ready = false;
    catch
       if isempty(strfind(lasterr,'Library or function could not be loaded'))
            rethrow(lasterror);
       end
    end
end

