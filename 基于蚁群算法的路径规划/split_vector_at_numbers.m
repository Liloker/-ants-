function [ RozdzieloneVektoryCell ] = split_vector_at_numbers( Vector, SplitNumbers )
%SPLIT_VECTOR_AT_NUMBERS Rozdziela vektor na podwektory w zadanych
%wartosciach
%   Vector - vektor do rozdzielenia
%   SplitNumbers - wartosci przy ktorych Vector ma byc rozdzielony

RozdzieloneVektoryCell = cell(1, length(SplitNumbers));
X = Vector;

for i=1:length(SplitNumbers)
    [RozdzieloneVektoryCell{i} X] = split_vector_at_number(X, SplitNumbers(i));
end;

for j=1:(length(SplitNumbers)-1)
    RozdzieloneVektoryCell{j} = RozdzieloneVektoryCell{j+1};
end
RozdzieloneVektoryCell{end} = X;

end

function [ PierwszyVektor Reszta ] = split_vector_at_number( Vector, number )
%SPLIT_VECTOR_AT_NUMBERS Rozdziela vektor na podwektory w zadanych
%wartosciach
%   Vector - vektor do rozdzielenia
%   SplitNumbers - wartosci przy ktorych Vector ma byc rozdzielony
%   ZWRACA:
%   PierwszyVektor - wszystkie elementy poprzedzajace 'number'
%   Reszta - to co pozostalo

PierwszyVektor = [];
pierwszyVektorDlugosc = 0;

for i=1:length(Vector)
    if(Vector(i)==number)
        break;        
    end
    PierwszyVektor = [PierwszyVektor; Vector(i)];
    pierwszyVektorDlugosc = pierwszyVektorDlugosc + 1;
end

Reszta = Vector(pierwszyVektorDlugosc+1:end);

end

