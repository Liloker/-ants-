function color_plot_odwiedzone_miejsca( h, Indeksy_odwiedzonych_miejsc, ilosc_magazynow, Wspolrzedne_miejsc )
%COLOR_PLOT_ODWIEDZONE_MIEJSCA pokazuje za pomoca kolorowych strzalek kolejnosc
%odwiedzonych miejsc
%   h - uchwyt do rysynku
%   Wspolrzedne_miejsc - 2-kolumnowa macierz,
%       wartosci wiersz - wspolrzedne XY miejsca
%       indeks wiersza - identyfikator miejsca
%   ilosc_magazynow - ilosc magazynow


colors = 'mcrgbky';
TrasyCiezarowek = split_vector_at_numbers(Indeksy_odwiedzonych_miejsc, [1:ilosc_magazynow]');

% axes(h);
% set(fig_h,'CurrentAxes',h);
% newplot(h);

% hold off;

cla(h);
hold on;


for i=1:length(TrasyCiezarowek)
    if(i<=length(colors))
        c = colors(i);
    else
        c= 'k';
    end
    plot_odwiedzone_miejsca_strzalkami(h, ...
        map_road_to_XY_coordinates(TrasyCiezarowek{i}, Wspolrzedne_miejsc),...
        c);
end
hold off;

end

