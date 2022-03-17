function bee_init(matrix,c,workers,scouts,paths_count)
%workers - liczba robotnic w populacji
%scouts - liczba zwiadowcow
%paths_count - liczba wybieranych dróg - musi byæ mniejsza od zwiadowców

global BEE_cost_matrix BEE_n BEE_gen_size BEE_workers BEE_scouts BEE_paths_count BEE_best_solution_val;
global BEE_potential_paths BEE_paths_values BEE_step;
BEE_scouts = scouts;
BEE_paths_count = paths_count;
BEE_workers = workers;
BEE_n=c;
BEE_cost_matrix = matrix;
BEE_step=0;
BEE_gen_size = length(BEE_cost_matrix)-BEE_n+1;



BEE_best_solution_val = inf;

%1. Inicjalizacja populacji za pomoc¹ losowych rozwi¹zañ.
for i=1:BEE_scouts
    BEE_potential_paths = [BEE_potential_paths random_solution(BEE_gen_size,BEE_n)'];
end
best_scout=inf;

%2. Wyliczenie funkcji celu dla populacji.
for i=1:BEE_scouts
    tmp = goal(BEE_potential_paths(:,end-i+1),BEE_n,BEE_gen_size,BEE_cost_matrix);
    if(best_scout>tmp) best_scout=tmp;end;
    BEE_paths_values = [BEE_paths_values tmp];
end
