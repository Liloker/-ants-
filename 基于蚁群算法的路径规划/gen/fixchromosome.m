function Y = fixchromosome(X)
% Sprawdza poprawnosc chromosomu X, usuwa powtorzenia.

len = length(X);
Y = X;

rep = zeros(len+1);	% Repetitions
change = [];	% Chosen positions with repetitions
missing = [];	% Missing gens

for i = 1:len,	% Mark repetitions
	if rep(Y(i)) == 0,
		rep(Y(i)) = i;
	else
		if rand() < .5,
			change = [change, rep(Y(i))];
		else
			change = [change, i];
		end
	end
end

for i = 2:len+1,	% Find missing values
	if rep(i) == 0,
		missing = [missing, i];
	end
end

for i = 1:length(missing),	% Fix chromosome
	Y(change(i)) = missing(i);
end

if length(change) > 1,
    Y = partial_permute(Y, change);
end

end	%fixchromosome