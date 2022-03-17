function [ Wpsolrzedne_odwiedzonych_miejsc ] = map_road_to_XY_coordinates( Droga, Miasto_do_wspolrzednej_XY )
%MAP_ROAD_TO_XY_COORDINATES mapuje droge (ciag indeksow odwiedzanych miejsc) do wspolrzednych tych miejsc
%   droga - ciag (wektor) odwiedzonych miejsc
%   miasto_do_wspolrzednej_XY - 2-kolumnowa macierz, indeks kolumny
%   odpowiada indeksowi miejsca, wartorc kolumny 1 wspolrzednej X miejsca,
%   wartosc kolumny 2 wspolrzednej Y miejsca
%   wpsolrzedne_odwiedzonych_miejsc - ciag (wektor) wspolrzednych XY
%   odwiedzonych miejsc

Liczba_odwiedzonych_miast = length(Droga);
Wpsolrzedne_odwiedzonych_miejsc = zeros(Liczba_odwiedzonych_miast, 2);

for i=1:Liczba_odwiedzonych_miast
    Wpsolrzedne_odwiedzonych_miejsc(i,:)= (Miasto_do_wspolrzednej_XY(Droga(i),:));
end;

end

