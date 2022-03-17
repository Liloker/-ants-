function [YY QQ] = rank(XX, Q)
% Porzadkuje osobniki wedlug funkcji celu
%   XX - macierz osobnikow: wiersz=chromosom
%   Q  - wektor funkcji celu
% 
% Zwraca uporzadkowana macierz osobnikow YY i odpowiadajace im uporzadkowane funkcje celu QQ

[Ws len] = size(XX);

YY = zeros(Ws, len);

[QQ index] = sort(Q);

for i = 1:Ws,
    YY(i, :) = XX(index(i), :);
end

end


