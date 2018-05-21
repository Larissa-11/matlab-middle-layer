function r = CONFIG01


% carrega sistema MML-AT
sirius;

% desliga cavidades e radia��o (Tracking 4D)
setcavity('off');
setradiation('off');


% define par�metros de otimiza��o de abertura din�mica

r.sext_chrom_fams = {'sd1','sf1'};
r.sext_harmo_fams = {'sa1','sa2','sd3','sd2','sf2'};
r.sext_step_size  = 0.20;   % [1/m^3] step size de varia��o aleatoria dos sextupolos
r.quad_step_size  = 0.05;   % varia��o percentual dos quads para procura de nova sintonia
r.sext_chrom_step = 0.10;
r.tune_max_frac   = [1.0 1.0];

r.dynapt.energy_deviation  = [-0.03 0 0.03]; % desvios de energia para calculo de abertura dinamica
r.dynapt.nr_turns          = 512;              % n�mero de voltas
r.dynapt.radius_resolution = 0.25/1000;        % resolu��o [m] na procura da abertura din�mica nas raias
r.dynapt.points_angle      = repmat(linspace(0, pi, 21),length(r.dynapt.energy_deviation),1);
x = (12/1000)*cos(r.dynapt.points_angle);
y = (7/1000)*sin(r.dynapt.points_angle);
r.dynapt.points_radius     = sqrt(x.^2 + y.^2);
