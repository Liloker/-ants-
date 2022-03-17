function Y = partial_permute(X, change)
% Permutacja wybranych genów chromosomu X.
% Wektor change zawiera pozycje wybranych genow.

Y = X;
len = length(change);

if len > 1,
    order = change;
    while isequal(order, change),
        order = permute_vector(change, randperm(len));
    end

    % X = 1 2 3 4 5 6 7 8 9
    % c = 6 3 2
    % o = 2 3 6
    % Y = 1 6 3 4 5 2 7 8 9

    for i = 1:len,
        Y(change(i))= X(order(i));
    end 
end

end %partial_permute