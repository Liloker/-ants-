function Y = mutate(X, N)
% Proces mutacji N+2 losowych genów chromosomu X.
% N >= 0. Mutuje N+2 losowych genów, nastepuje ich losowa permutacja. Permutacja tozsamosciowa jest zabroniona.

len = length(X);
if N>len-2, N = len-2; end
change = randperm(len);
change = change(1:N+2);% Wybierz N+2 losowych genow

Y = partial_permute(X, change);

end %mutate