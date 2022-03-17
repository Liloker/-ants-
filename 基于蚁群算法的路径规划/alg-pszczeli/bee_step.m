function [out_best_solution out_best_solution_val] = bee_step
%BEE_STEP Summary of this function goes here
%   Detailed explanation goes here

global BEE_cost_matrix BEE_n BEE_gen_size BEE_workers BEE_scouts BEE_paths_count BEE_best_solution BEE_best_solution_val;
global BEE_potential_paths BEE_paths_values BEE_step;

%%%%%%%%%%%%%%%%%%%%%%%%%%%% PETLA GLOWNA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
BEE_step=1+BEE_step;
    
    %4.   Wybór najlepszych miejsc do przeszukiwania s¹siedztwa.
    best_BEE_paths_values = zeros(1, BEE_paths_count);
    best_paths = zeros(BEE_gen_size+BEE_n-1, BEE_paths_count);
    for i=1:BEE_paths_count
        [v index] = min(BEE_paths_values);
        best_paths(:,i) = BEE_potential_paths(:,index);
        best_BEE_paths_values(i) = v;
        BEE_paths_values(index) = inf;
    end

    %Werbunek pszczó³ dla wybranych miejsc (proporcjonalnie do najlepszych miejsc + sta³a wartoœæ 1)
    %BEE_workers = BEE_workers - BEE_paths_count;
    val_per_worker = sum(best_BEE_paths_values-min(best_BEE_paths_values))/BEE_workers;
    recruited_BEE_workers = zeros(1,BEE_paths_count);
    if(val_per_worker==0)
        for i=1:BEE_paths_count
            recruited_BEE_workers(i) = 1+round(BEE_workers/BEE_paths_count);
        end
    else
        for i=1:BEE_paths_count
            recruited_BEE_workers(i) = 1+floor((best_BEE_paths_values(i)-min(best_BEE_paths_values))/val_per_worker);
        end
    end
    %recruited_BEE_workers(1) = recruited_BEE_workers(1)+BEE_workers - sum(recruited_BEE_workers);
    %BEE_workers = BEE_workers + BEE_paths_count;

    %Badanie przez pozosta³e pszczo³y s¹siedztwa ( ponowne wyliczanie funkcji celu )
    BEE_potential_paths = best_paths;
    BEE_paths_values = best_BEE_paths_values;
    for i=1:BEE_paths_count
        for j=1:recruited_BEE_workers(i)
            BEE_potential_paths = [BEE_potential_paths get_neighbour(best_paths(:,i),BEE_n) ]; % czy droga moze sie powtarzac?
            BEE_paths_values = [BEE_paths_values goal(BEE_potential_paths(:,end),BEE_n,BEE_gen_size,BEE_cost_matrix)];
        end
    end

    %Nowi zwiadowcy
    current_length = length(BEE_paths_values);
    BEE_potential_paths = [BEE_potential_paths zeros(BEE_gen_size+BEE_n-1,BEE_scouts)];
    for i=1:BEE_scouts
        BEE_potential_paths(:,current_length+i) = random_solution(BEE_gen_size,BEE_n)';
    end
    best_scout=inf;
    BEE_paths_values = [BEE_paths_values zeros(1,BEE_scouts)];
    for i=1:BEE_scouts
        tmp = goal(BEE_potential_paths(:,end-i+1),BEE_n,BEE_gen_size,BEE_cost_matrix);
        if(best_scout>tmp) best_scout=tmp;end;
        BEE_paths_values(current_length+i) = tmp;
    end

    
    %Usuniecie powtorzonych tras
    for i=1:length(BEE_paths_values)
        tmp = BEE_paths_values(i);
        for j=1:i
            if(i==j); continue; end;
            if(BEE_paths_values(i)==BEE_paths_values(j))
                BEE_paths_values(i)=inf;
            end
        end
    end
    for i=1:length(BEE_paths_values)
        if( BEE_paths_values(i)==inf)
            BEE_paths_values = [BEE_paths_values(1:i-1) BEE_paths_values(i+1:end)];
            BEE_potential_paths = [BEE_potential_paths(:,1:i-1) BEE_potential_paths(:,i+1:end)];
        end
        if(i+1>length(BEE_paths_values)); break; end;
    end

    %wybór i rysowanie najlepszej trasy
	[v index] = min(best_BEE_paths_values);
	if(v<BEE_best_solution_val)
        BEE_best_solution = best_paths(:,index);
        BEE_best_solution_val = v;
	end;


    
    out_best_solution = BEE_best_solution;
    out_best_solution_val = BEE_best_solution_val; 
    
    
    



