function plot_odwiedzone_miejsca_strzalkami(h, Wspolrzedne_odwiedzonych_miejsc, kolor )
%PLOT_ODWIEDZONE_MIEJSCA_STRZALKAMI pokazuje za pomoca strzalek kolejnosc odwiedzonych miejsc
%   h - uchwyt do osi
%   Wspolrzedne_odwiedzonych_miejsc - 2-kolumnowa macierz,
%   wiersz - wspolrzedne XY miejsca
%   indeks wiersza - kolejnosc odwiedzanych miejsc
%   kolor - kolor wykresu


grid on;

plot(h, Wspolrzedne_odwiedzonych_miejsc(:,1),...
    Wspolrzedne_odwiedzonych_miejsc(:,2),...
    'o',...
    'color', kolor, ...
    'MarkerFaceColor',kolor,...
    'MarkerSize',8);

if(mat_row_length(Wspolrzedne_odwiedzonych_miejsc)>=1)
plot(h, Wspolrzedne_odwiedzonych_miejsc(1,1),...
    Wspolrzedne_odwiedzonych_miejsc(1,2),...
    'o',...
    'LineWidth',2,...
    'color', 'k', ...
    'MarkerFaceColor','r',...
    'MarkerSize',10);
end

if(mat_row_length(Wspolrzedne_odwiedzonych_miejsc)>=2)
    for i=1:(mat_row_length(Wspolrzedne_odwiedzonych_miejsc)-1)
        x1 = Wspolrzedne_odwiedzonych_miejsc(i,1);
        y1 = Wspolrzedne_odwiedzonych_miejsc(i,2);
        x2 = Wspolrzedne_odwiedzonych_miejsc(i+1,1);
        y2 = Wspolrzedne_odwiedzonych_miejsc(i+1,2);
        
        drawarrow_2(x1, x2, y1, y2, .03, kolor);
    end
    
    x1 = Wspolrzedne_odwiedzonych_miejsc(1, 1);
    y1 = Wspolrzedne_odwiedzonych_miejsc(1, 2);
    xn = Wspolrzedne_odwiedzonych_miejsc(end, 1);
    yn = Wspolrzedne_odwiedzonych_miejsc(end, 2);
    
    drawarrow_2(xn, x1, yn, y1, .03, kolor);
end

end

