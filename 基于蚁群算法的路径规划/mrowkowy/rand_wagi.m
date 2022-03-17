function index = rand_wagi(w)
    
    %wektor wartoœci skumulowanych
    cum_w = cumsum(w);
    
    %jeœli wektor jest wierszowy, to obracamy na kolumnowy
    rozmiar = size(cum_w);
    if rozmiar(1) > rozmiar(2)
        cum_w = cum_w';
    end
    
    %dopisujemy 0 na pocz¹tku
    cum_w = [0 cum_w];
        
    %wylosowanie liczby, rozci¹gniêcie przedzia³u z 0-1 do
    %0-suma skumulowana
    losowa = cum_w(end)*rand;
    
    %w którym przedziale mieœci sie liczba?
    odp = -1;
    n = max(size(cum_w));
    for i=1:n-1
        if (cum_w(i) <= losowa) && (losowa <= cum_w(i+1))
            odp = i;
            break;
        end
    end
    index = odp;
    