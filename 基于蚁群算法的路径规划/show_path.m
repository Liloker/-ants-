function show_path( fig, X, points, n, clear,name)
%FUNKCJA RYSUJACA TRASE
% fig - numer wykresu na ktorym ma byc umieszczone rozwiazanie
% X - wektor rozwiazania
% points - punkty na mapie
% n - ilosc ciezarowek
% clear - czysci figure przed wyswietleniem
% name - nazwa wykresu

X = [X; 1];

route = ones(length(X),3);
car=0;
for i=1:length(X)
    route(i,1:2) = points(X(i),1:2);
    if(X(i)<=n); car=car+1; end;
    route(i,3) = car;    
end

colors = 'mcrgbky';
figure(fig);
if(clear==0); 
    hold off;    
end;
plot3(route(:,1),route(:,2),1:length(route),'.b');
grid on;
title(name);
xlabel('x');
ylabel('y');
zlabel('Move number'); 


h = 1;
t = 1;

for i=1:length(X)-1
    if (X(i)<=n)
        hold on;
        plot3(route(t,1),route(t,2),h, 'or');
    end;
    
    if (route(i,3)==route(i+1,3))
        h = h+1;
    else
        hold on;
        h = h+1;
        plot3(route(t:h,1),route(t:h,2),t:h, colors(route(i,3)));
        t=h;
    end;
end;

plot3(route(h,1),route(h,2),h, 'or');
plot3(route(t:h,1),route(t:h,2),t:h, colors(route(i,3)));
axis([0 1 0 1 1 length(X)]);
view(0,90);
