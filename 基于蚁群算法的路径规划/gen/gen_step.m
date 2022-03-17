function [X Q] = gen_step()
% Krok algorytmu genetycznego.
% Zwraca:
% X   - najlepsza dotychczas trase
% Q   - ocene najlepszej trasy
%
% Przed pierwszym wywolaniem gen_step nalezy wykonac gen_init.

global gen_Ws gen_cross_operations gen_mutations gen_swaps gen_switches gen_XX gen_QQ

[population_size gen_length_of_chromosome] = size(gen_XX);
act_size = population_size;

gen_XX = [gen_XX; zeros(gen_cross_operations*2 + gen_mutations + gen_swaps + gen_switches, gen_length_of_chromosome)];

% Do cross operation
for i = 1:gen_cross_operations,
    couple = parent_selection(act_size);
    [X1 X2] = cross(gen_XX(couple(1), :), gen_XX(couple(2), :), ceil(rand*5));
    act_size = act_size + 1;
    gen_XX(act_size, :) = X1;
    gen_QQ(act_size) = gen_quality(X1);
    act_size = act_size + 1;
    gen_XX(act_size, :) = X2;
    gen_QQ(act_size) = gen_quality(X2);
end

% Do random mutation
for i = 1:gen_mutations,
    X1 = mutate(gen_XX(ceil(rand*population_size),:), ceil(rand*4));
    act_size = act_size + 1;
    gen_XX(act_size, :) = X1;
    gen_QQ(act_size) = gen_quality(X1);
end

% Do swap mutation
for i = 1:gen_swaps,
    X1 = swap2(gen_XX(ceil(rand*population_size),:));
    act_size = act_size + 1;
    gen_XX(act_size, :) = X1;
    gen_QQ(act_size) = gen_quality(X1);
end

% Do switch mutation
for i = 1:gen_switches,
    X1 = switchpoint(gen_XX(ceil(rand*population_size),:));
    act_size = act_size + 1;
    gen_XX(act_size, :) = X1;
    gen_QQ(act_size) = gen_quality(X1);
end

% Sort population
[gen_XX gen_QQ] = rank(gen_XX, gen_QQ);

% Eliminate repeated routes
[gen_XX gen_QQ] = uniqueroute(gen_XX, gen_QQ);

act_size = length(gen_QQ);
new_size = min(gen_Ws, act_size);

% Reduce population's size
gen_XX = gen_XX(1:new_size, :);
gen_QQ = gen_QQ(1:new_size);

X = [1, gen_XX(1,:)];
Q = gen_QQ(1);

end %gen_step