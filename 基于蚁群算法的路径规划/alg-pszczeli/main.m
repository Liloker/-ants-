%plik glowny
clc;
clear all;
close all;

%paramery symulacji
max_iteration = 300; %liczba iteracji
n = 2;              %liczba ciezarowek
size = 40;          %rozmiar miasta
workers = 400;      %liczba robotnic w populacji
scouts = 150;        %liczba zwiadowcow
paths_count = 50;    %liczba wybieranych dróg - musi byæ mniejsza od zwiadowców

%[cost_matrix x y] = real_gen(size,n);   %generator macierzy kosztow
%save('cost_matrix_test.mat', 'cost_matrix','size', 'x', 'y', 'n');

load('cost_matrix_test.mat');          %wczytanie macierzy kosztow

%parametry wyswietlania
show_markers = 0;   %pokazuje rozk³ad rozwi¹zañ wzglêdem zwiadowców
show_avr = 1;       %pokazuje œredni¹ wartoœæ najlepszego zwiadowcy
show_path = 1;      %pokazuje najlepsz¹ trasê na grafie 3D
time_delay = 0.01;  %opóŸnienie miêdzy iteracjami

hold on;
grid on;
title('Current best value and scout value');

best_solution_val = inf;
marker_index = 1;
potential_paths = [];
paths_values = [];
scouts_markers  = [];

%1. Inicjalizacja populacji za pomoc¹ losowych rozwi¹zañ.
for i=1:scouts
    potential_paths = [potential_paths random_solution(size,n)'];
    scouts_markers = [scouts_markers  marker_index];
    marker_index = marker_index+1;
end
best_scout=inf;

%2. Wyliczenie funkcji celu dla populacji.
for i=1:scouts
    tmp = goal(potential_paths(:,end-i+1),n,size,cost_matrix);
    if(best_scout>tmp) best_scout=tmp;end;
    paths_values = [paths_values tmp];
end
h=figure(1);
set(h,'Position',[9 49 704 772]);
plot(0,best_scout,'bo');

%3. While (kryterium stopu nie spe³nione) //Tworzenie nowej populacji.

%prealokacja
avr=zeros(1,max_iteration);

%%%%%%%%%%%%%%%%%%%%%%%%%%%% PETLA GLOWNA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for step=1:max_iteration
    tic;
    
    %4.   Wybór najlepszych miejsc do przeszukiwania s¹siedztwa.
    best_paths_values = zeros(1, paths_count);
    best_paths = zeros(size+n-1, paths_count);
    for i=1:paths_count
        [v index] = min(paths_values);
        best_paths(:,i) = potential_paths(:,index);
        best_paths_values(i) = v;
        paths_values(index) = inf;
    end

    %Werbunek pszczó³ dla wybranych miejsc (proporcjonalnie do najlepszych miejsc + sta³a wartoœæ 1)
    %workers = workers - paths_count;
    val_per_worker = sum(best_paths_values-min(best_paths_values))/workers;
    recruited_workers = zeros(1,paths_count);
    if(val_per_worker==0)
        for i=1:paths_count
            recruited_workers(i) = 1+round(workers/paths_count);
        end
    else
        for i=1:paths_count
            recruited_workers(i) = 1+floor((best_paths_values(i)-min(best_paths_values))/val_per_worker);
        end
    end
    %recruited_workers(1) = recruited_workers(1)+workers - sum(recruited_workers);
    %workers = workers + paths_count;

    %Badanie przez pozosta³e pszczo³y s¹siedztwa ( ponowne wyliczanie funkcji celu )
    potential_paths = best_paths;
    paths_values = best_paths_values;
    for i=1:paths_count
        for j=1:recruited_workers(i)
            potential_paths = [potential_paths get_neighbour(best_paths(:,i),n) ]; % czy droga moze sie powtarzac?
            paths_values = [paths_values goal(potential_paths(:,end),n,size,cost_matrix)];
        end
    end

    %Nowi zwiadowcy
    current_length = length(paths_values);
    potential_paths = [potential_paths zeros(size+n-1,scouts)];
    for i=1:scouts
        potential_paths(:,current_length+i) = random_solution(size,n)';
        marker_index = marker_index+1;
    end
    best_scout=inf;
    paths_values = [paths_values zeros(1,scouts)];
    for i=1:scouts
        tmp = goal(potential_paths(:,end-i+1),n,size,cost_matrix);
        if(best_scout>tmp) best_scout=tmp;end;
        paths_values(current_length+i) = tmp;
    end

    h=figure(1);
    set(h,'Position',[9 49 704 772]);
    plot(step,best_scout,'bo');

    %Usuniecie powtorzonych tras
    for i=1:length(paths_values)
        tmp = paths_values(i);
        for j=1:i
            if(i==j); continue; end;
            if(paths_values(i)==paths_values(j))
                paths_values(i)=inf;
            end
        end
    end
    for i=1:length(paths_values)
        if( paths_values(i)==inf)
            paths_values = [paths_values(1:i-1) paths_values(i+1:end)];
            potential_paths = [potential_paths(:,1:i-1) potential_paths(:,i+1:end)];
        end
        if(i+1>length(paths_values)) break; end;
    end

    %Wybór najlepszego rozwi¹zania.
    if(show_markers==1)
        for i=1:paths_count
            figure(best_markers(i)+2);
            grid on;
            plot(step,best_paths_values(i),'r.');
            hold on;
            title(strcat('Marker numer: ',num2str(best_markers(i))));
        end
    end
    
    h=figure(1);
    set(h,'Position',[9 49 704 772]);
    grid on;
    hold on;
    title('Best solution and scout value');
    xlabel('Step number');
    ylabel('Goal function');
    subplot(2,1,1);
    plot(step,min(best_paths_values),'r.');

    %wybór i rysowanie najlepszej trasy
    if(show_path==1)
        [v index] = min(best_paths_values);
        if(v<best_solution_val)
            best_solution = best_paths(:,index);
            best_solution_val = v;
            x_sol = zeros(1,length(best_solution));
            y_sol = zeros(1,length(best_solution));
            for i=1:length(best_solution)
                x_sol(i) = x(best_solution(i));
                y_sol(i) = y(best_solution(i));
            end
            h=figure(2);
            set(h,'Position',[729 49 704 772]);
            plot3([x_sol 0.5],[y_sol 0.5],1:length(x_sol)+1,'g-');
            hold on;
            for i=1:length(best_solution)
                if(best_solution(i)<=n)
                     plot3(0.5,0.5,i,'ro');
                end;
            end
           
            plot3(0.5,0.5,length(x_sol)+1,'ro');
            plot3([x_sol 0.5],[y_sol 0.5],1:length(x_sol)+1,'b.');
            title('Best solution graph');
            xlabel('x');
            ylabel('y');
            zlabel('Move number');
            axis([0 1 0 1 1 length(x_sol)]);
            view(0,90);
            grid on;
            hold off;
        end;
    end;

    %liczenie sredniej z najlepszych zwiadow
    if(show_avr==1)
        avr(step) = best_scout;
        h=figure(1);
        set(h,'Position',[9 49 704 772]);
        subplot(2,1,2);
        hold off;
        plot([0 step],[sum(avr)/step sum(avr)/step],'g');
        hold on;
        plot(1:step,avr(1:step),'b.');
        grid on;
        title('Best scout / step');
        xlabel('Step number');
        ylabel('Goal function');
        subplot(2,1,1);
        pause(time_delay);
    end;    
    
    
    clc;
    display('Postêp:');
    display(floor(100*step/max_iteration));
    display('Czas iteracji:');
    toc
end;
%9. End FOR.
max(best_paths_values)



