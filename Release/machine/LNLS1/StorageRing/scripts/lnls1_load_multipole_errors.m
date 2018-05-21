function lnls1_load_multipole_errors(factor)

global THERING;


if ~exist('factor', 'var')
    factor = 1;
end

posx = 0.01; % [m]


quads_multipoles_1p37GeV = 1 * [ ...
    0 0 -2.8e-6 5.1e-5 3.2e-7 -3.8e-5 1.1e-5 2.3e-8 -8.4e-6 -4.9e-8; ...
    0 0 -2.8e-6 5.1e-5 3.2e-7 -3.8e-5 1.1e-5 2.3e-8 -8.4e-6 -4.9e-8; ...
    0 0 -2.8e-6 5.1e-5 3.2e-7 -3.8e-5 1.1e-5 2.3e-8 -8.4e-6 -4.9e-8; ...
    0 0 -2.8e-6 5.1e-5 3.2e-7 -3.8e-5 1.1e-5 2.3e-8 -8.4e-6 -4.9e-8; ...
    0 0 -2.8e-6 5.1e-5 3.2e-7 -3.8e-5 1.1e-5 2.3e-8 -8.4e-6 -4.9e-8; ...
    0 0 -2.8e-6 5.1e-5 3.2e-7 -3.8e-5 1.1e-5 2.3e-8 -8.4e-6 -4.9e-8; ...
    0 0 -2.8e-6 5.1e-5 3.2e-7 -3.8e-5 1.1e-5 2.3e-8 -8.4e-6 -4.9e-8; ...
    0 0 -2.8e-6 5.1e-5 3.2e-7 -3.8e-5 1.1e-5 2.3e-8 -8.4e-6 -4.9e-8; ...
    0 0 -2.8e-6 5.1e-5 3.2e-7 -3.8e-5 1.1e-5 2.3e-8 -8.4e-6 -4.9e-8; ...
    0 0 -2.8e-6 5.1e-5 3.2e-7 -3.8e-5 1.1e-5 2.3e-8 -8.4e-6 -4.9e-8; ...
    0 0 -2.8e-6 5.1e-5 3.2e-7 -3.8e-5 1.1e-5 2.3e-8 -8.4e-6 -4.9e-8; ...
    0 0 -2.8e-6 5.1e-5 3.2e-7 -3.8e-5 1.1e-5 2.3e-8 -8.4e-6 -4.9e-8; ...
    0 0 -2.8e-6 5.1e-5 3.2e-7 -3.8e-5 1.1e-5 2.3e-8 -8.4e-6 -4.9e-8; ...
    0 0 -2.8e-6 5.1e-5 3.2e-7 -3.8e-5 1.1e-5 2.3e-8 -8.4e-6 -4.9e-8; ...
    0 0 -2.8e-6 5.1e-5 3.2e-7 -3.8e-5 1.1e-5 2.3e-8 -8.4e-6 -4.9e-8; ...
    0 0 -2.8e-6 5.1e-5 3.2e-7 -3.8e-5 1.1e-5 2.3e-8 -8.4e-6 -4.9e-8; ...
    0 0 -2.8e-6 5.1e-5 3.2e-7 -3.8e-5 1.1e-5 2.3e-8 -8.4e-6 -4.9e-8; ...
    0 0 -2.8e-6 5.1e-5 3.2e-7 -3.8e-5 1.1e-5 2.3e-8 -8.4e-6 -4.9e-8; ...
    0 0 -2.8e-6 5.1e-5 3.2e-7 -3.8e-5 1.1e-5 2.3e-8 -8.4e-6 -4.9e-8; ...
    0 0 -2.8e-6 5.1e-5 3.2e-7 -3.8e-5 1.1e-5 2.3e-8 -8.4e-6 -4.9e-8; ...
    0 0 -2.8e-6 5.1e-5 3.2e-7 -3.8e-5 1.1e-5 2.3e-8 -8.4e-6 -4.9e-8; ...
    0 0 -2.8e-6 5.1e-5 3.2e-7 -3.8e-5 1.1e-5 2.3e-8 -8.4e-6 -4.9e-8; ...
    0 0 -2.8e-6 5.1e-5 3.2e-7 -3.8e-5 1.1e-5 2.3e-8 -8.4e-6 -4.9e-8; ...
    0 0 -2.8e-6 5.1e-5 3.2e-7 -3.8e-5 1.1e-5 2.3e-8 -8.4e-6 -4.9e-8; ...
    0 0 -2.8e-6 5.1e-5 3.2e-7 -3.8e-5 1.1e-5 2.3e-8 -8.4e-6 -4.9e-8; ...
    0 0 -2.8e-6 5.1e-5 3.2e-7 -3.8e-5 1.1e-5 2.3e-8 -8.4e-6 -4.9e-8; ...
    0 0 -2.8e-6 5.1e-5 3.2e-7 -3.8e-5 1.1e-5 2.3e-8 -8.4e-6 -4.9e-8; ...
    0 0 -2.8e-6 5.1e-5 3.2e-7 -3.8e-5 1.1e-5 2.3e-8 -8.4e-6 -4.9e-8; ...
    0 0 -2.8e-6 5.1e-5 3.2e-7 -3.8e-5 1.1e-5 2.3e-8 -8.4e-6 -4.9e-8; ...
    0 0 -2.8e-6 5.1e-5 3.2e-7 -3.8e-5 1.1e-5 2.3e-8 -8.4e-6 -4.9e-8; ...
    0 0 -2.8e-6 5.1e-5 3.2e-7 -3.8e-5 1.1e-5 2.3e-8 -8.4e-6 -4.9e-8; ...
    0 0 -2.8e-6 5.1e-5 3.2e-7 -3.8e-5 1.1e-5 2.3e-8 -8.4e-6 -4.9e-8; ...
    0 0 -2.8e-6 5.1e-5 3.2e-7 -3.8e-5 1.1e-5 2.3e-8 -8.4e-6 -4.9e-8; ...
    0 0 -2.8e-6 5.1e-5 3.2e-7 -3.8e-5 1.1e-5 2.3e-8 -8.4e-6 -4.9e-8; ...
    0 0 -2.8e-6 5.1e-5 3.2e-7 -3.8e-5 1.1e-5 2.3e-8 -8.4e-6 -4.9e-8; ...
    0 0 -2.8e-6 5.1e-5 3.2e-7 -3.8e-5 1.1e-5 2.3e-8 -8.4e-6 -4.9e-8; ...
    ];

