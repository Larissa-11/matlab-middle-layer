function [r, lattice_title] = sirius_bo_lattice(varargin)
%maquina com simetria 50, formada por dipolos e quadrupolos com sextupolos
%integrados. 15/08/2012 - Fernando.
% modelode segmentado dos dipolos. 10/04/2014
% mudan??a de padr??o para baixa energia.

%%% HEADER SECTION %%%

global THERING

energy = 0.15e9; % eV

lattice_version = 'BO.V900';
for i=1:length(varargin)
	energy = varargin{i} * 1e9;
end
mode = 'M';
version = '0';

harmonic_number = 828;
if energy == 0.15e9, rf_voltage = 150e3; else rf_voltage = 950e3; end

lattice_title = [lattice_version '.' mode version];
fprintf(['   Loading lattice ' lattice_title ' - ' num2str(energy/1e9) ' GeV' '\n']);

bend_pass_method = 'BndMPoleSymplectic4Pass';
quad_pass_method = 'StrMPoleSymplectic4Pass';
sext_pass_method = 'StrMPoleSymplectic4Pass';

% a segmented model for the dipole has been created from the
% approved fieldmap. The segmented model has a longer length 
% and the different has to be accomodated.

% loads magnet strengths
set_magnets_strength_booster;

% loads dipole segmented model
[bd, b_length_segmented] = dipole_segmented_model(bend_pass_method);

b_length_hedge     = 1.152; % [m]
b_length_segmented = 1.538; % [m]
half_model_diff     = (b_length_segmented - b_length_hedge)/2.0;

lt       = drift('lt',      2.146000, 'DriftPass');
lt2      = drift('lt2',     2.146000-half_model_diff, 'DriftPass');
l25      = drift('l25',     0.250000, 'DriftPass');
l25_2    = drift('l25_2',   0.250000-half_model_diff, 'DriftPass');
l30_2    = drift('l30_2',   0.300000-half_model_diff, 'DriftPass');
l36      = drift('l36',     0.360000, 'DriftPass');
l60      = drift('l60',     0.600000, 'DriftPass');
l80      = drift('l80',     0.800000, 'DriftPass');
l100     = drift('l100',    1.000000, 'DriftPass');
lm25     = drift('lm25',    1.896000, 'DriftPass');
lm30     = drift('lm30',    1.846000, 'DriftPass');
lm45     = drift('lm45',    1.696000, 'DriftPass');
lm60     = drift('lm60',    1.546000, 'DriftPass');
lm66     = drift('lm66',    1.486000, 'DriftPass');
lm70     = drift('lm70',    1.446000, 'DriftPass');
lm100    = drift('lm100',   1.146000, 'DriftPass');
lm120    = drift('lm120',   0.946000, 'DriftPass');
lm105    = drift('lm105',   1.096000, 'DriftPass');
lkk      = drift('lkk',     0.741000, 'DriftPass');
lm60_kk  = drift('lm60_kk', 0.805000, 'DriftPass');
l20      = drift('l20',     0.200000, 'DriftPass');
sfus     = drift('sfus',  1.746000+0.05, 'DriftPass');
sfds     = drift('sfds',  0.200000-0.05, 'DriftPass');

kick_in  = marker('kick_in', 'IdentityPass');
kick_ex  = marker('kick_ex', 'IdentityPass');
sept_in  = marker('sept_in', 'IdentityPass');
sept_ex  = marker('sept_ex', 'IdentityPass');
mqf      = marker('mqf',     'IdentityPass');

qd       = quadrupole('qd', 0.200000, qd_strength, quad_pass_method);
qf       = quadrupole('qf', 0.100000, qf_strength, quad_pass_method);
sf       = sextupole ('sf', 0.200000, sf_strength, sext_pass_method);
sd       = sextupole ('sd', 0.200000, sd_strength, sext_pass_method);
    
bpm      = marker('bpm', 'IdentityPass');
hcm      = corrector('hcm', 0, [0, 0], 'CorrectorPass');
vcm      = corrector('vcm', 0, [0, 0], 'CorrectorPass');

