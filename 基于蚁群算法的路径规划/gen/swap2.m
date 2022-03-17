function Y = swap2(X)
% Zamiana dwoch punktow dostawy i odwrocenie miedzy nimi sciezki.

len = length(X);

x1 = ceil(rand * len);
x2 = ceil(rand * len);
while x1 == x2,
    x2 = ceil(rand * len);
end
x = sort([x1 x2]);

Y = [X(1:x(1)-1), X(x(2):-1:x(1)), X(x(2)+1:len)];

end %swap2