quads = [];
quads = [quads; getfamilydata('QF', 'AT', 'ATIndex')];
quads = [quads; getfamilydata('QD', 'AT', 'ATIndex')];
quads = [quads; getfamilydata('QFC', 'AT', 'ATIndex')];
for i=1:size(quads, 1)
    idx = quads(i,:);
    k = getcellstruct(THERING, 'K', idx);
    coeffs = factor * quads_multipoles_1p37GeV(i, :);
    coeffs = coeffs ./ (posx.^(0:(size(quads_multipoles_1p37GeV,2)-1)));
    for j=1:length(k);
        c = coeffs * k(j) * posx;
        polynom_a = THERING{idx(j)}.PolynomA;
        max_order = max([length(polynom_a) length(c)]) - 1;
        THERING{idx(j)}.PolynomA = zeros(1,max_order+1);
        THERING{idx(j)}.PolynomB = zeros(1,max_order+1);
        THERING{idx(j)}.MaxOrder = max_order;
        THERING{idx(j)}.PolynomA(1:length(polynom_a)) = polynom_a;
        THERING{idx(j)}.PolynomB(1:length(c)) = c;
    end
end



% Multipolos sistemáticos dos Dipolos @ 300A (1.37 GeV) (medida)
% Bn/B0 onde Bn = (1/n!) * (d^nB/dx^n) x^n, com x = 1cm.
% Referência: UVX Parameter List

bends_multipoles_1p37GeV = 1 * [ ...
    0 3.014e-4 -4.777e-5 1.799e-5 -1.206e-5; ...
    0 2.765e-4 -5.114e-5 1.704e-5 -1.174e-5; ...
    0 3.117e-4 -5.273e-5 1.563e-5 -1.168e-5; ...
    0 2.913e-4 -5.085e-5 1.768e-5 -1.188e-5; ...
    0 3.049e-4 -5.052e-5 1.873e-5 -1.180e-5; ...
    0 2.810e-4 -4.755e-5 1.661e-5 -1.197e-5; ...
    0 2.906e-4 -5.222e-5 1.778e-5 -1.165e-5; ...
    0 2.780e-4 -5.414e-5 1.600e-5 -1.156e-5; ...
    0 3.007e-4 -5.031e-5 1.672e-5 -1.178e-5; ...
    0 2.743e-4 -4.739e-5 1.581e-5 -1.173e-5; ...
    0 2.705e-4 -5.198e-5 1.918e-5 -1.183e-5; ...
    0 2.835e-4 -5.440e-5 1.669e-5 -1.167e-5; ...
];

bends = getfamilydata('BEND', 'AT', 'ATIndex');
for i=1:size(bends, 1)
    idx = bends(i,:);
    ang = getcellstruct(THERING, 'BendingAngle', idx);
    len = getcellstruct(THERING, 'Length', idx);
    rho = len ./ ang;
    coeffs = factor * bends_multipoles_1p37GeV(i, :);
    coeffs = coeffs ./ (posx.^(0:(size(bends_multipoles_1p37GeV,2)-1)));
    for j=1:length(rho);
        c = coeffs / rho(j);
        polynom_a = THERING{idx(j)}.PolynomA;
        max_order = max([length(polynom_a) length(c)]) - 1;
        THERING{idx(j)}.PolynomA = zeros(1,max_order+1);
        THERING{idx(j)}.PolynomB = zeros(1,max_order+1);
        THERING{idx(j)}.MaxOrder = max_order;
        THERING{idx(j)}.PolynomA(1:length(polynom_a)) = polynom_a;
        THERING{idx(j)}.PolynomB(1:length(c)) = c;
    end
end



































