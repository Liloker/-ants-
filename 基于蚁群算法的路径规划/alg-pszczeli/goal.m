function g=goal(r,n,size,cost_matrix)

 g = quality(r);

% OBSOLETED
% %Funkcja celu
% %   r - wektor wejsciowy
% %   n - liczba ciezarowek
% %   size - rozmiar miasta
% %   cost_matrix - macierz kosztow
% 
% %typ funkcji celu
% type = 2;
% 
% %1. Najprostrza funkcja celu - suma kosztów
% if(type==0)
%     g = 0;
%     r=r';
%     for i=1:size+n-2
%        g = g + cost_matrix(r(i),r(i+1));        
%     end
%     g = g+cost_matrix(r(end),1);
% end;
% 
% %2. Narastaj¹ca funkcja celu dla coraz d³u¿szych tras - kara za zbyt d³ugi
% %czas
% if(type==1)
%     g = 0;
%     r=r';
%     
%     for i=1:size+n-2
%         if (r(i)<=n); punish = 0; end;
%         punish = punish +1;
%         g = g + punish*cost_matrix(r(i),r(i+1));        
%     end
%     g = g+cost_matrix(r(end),1);    
% end;
%     
% %3. Ograniczenie ³adownoœci do sta³ej wartoœci - po przekroczeniu
% %³adownoœci nie ma mo¿liwoœci innej ni¿ powrót
% if(type==2)
%     g = 0;
%     r=r';
%     moves_count = 0;
%     max_moves = 20;
%     for i=1:size+n-2
%         if (r(i)<=n); moves_count = 0; end;
%         moves_count = moves_count +1;
%         if( moves_count >= max_moves)
%             g = g + cost_matrix(r(i),r(i+1)) + inf;    
%         else
%             g = g + cost_matrix(r(i),r(i+1));    
%         end;
%     end
%     g = g+cost_matrix(r(end),1);  
% end;
