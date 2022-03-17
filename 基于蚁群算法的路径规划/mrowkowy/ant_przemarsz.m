function sciezka = ant_przemarsz(graf, L, feromon, par)
%游行
% graf - graf z wagami kraw阣zi
% L - wektor ci昕aru 砤dunk體 do poszczeg髄nych w陑丑w
% feromon - macierz feromon體 na kraw阣ziach
% par - parametry symulacji

mrowka.Li = par.poj;
mrowka.odw = 0;
mrowka.odwC = 1;
mrowka.odwfromC = 0;
mrowka.sciezka = [];


[blad cel] = krok_mrowka(graf, L, feromon, mrowka, par);

%数据更新后 zwyk硑m przej渃iu do nast阷nego w陑砤
%licznik mrowka.odw zlicza tylko w陑硑 w砤渃iwe (nie magazyny)
while (strcmp(blad,'ok'))
    mrowka.sciezka = [mrowka.sciezka cel];
    if (cel <= par.C)
        mrowka.Li = par.poj;
        mrowka.odwC = mrowka.odwC + 1;
        mrowka.odwfromC = 0;
    else
        mrowka.Li = mrowka.Li - L(cel);
        mrowka.odw = mrowka.odw + 1;
        mrowka.odwfromC = mrowka.odwfromC + 1;
    end
    
    [blad cel] = krok_mrowka(graf, L, feromon, mrowka, par);
end

if (strcmp(blad,'koniec trasy'))%路线尽头
    sciezka = [1 mrowka.sciezka 1];
    return;
end

sciezka = [];