rfc = rfcavity('cav', 0, rf_voltage, 0, harmonic_number, 'CavityPass'); % RF frequency will be set later.

          
b         = bd;
lfree     = lt;
lfree_2   = lt2;
lqd_2     = [lm45, qd, l25_2];
lsd_2     = [lm45, sd, l25_2];
lsf       = [sfus, sf, sfds];
lch       = [lm25, hcm, l25];
lcv_2     = [lm30, vcm, l30_2];
lsdcv_2   = [lm70, vcm, l25, sd, l25_2];
fodo1     = [qf, lfree, lfree_2, b, lfree_2, bpm, lsf, qf];
fodo2     = [qf, lfree, lqd_2, b, fliplr(lcv_2), bpm, lch, qf];
fodo2sd   = [qf, lfree, lqd_2, b, fliplr(lsdcv_2), bpm, lch, qf];
fodo1sd   = [qf, lfree, lfree_2, b, fliplr(lsd_2), bpm, lsf, qf];
boos      = [fodo1sd, mqf, fodo2, mqf, fodo1, mqf, fodo2, mqf, fodo1, mqf, fodo2sd, mqf, fodo1, mqf, fodo2, mqf, fodo1, mqf, fodo2];
lke       = [l60, kick_ex, lkk, kick_ex, lm60_kk];
lcvse_2   = [l36, sept_ex, lm66, vcm, l30_2];
lmon      = [l100, bpm, lm100];
lsich     = [lm105, sept_in, l80, hcm, l25];
lki       = [l60, kick_in, lm60];
fodo2kese = [qf, lke, lqd_2, b, fliplr(lcvse_2), lmon, qf];
fodo2si   = [qf, lfree, lqd_2, b, fliplr(lcv_2), bpm, lsich, qf];
fodo1ki   = [qf, lki, lfree_2, b, lfree_2, bpm, lsf, qf];
fodo1ch   = [qf, fliplr(lch), lfree_2, b, lfree_2, bpm, lsf, qf];
fodo1rf   = [qf, lfree, rfc, lfree_2, b, lfree_2, bpm, lsf, qf];

%booster   = [boos, boos, boos, boos, boos];
boosinj   = [fodo1sd, mqf, fodo2kese, mqf, fodo1ch, mqf, fodo2si, mqf, fodo1ki, mqf, fodo2sd, mqf, fodo1, mqf, fodo2, mqf, fodo1, mqf, fodo2];
boosrf    = [fodo1sd, mqf, fodo2, mqf, fodo1, mqf, fodo2, mqf, fodo1rf, mqf, fodo2sd, mqf, fodo1, mqf, fodo2, mqf, fodo1, mqf, fodo2];
boocor    = [mqf, boosinj, mqf, boos, mqf, boosrf, mqf, boos, mqf, boos];
elist     = boocor;



%% finalization 

THERING = buildlat(elist);
THERING = setcellstruct(THERING, 'Energy', 1:length(THERING), energy);

% checks if there are negative-drift elements
lens = getcellstruct(THERING, 'Length', 1:length(THERING));
if any(lens < 0)
    error(['AT model with negative drift in ' mfilename ' !\n']);
end

% adjusts RF frequency according to lattice length and synchronous condition
const  = lnls_constants;
L0_tot = findspos(THERING, length(THERING)+1);
rev_freq     = const.c / L0_tot;
rf_idx       = findcells(THERING, 'FamName', 'cav');
rf_frequency = rev_freq * harmonic_number;
THERING{rf_idx}.Frequency = rf_frequency;
fprintf(['   RF frequency set to ' num2str(rf_frequency/1e6) ' MHz.\n']);

% by default cavities and radiation is set to off 
setcavity('off'); 
setradiation('off');

% sets default NumIntSteps values for elements
THERING = set_num_integ_steps(THERING);

% define vacuum chamber for all elements
THERING = set_vacuum_chamber(THERING);

% defines girders
%THERING = set_girders(THERING);

% pre-carrega passmethods de forma a evitar problema com bibliotecas recem-compiladas
lnls_preload_passmethods;

r = THERING;


function the_ring = set_vacuum_chamber(the_ring0)

% y = +/- y_lim * sqrt(1 - (x/x_lim)^n);

the_ring = the_ring0;
bends_vchamber = [0.0117 0.0117 1]; % n = 100: ~rectangular
other_vchamber = [0.018  0.018  1];   % n = 1;   circular/eliptica

bends = findcells(the_ring, 'BendingAngle');
other = setdiff(1:length(the_ring), bends);

for i=1:length(bends)
    the_ring{bends(i)}.VChamber = bends_vchamber;
end

for i=1:length(other)
    the_ring{other(i)}.VChamber = other_vchamber;
end


function the_ring = set_num_integ_steps(the_ring0)

the_ring = the_ring0;

bends = findcells(the_ring, 'BendingAngle');
quads = setdiff(findcells(the_ring, 'K'), bends);
sexts = setdiff(findcells(the_ring, 'PolynomB'), [bends quads]);
kicks = findcells(the_ring, 'XGrid');

dl = 0.03;

bends_len = getcellstruct(the_ring, 'Length', bends);
bends_nis = ceil(bends_len / dl);
bends_nis = max([bends_nis'; 10 * ones(size(bends_nis'))]);
the_ring = setcellstruct(the_ring, 'NumIntSteps', bends, bends_nis);
the_ring = setcellstruct(the_ring, 'NumIntSteps', quads, 10);
the_ring = setcellstruct(the_ring, 'NumIntSteps', sexts, 5);
the_ring = setcellstruct(the_ring, 'NumIntSteps', kicks, 1);


