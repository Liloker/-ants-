function mrowkowy(graf, L, par)

fer = zeros(size(graf));
najlepsza_sc = [];
najlepszy_koszt = inf;
iteracja_poprawa = 0;
iteracja = 0;

%sprawdzenie warunku przerwania algorytmu
while ((iteracja-iteracja_poprawa)<=par.poprawa)

    %inicjalizacja iteracji
    ferIt = zeros(size(graf));
    k = 0;

    %sprawdzenie warunku iteracji
    while (k < par.populacja)

        %przejscie mrówki
        sc = przemarsz(graf, L, fer, par);
        k = k + 1;

        %jeœli mrówka dotar³a do celu:
        %  1.naniesienie feromonu
        %  2.sprawdzenie, czy rozwi¹zanie jest najlepsze
        %  3.naniesienie danych na wykres
        %jeœli nie dotar³a:
        %  1.naniesienie tej informacji na wykres
        if ~(isempty(sc))
            koszt_sc = koszt(graf,L,sc);
            dawka = 1/koszt_sc;
            for i = 1:(max(size(sc))-1)
                ferIt(sc(i),sc(i+1)) = ferIt(sc(i),sc(i+1)) + dawka;
                %ferIt(sc(i+1),sc(i)) = ferIt(sc(i+1),sc(i)) + dawka;
            end
            if (koszt_sc < najlepszy_koszt)
                najlepszy_koszt = koszt_sc;
                najlepsza_sc = sc;
                iteracja_poprawa = iteracja;
            end
            %zaznaczenie danych na wykresach
        else
 
        end
    end

    %operacje koñcz¹ce ka¿d?iteracj?
    fer = (1 - par.ro)*fer + ferIt;
    iteracja = iteracja + 1;

end
    
    
    



    
    
    

