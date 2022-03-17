function g=quality(r)
%Funkcja celu
%   r - ��������
%   n - ��������
%   size - ���д�С
%   cost_matrix - �ɱ�����
%   type - typ funkcji celu

global n size cost_matrix type;

%1. ��򵥵�Ŀ�꺯�� - �ܺͳɱ���
if(type==0)
    g = 0;
    r=r';
    for i=1:(length(r)-1)
       g = g + cost_matrix(r(i),r(i+1));        
    end
    g = g+cost_matrix(r(end),1);
end;

%2. ����Ŀ�ĵصĹ�����������·�� - ����ʱ�����
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
    
%3.����
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
