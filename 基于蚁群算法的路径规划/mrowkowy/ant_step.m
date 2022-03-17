function [najlepsze_rozw najlepsza_wartosc] = ant_step
%最好的发展/价值
global ANT_iteracja ANT_iteracja_poprawa ANT_poprawa ANT_k ANT_populacja;
global ANT_fer ANT_ro ANT_ferIt ANT_M ANT_L ANT_par ANT_najlepszy_koszt;
global ANT_najlepsza_sc ANT_C;

%检查终止算法的条件
%Je渓i jest spe硁iony, wykonujemy krok
if ((ANT_iteracja-ANT_iteracja_poprawa) <= ANT_poprawa)

    %Je渓i przesz砤 ju?ca砤 populacja (ANT_k = ANT_populacja)
    %to zako馽zenie poprzedniej du縠j interacji i inicjalizacja nast阷nej
    if (ANT_k >= ANT_populacja)
        %skalowanie ANT_fer
        %maks_fer = max(max(ANT_fer));
        %if maks_fer>0
        %    ANT_fer = ANT_fer / maks_fer;
        %end
        %skalowanie ANT_ferIt
        %maks_ferIt = max(max(ANT_ferIt));
        %if maks_ferIt>0
        %    ANT_ferIt = ANT_ferIt / maks_ferIt;
        %end
        
        %parowanie
        ANT_fer = (1 - ANT_ro)*ANT_fer + ANT_ferIt;
        %ANT_fer = ANT_fer + ANT_ferIt;
        ANT_ferIt = zeros(size(ANT_M));
        ANT_iteracja = ANT_iteracja + 1;
        ANT_k = 0;
    end

    %Przej渃ie mr體ki przez graf
    sc = ant_przemarsz(ANT_M, ANT_L, ANT_fer, ANT_par);
    ANT_k = ANT_k + 1;

    %je渓i mr體ka dotar砤 do celu:
    %  1.应用信息素
    %  2.检查解决方案是否最好
    %je渓i nie dotar砤:
    %  
    if ~(isempty(sc))
        koszt_sc = quality(sc(1:end-1));
        dawka = 1/koszt_sc;
        for i = 1:(max(size(sc))-1)
            ANT_ferIt(sc(i),sc(i+1)) = ANT_ferIt(sc(i),sc(i+1)) + dawka;
            %ferIt(sc(i+1),sc(i)) = ferIt(sc(i+1),sc(i)) + dawka;
        end
        if (koszt_sc < ANT_najlepszy_koszt)
            ANT_najlepszy_koszt = koszt_sc;%成本
            ANT_najlepsza_sc = sc(1:end-1);
            ANT_iteracja_poprawa = ANT_iteracja;
        end
    end
   %zwr骳enie wyniku, trzeba uzupe硁i?za kr髏k?渃ie縦?ci昕ar體kami
   if length(ANT_najlepsza_sc) < length(ANT_M)
       ciezarowki = [1 intersect(ANT_najlepsza_sc, 1:ANT_C)];
       ostatnia_ciez = max(ciezarowki);
       for c = (ostatnia_ciez+1):ANT_C
           ANT_najlepsza_sc = [ANT_najlepsza_sc c];
       end
   end
       
   najlepsze_rozw = ANT_najlepsza_sc;
   najlepsza_wartosc = ANT_najlepszy_koszt;    %最好的价值

%Nie wykonujemy kroku
else
    najlepsze_rozw = [];
    najlepsza_wartosc = []; 
end