function [m x y]  = real_gen( size, n )
%Funkcja generujaca realna macierz kosztow.
%   m - macierz 
%   x - wektor wartosci na osi x
%   y - wektor wartosci na osi y
%   size - rozmiar macierzy
%   n - ilosc ciezarowek

for i=1:size+n-1
    if(i==1)
        x=0.5;
        y=0.5;
    else
        x=[x rand];
        y=[y rand];
    end;
    x0=x(end);
    y0=y(end);
    for j=1:i
        if(i==j) 
            m(i,i)=inf;
            break; 
        elseif (i<=n & j<=n)
           m(i,j)=0.5;
           m(j,i)=0.5;
           x(end) = 0.5;
           y(end) = 0.5;
        else   
            m(i,j) = sqrt( (x(j)-x0)^2 + (y(j)-y0)^2);
            m(j,i) = m(i,j);
        end;
    end;
end;

for i=1:n
   m(i,n+1:size) = m(1,n+1:size);
   m(n+1:size,i) = m(n+1:size,1);
end

