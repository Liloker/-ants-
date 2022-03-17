function [M points] = generate_matrix(N, Cn, varargin)
if(length(varargin)==2)
    x = varargin{1};
    y = varargin{2};
elseif (isempty(varargin))
    x = 1;
    y = 1;
else
    error('Bad input arguments number.');
end
    

points = [x*rand(N+1,1), y*rand(N+1,1)];    % 绘制1个共同仓库和N个客户

Nc = N+Cn;  % Okresl wielkosc macierzy kosztow

M = Inf * eye(Nc);  % Utwworz macierz grafu bez petli
if Cn > 1,  % Dopelnianie tablicy wspolrzednych
    Mpt = [ones(Cn-1, 1)*points(1,1), ones(Cn-1, 1)*points(1,2)];   % Kopiowanie wspolrzenej magazynu Cn razy
    points = [Mpt; points];   % Dopelnienie tablicy wspolrzednych
end
points=importdata('data1.txt')
for i = 1:Nc-1, % Obliczenie kosztow na krawedziach grafu
    for j=i+1:Nc,
       M(i,j) = sqrt(norm((points(i,:)-points(j,:))));
       M(j,i) = M(i,j);
    end
end

%obsoled
% h = figure;
% hold on;
% plot(points(Cn+1:end,1), points(Cn+1:end,2), '.b'); % Wyrysuj polozenia klientow
% plot(points(1,1), points(1,2), '.r');   % Wyrysuj magazyn
% hold off;

end