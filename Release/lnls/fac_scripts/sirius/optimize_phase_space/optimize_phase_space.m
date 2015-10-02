RandStream.setGlobalStream(RandStream('mt19937ar','seed', 131071));
% first, we load the lattice
ring = sirius_local_lattice();
mia = findcells(ring,'FamName','mia');
ring = ring(1:mia(2));

% now, we define which families will be used to optimize the phase space
% and which will be used to correct chromaticity;
opt.fam = {'sfa','sda','sfb','sdb','sfm','sdm','sd2j','sd3j','sf2j','sd1k','sf1k','sd2k','sd3k','sf2k'};
chr.fam = {'sd1j','sf1j'};

%what is our target chromaticity?
chr.value = [0.5,0.5];

% now we find the indices of the elements in the ring:
opt.ind = cell(1,length(opt.fam));
opt.vec_ini = zeros(1,length(opt.fam));
opt.size = zeros(length(opt.fam),1);
chr.ind = cell(1,length(chr.fam));
for ii=1:length(opt.fam)
    opt.ind{ii} = findcells(ring,'FamName',opt.fam{ii});
    opt.vec_ini(ii) = getcellstruct(ring,'PolynomB',opt.ind{ii}(1),3);
    opt.size(ii) = length(opt.ind{ii}); % get the number of elements in each family
end
for ii=1:length(chr.fam)
    chr.ind{ii} = findcells(ring,'FamName',chr.fam{ii});
end
opt.ind = cell2mat(opt.ind); % transform to vector;


% Lets define our initial point:
% vec = [-115.7829759411277/2,  49.50386128829739/2, -214.5386552515188/2,...
%    133.1252391065637/2, -164.3042864671946/2, -289.9270429064217/2,...
%    333.7039740852999/2];

%4k
% vec =[-60.9192  26.3203 -105.5614  62.0680 -69.5216 -133.7175  150.2310];

% vec = [-52.632126  23.963083 -82.087662  67.612541  -95.818807 -163.258854 179.730185];

vec = opt.vec_ini;
 
% what will be our error level:
err_level = 2/100;

%% now we begin the optimization:

% first we calculate the initial parameters 
[res chr.val] = optimize_fun(ring, vec, opt, chr);

% and begin the main loop
fp = fopen('solucoes.txt','w');
figure; axes; hold('all');grid('on');
plot(0,res,'.r');
for ii=1:1000000
    err = lnls_generate_random_numbers(err_level, length(opt.fam),'uniform',1,0);
    newvec = vec.*(1+err);
    [newres, newval,cur_ring] = optimize_fun(ring, newvec, opt, chr);
    plot(ii,newres,'.b');
    drawnow();
    if newres < res
        res = newres;
        vec = newvec;
        chr.val = newval;
        fprintf('%d: %10.6f  vec =  ',ii,res);
        fprintf('%12.6f',vec);
        fprintf('\n');
        fprintf(fp,'%d: %10.6f  vec =  ',ii,res);
        fprintf(fp,'%12.6f',vec);
        fprintf(fp,'\n');
        for jj = 1:length(opt.fam)
            fprintf('    %3s_strength       = %10.4f;\n',opt.fam{jj}, vec(jj));
            fprintf(fp,'    %3s_strength       = %10.4f;\n',opt.fam{jj}, vec(jj));
        end
        for jj = 1:length(chr.fam)
            fprintf('    %3s_strength       = %10.4f;\n',chr.fam{jj}, chr.val(jj));
            fprintf(fp,'    %3s_strength       = %10.4f;\n',chr.fam{jj}, chr.val(jj));
        end
        fprintf(fp,'\n');
        fprintf('\n');
    end
end
fclose(fp);    
