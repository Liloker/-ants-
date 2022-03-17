function [X Q] = gen_init(Ws)
% Krok poczatkowy algorytmu genetycznego. Tworzy losowa populacje osobnikow
% o wielkosci Ws.
% Zwraca:
% X   - najlepsza dotychczas trase
% Q   - ocene najlepszej trasy


global gen_Ws gen_cross_operations gen_mutations gen_swaps gen_switches gen_XX gen_QQ
gen_Ws = Ws;

global gen_cross_operations gen_mutations gen_swaps gen_switches

gen_cross_operations = ceil(3*gen_Ws/5);
gen_mutations = ceil(gen_Ws/10);
gen_swaps = ceil(gen_Ws/5);
gen_switches = ceil(gen_Ws/5);

% Create random population
[gen_XX gen_QQ] = generate(gen_Ws);
% Sort population
[gen_XX gen_QQ] = rank(gen_XX, gen_QQ);
% Eliminate repeated routes
[gen_XX gen_QQ] = uniqueroute(gen_XX, gen_QQ);

X = [1, gen_XX(1,:)];
Q = gen_QQ(1);

end %gen_init