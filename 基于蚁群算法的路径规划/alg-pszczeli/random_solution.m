function r = random_solution( size,n )
%Generator losowego rozwiazania poczatkowego
%   size - rozmiar miasta
%   n - ilosc ciezarowek

r = [1 randperm(size+n-2)+1];

inx = 1;
for i=1:size+n-1
    if(r(i)<=n)
       r(i) = inx;
       inx = inx +1;
    end    
end
end
