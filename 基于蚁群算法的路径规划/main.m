clc;
clear all;
close all;
addpath alg-pszczeli;
addpath gen;
addpath mrowkowy;



global n size cost_matrix type;
max_iter = 80;
n = 3 %卡车数量
size = 20; %城市数量
global N Cn
Cn = n;
N = size;
type = 1;% 目标函数的类型从0到2  - 参考quality.m

[cost_matrix points] = generate_matrix(size, n);
%%%%%%%%%%%%%%%%%%%%



BEE_routes=[];
BEE_q=[];
BEE_time=[];
bee_init(cost_matrix,n,200,5,3); 


ANT_routes=[];
ANT_q=[];
ANT_time=[];
ant_init(cost_matrix, n, inf,1.6, 20,  10, 0.5, 3,  15,  1,  40, Inf);% 46.3 37.7 37.4 41
%                    Cie,poj,bet,al1,  al2, ro, g1,  g2, g3, pop, popr


GEN_routes=[];
GEN_q=[];
GEN_time=[];
gen_init(100); 




for k=1:max_iter
      
    tic;
    [best_route best_q] = bee_step; 
    BEE_time = [BEE_time toc];
    BEE_routes = [BEE_routes best_route];
    BEE_q = [BEE_q best_q];
    
    show_path( 1, best_route, points, n,0,'ABC最佳路径图');
    set(1,'Position',[0 0 704 772]);
    
    figure(2);
    hold on;
    title('Best solution graph (blue-bee,red-gen,green-ant)');
    xlabel('Iteration');
    ylabel('Quality function');
    plot(BEE_q,'.b');
    set(2,'Position',[721 421 704 354]);
    grid on;
    hold off;
    
    figure(3);
    hold on;
    title('Step time graph / Cumulative time (blue-bee,red-gen,green-ant)');
    xlabel('Iteration');
    ylabel('Time [s]');
    plot(BEE_time,'.b');
    plot(k,sum(BEE_time),'.b');
    set(3,'Position',[718 49 704 284]);
    grid on;
    
    %%
     
    tic;
    best_routes=[];
    best_qs=[];
    %disp('迭代次数')
    iter=k  %外循环迭代的次数
    ANT_k_r=30;%蚂蚁个数？
    for ANT_k = 1:ANT_k_r
        [best_route best_q] = ant_step; 
        best_routes=[best_routes;best_route];
        best_qs=[best_qs;best_q];
    end;
    % BSO算法
    [best_route best_q]=BSO_arg(best_routes,best_qs,ANT_k_r)
    %聚类 -> 每个类中挑出最优解 -> 对每个最优解进行2-opt -> 比较新旧值 -> 输出结果
    
    
    %%
    ANT_time = [ANT_time toc];
%     ANT_routes = [ANT_routes best_route'];
%     ANT_q = [ANT_q best_q];
    if k>1 
        if ANT_q(end)<best_q
            ANT_q = [ANT_q ANT_q(end)];
            ANT_routes = [ANT_routes ANT_routes(:,end)];
        else
            ANT_q = [ANT_q best_q];
            ANT_routes = [ANT_routes best_route'];
        end
    else
        ANT_q = [ANT_q best_q];
        ANT_routes = [ANT_routes best_route'];
    end
        

    
    show_path( 5, best_route', points, n,0,'蚁群算法最佳路径图');
    set(5,'Position',[0 0 704 772]);
    
    figure(2);
    hold on;
    title('Best solution graph (blue-bee,red-gen,green-ant)');
    xlabel('Iteration');
    ylabel('Quality function');
    plot(ANT_q,'.g');
    set(2,'Position',[721 421 704 354]);
    grid on;
    hold off;
    
    figure(3);
    hold on;
    title('Step time graph / Cumulative time (blue-bee,red-gen,green-ant)');
    xlabel('Iteration');
    ylabel('Time [s]');
    plot(ANT_time,'.g');
    plot(k,sum(ANT_time),'.g');
    set(3,'Position',[718 49 704 284]);
    grid on;

    
    
    tic;
    [best_route best_q] = gen_step; 
    GEN_time = [GEN_time toc];
    GEN_routes = [GEN_routes best_route];
    GEN_q = [GEN_q best_q];
    
    
    show_path( 4, best_route', points, n,0,'遗传算法最佳路径图');
    set(4,'Position',[0 0 704 772]);
    
    figure(2);
    hold on;
    title('目标函数对比图 (蓝-ABC,红-GA,绿-ACO)');
    xlabel('迭代次数');
    ylabel('评价函数');
    plot(GEN_q,'.r');
    set(2,'Position',[721 421 704 354]);
    grid on;
    hold off;
    
    figure(7);
    hold on;
    title('迭代次数曲线图)');
    xlabel('迭代次数');
    ylabel('质量函数');
    plot(ANT_q);
    set(2,'Position',[721 421 704 354]);
    grid on;
    hold off;
    
    figure(3);
    hold on;
    title('时间对比图(蓝-ABC,红-GA,绿-ACO)');
    xlabel('迭代次数');
    ylabel('时间 [s]');
    plot(GEN_time,'.r');
    plot(k,sum(GEN_time),'.r');
    set(3,'Position',[718 49 704 284]);
    grid on;


    
    
    
    figure(6);      
    plot(points(:,1),points(:,2),'s');
    title('城市坐标点图');
    xlabel('横坐标');
    ylabel('纵坐标');   
    pause(0.01);
end;

