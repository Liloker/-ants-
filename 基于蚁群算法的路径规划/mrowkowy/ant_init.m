function ant_init(matrix, C, poj, beta, alfa1, alfa2, ro, gamma1, gamma2, gamma3, pop, poprawa)

% matrix - macierz koszt�w
% C - liczba ci�ar�wek
% poj - pojemnosc pojedynczej ci�ar�wki
% beta, alfa1, alfa2 - parametry we wzorze na wagi kraw�dzi
% ro - wsp�czynnik parowania mi�dzy 0-1, 0 - nie paruje, 1 - paruje
%       ca�kowicie
% gamma1, gamma2, gamma3 - wsp�czynniki we wzorze na wagi dla kraw�dzi o
%       zerowej d�ugo�ci
% pop - rozmiar jednej populacji mr�wek
% poprawa - liczba kolejnych du�ych iteracji, kt�ra powoduje przerwanie,
%       jesli nie wyst�pi�a poprawa

global ANT_fer ANT_najlepsza_sc ANT_najlepszy_koszt ANT_iteracja_poprawa ANT_iteracja;
global ANT_poprawa ANT_ferIt ANT_beta ANT_alfa1 ANT_alfa2 ANT_ro ANT_gamma1 ANT_gamma2 ANT_gamma3;
global ANT_populacja ANT_L ANT_poj ANT_par ANT_k ANT_M ANT_C;

%inicjalizacja parametr�w
ANT_M = matrix;
ANT_C = C;
ANT_poj = poj;
ANT_N = length(ANT_M) - ANT_C;
ANT_L = [zeros(1,ANT_C) ones(1,ANT_N)];
ANT_beta = beta;
ANT_alfa1 = alfa1;
ANT_alfa2 = alfa2;
ANT_ro = ro;
ANT_gamma1 = gamma1;
ANT_gamma2 = gamma2;
ANT_gamma3 = gamma3;
ANT_populacja = pop;%����������
ANT_poprawa = poprawa;

ANT_par.C = ANT_C;
ANT_par.poj = ANT_poj;
ANT_par.N = ANT_N;
%ANT_par.L = ANT_L;
ANT_par.beta = ANT_beta;
ANT_par.alfa1 = ANT_alfa1;
ANT_par.alfa2 = ANT_alfa2;
ANT_par.ro = ANT_ro;
ANT_par.gamma1 = ANT_gamma1;
ANT_par.gamma2 = ANT_gamma2;
ANT_par.gamma3 = ANT_gamma3;
ANT_par.populacja = ANT_populacja;
ANT_par.poprawa = ANT_poprawa;

%inicjalizacja ca�ego algorytmu
ANT_fer = zeros(size(ANT_M));
ANT_najlepsza_sc = [];
ANT_najlepszy_koszt = inf;
ANT_iteracja_poprawa = 0;
ANT_iteracja = 0;

%inicjalizacja pierwszej iteracji
ANT_ferIt = zeros(size(ANT_M));
ANT_k = 0;



    