function Y = switchpoint(X)
% Przesuniecie kolejnosci jednego punktu dostawy.

len = length(X);

x1 = ceil(rand * len);
x2 = ceil(rand * len);
while x1 == x2,
    x2 = ceil(rand * len);
end
x = sort([x1 x2]);

if rand < .5,
    Y = [X(1:x(1)-1), X(x(1)+1:x(2)), X(x(1)), X(x(2)+1:len)];
else
    Y = [X(1:x(1)-1), X(x(2)), X(x(1):x(2)-1), X(x(2)+1:len)];
end

end %switchpoint