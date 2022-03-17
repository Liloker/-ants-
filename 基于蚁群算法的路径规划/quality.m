function g=quality(r)
%Funkcja celu
%   r - 输入向量
%   n - 卡车数量
%   size - 城市大小
%   cost_matrix - 成本矩阵
%   type - typ funkcji celu

global n size cost_matrix type;

%1. 最简单的目标函数 - 总和成本体
if(type==0)
    g = 0;
    r=r';
    for i=1:(length(r)-1)
       g = g + cost_matrix(r(i),r(i+1));        
    end
    g = g+cost_matrix(r(end),1);
end;

%2. 增加目的地的功能以延续长路线 - 罚款时间过长
%czas
if(type==1)
    g = 0;
    r=r';
    %sym punish;
    for i=1:(length(r)-1)
        if (r(i)<=n)
            punish = 0; 
        end;
        punish = punish +1;
        g = g + punish*cost_matrix(r(i),r(i+1));    
        %punish;
    end
    g = g+cost_matrix(r(end),1);    
end;
    
%3.超过
if(type==2)
    g = 0;
    r=r';
    moves_count = 0;
    max_moves = 20;
    for i=1:(length(r)-1)
        if (r(i)<=n); moves_count = 0; end;
        moves_count = moves_count +1;
        if( moves_count >= max_moves)
            g = g + cost_matrix(r(i),r(i+1)) + inf;    
        else
            g = g + cost_matrix(r(i),r(i+1));    
        end;
    end
    g = g+cost_matrix(r(end),1);  
end;
