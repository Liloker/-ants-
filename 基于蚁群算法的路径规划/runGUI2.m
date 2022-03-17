% RUNGUI - Skrypt uruchamiajacy gui

% Czyszczenie danych historycznych

clc;
clear;
% clear all;
close all;


% Ustawienie sciezek do podprojektow
addpath alg-pszczeli;
addpath mrowkowy;
addpath gen;
addpath MarketingGUI;


% Ogolne parametry problemu
global n size cost_matrix type max_iter points;
% max_iter = 150; %maksymalna ilosc iteracji
% n = 3; %ilosc ciezarowek
% size = 20; %rozmiar miasta
% type = 1;% typ funkcji celu od 0 do 2 - odsylam do quality.m

max_iter = 15; %maksymalna ilosc iteracji
size = 20; %rozmiar miasta
n = 3; %ilosc ciezarowek
type = 1;% typ funkcji celu od 0 do 2 - odsylam do quality.m

global N Cn
Cn = n;
N = size;

[cost_matrix points] = generate_matrix(size, n);

% Parametry algorytmu pszczelego
global GUI_BEE_scouts GUI_BEE_paths_count GUI_BEE_workers;
GUI_BEE_scouts = 100;
GUI_BEE_workers = 600;
GUI_BEE_paths_count = 50;


% Parametry algorytmu mrowkowego
global GUI_ANT_wspolczynnik_parowania GUI_ANT_rozmiar_jednej_populacji;
GUI_ANT_wspolczynnik_parowania = 0.3;
GUI_ANT_rozmiar_jednej_populacji = 200;

% Parametry algorytmu genetycznego
global GUI_GEN_poczatkowa_wielkosc_populacji;
GUI_GEN_poczatkowa_wielkosc_populacji = 100;


% uruchomienie GUI
mainGUI
