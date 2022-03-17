function [blad, cel] = krok_mrowka(graf, L, feromon, mrowka, par)

%graf - graf z wagami wszystkich krawedzi, osobny w�ze?
%       ka�dej ci�ar�wki
%feromon - tablica feromon�w dla ka�dej kraw�dzi
%L - wektor ci�ar�w paczek dla poszczeg�lnych w�z��w
%mrowka - rekord zmiennych okre�laj�cych stan mr�wki
%par - rekord parametr�w symulacji
%
%blad - 'koniec trasy' jesli trasa jest juz kompletna
%       'dead' jest mrowka weszla w �lepy zau�ek i umar�a
%       'ok' wybrano nast�pny w�ze?grafu
%cel - wybrany w�ze?grafu. Ma sens, je�li blad 'ok'

global type;

if (mrowka.odw >= par.N)
    blad = 'koniec trasy';
    cel = -1;
    return;
end

%przygotowanie listy cel�w, 1. ��δ����
%wybrane spo�r�d w�z��w grafu
lista = (par.C+1):(par.C+par.N);
lista = setdiff(lista, mrowka.sciezka);

%przygotowanie listy cel�w
%2. zlokalizowanie i dodanie nast�pnego magazynu (ci�ar�wki)
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

%przygotowanie listy cel�w, 3. Punkty wymagaj�ce zbyt wiele pojemno�ci
zbyt_ciezkie = [];
for i = (par.C+1):(par.C+par.N)
    if (L(i) > mrowka.Li)
        zbyt_ciezkie = [zbyt_ciezkie i];
    end
end
lista = setdiff(lista, zbyt_ciezkie);

%lista jest pusta, �lepy zau�ek
if isempty(lista)
    blad = 'dead';
    cel = -1;
    return;
end

%obliczenie wag prawdopodobie�stwa, loc - aktualne po�o�enie mr�wki
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



    



