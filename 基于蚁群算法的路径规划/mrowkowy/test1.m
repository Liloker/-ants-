clear all;
%读入数据
load mac_M4.mat M4;

global n size cost_matrix type;
n = 4;
size = 6;
cost_matrix = M4;%代价矩阵
type = 0;

ant_init(M4, 4, 5, 0.3, 0.5, 4.0, 0.2, 1, 0.6, 1, 15, 2);

naj = 0;
hold on;
i=1;
x = [];  
y = [];

while ~isempty(naj)
   [rozw, naj] = ant_step;
   x = [x; i];
   y = [y; naj];
   i = i + 1;
end

plot(x(1:end-1),y)
