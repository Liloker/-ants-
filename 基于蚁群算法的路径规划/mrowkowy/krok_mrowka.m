function [blad, cel] = krok_mrowka(graf, L, feromon, mrowka, par)

%graf - graf z wagami wszystkich krawedzi, osobny wêze?
%       ka¿dej ciê¿arówki
%feromon - tablica feromonów dla ka¿dej krawêdzi
%L - wektor ciê¿arów paczek dla poszczególnych wêz³ów
%mrowka - rekord zmiennych okreœlaj¹cych stan mrówki
%par - rekord parametrów symulacji
%
%blad - 'koniec trasy' jesli trasa jest juz kompletna
%       'dead' jest mrowka weszla w œlepy zau³ek i umar³a
%       'ok' wybrano nastêpny wêze?grafu
%cel - wybrany wêze?grafu. Ma sens, jeœli blad 'ok'

global type;

if (mrowka.odw >= par.N)
    blad = 'koniec trasy';
    cel = -1;
    return;
end

%przygotowanie listy celów, 1. ÉÐÎ´·ÃÎÊ
%wybrane spoœród wêz³ów grafu
lista = (par.C+1):(par.C+par.N);
lista = setdiff(lista, mrowka.sciezka);

%przygotowanie listy celów
%2. zlokalizowanie i dodanie nastêpnego magazynu (ciê¿arówki)
    % lista_magazynow = intersect(1:(par.C), mrowka.sciezka);
    % if isempty(lista_magazynow)
    %     lista = [2 lista];
    % elseif (max(lista_magazynow)+1) <= par.C
    %     lista = [max(lista_magazynow)+1 lista];
    % end
if ~(type==0 && par.poj==Inf)    
    if (mrowka.odwC+1) <= par.C
        lista = [mrowka.odwC+1 lista];    
    end
end

%przygotowanie listy celów, 3. Punkty wymagaj¹ce zbyt wiele pojemnoœci
zbyt_ciezkie = [];
for i = (par.C+1):(par.C+par.N)
    if (L(i) > mrowka.Li)
        zbyt_ciezkie = [zbyt_ciezkie i];
    end
end
lista = setdiff(lista, zbyt_ciezkie);

%lista jest pusta, œlepy zau³ek
if isempty(lista)
    blad = 'dead';
    cel = -1;
    return;
end

%obliczenie wag prawdopodobieñstwa, loc - aktualne po³o¿enie mrówki
if isempty(mrowka.sciezka)
    loc = 1;
else
    loc = mrowka.sciezka(end);
end
wagi_lista = [];
for i = lista
    if (type==1)
        if (graf(loc,i) > 0)
            waga = (1.0 + par.alfa1*feromon(loc,i)^par.alfa2)/graf(loc,i)^(par.beta^(mrowka.odwfromC+1));
        else
            waga = (par.gamma1^mrowka.odwfromC)*(1.0 + par.gamma2*feromon(loc,i)^par.gamma3);
        end
    elseif (graf(loc,i) > 0)
        waga = (1.0 + par.alfa1*feromon(loc,i)^par.alfa2)/graf(loc,i)^par.beta; 
    else
        waga = 1.0 + par.gamma2*feromon(loc,i)^par.gamma3;
    end
    wagi_lista = [wagi_lista waga];
end

index = rand_wagi(wagi_lista);
cel = lista(index);
blad = 'ok';



    



