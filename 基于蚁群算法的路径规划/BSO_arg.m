function [best_route,best_q]=BSO_arg(X,distance_ANT,ANT_k_rr)
    % BSO算法
    %聚类 -> 每个类中挑出最优解 -> 对每个最优解进行2-opt -> 比较新旧值 -> 输出结果
    %% K-means聚类并挑出每个类中的最优解
    global type n cost_matrix
    K=3; %K值为聚类数目
    [Idx,C,sumD,D]=kmeans(X,K);
%     X: N*P的数据矩阵,这里N是30组路径序列,p为一组路径序列
%     K: 表示将X划分为几类，为整数
%     Idx: N*1的向量，存储的是每个点的聚类标号
%     C: K*P的矩阵，存储的是K个聚类质心位置
%     sumD: 1*K的和向量，存储的是类间所有点与该类质心点距离之和
%     D: N*K的矩阵，存储的是每个点与所有质心的距离

    %对于K个类,挑出每个类的最优解
    best_route4K=[];
    best_q4K=[];
    for categories=1:K
        K_min=D(1,categories);
        best_route_index=1;
        for route=1:ANT_k_rr
            if D(route,categories)<K_min
                K_min=route;
                best_route_index=route;
            end
        end
        K_best_route=X(best_route_index,:);%得到第K个类中的最优路径序列
        K_best_q=distance_ANT(best_route_index);
        best_route4K=[best_route4K;K_best_route];
        best_q4K=[best_q4K;K_best_q];
    end
    disp('通过kmeans聚类，从每个类中挑出的最优路径及其代价')
    best_route4K
    best_q4K
    %% 对每个最优解进行2-opt并求其代价
    opt_routes=[];
    opt_qs=[];
    for kinds=1:K
        %disp('2-opt反转位置');
        random=randperm(23,2);
        left=min(random)+1;
        right=max(random); %放在循环内部就是对每类最优的打乱位置都不一样，放在外部就一样
        best_route_inK=best_route4K(kinds,:); %best_route_inK存储best_route4K其中一行，方便进行处理
        %随机反转序列
%         if left==1 && right==length(best_route_inK)
%             opt_route=fliplr(best_route_inK(left:right));
%         end
%         if left==1 && right~=length(best_route_inK)
%             opt_route=[fliplr(best_route_inK(left:right)),best_route_inK(right+1:length(best_route_inK))];
%         end
        if left~=1 && right==length(best_route_inK)
            opt_route=[best_route_inK(1:left-1),fliplr(best_route_inK(left:right))];
        end
        if left~=1 && right~=length(best_route_inK)
            opt_route=[best_route_inK(1:left-1),fliplr(best_route_inK(left:right)),best_route_inK(right+1:length(best_route_inK))];
        end
        opt_routes=[opt_routes;opt_route];
        %----------------------------------------------------
        %求opt逆转序列的代价
        %syms punishs;
        if(type==1)
            g = 0;
            opt_route_r=opt_route';
            for i=1:(length(opt_route_r)-1)
                if (opt_route_r(i)<=n)
                    punishs= 0; 
                end;
                punishs = punishs + 1;
                g = g + punishs*cost_matrix(opt_route_r(i),opt_route_r(i+1));    
                punishs;
            end
            g = g+cost_matrix(opt_route_r(end),1);    
        end;
        opt_q=g;
        %opt_q=quality(opt_route);
        opt_qs=[opt_qs;opt_q];
        %-----------------------------------------------------
    end
    disp('2-opt随机反转得到的新序列以及对应代价')
    opt_routes
    opt_qs
    %% 比较K-mean与2-opt并输出最优解
    Temp_route=[];Temp_q=[];
    for cpr=1:K
        if best_q4K(cpr)<=opt_qs(cpr)
            Temp_route(cpr,:)=best_route4K(cpr,:);
            Temp_q(cpr)=best_q4K(cpr);
        else
            Temp_route(cpr,:)=opt_routes(cpr,:);
            Temp_q(cpr)=opt_qs(cpr);
        end
    end
    disp('在K个类中，每一类的最优解与其2-opt结果相比，最优解为：')
    Temp_route
    disp('每个类中的最终优解再进行比较,得到best_route 和 best_q：')
    best_index=find(Temp_q==min(Temp_q));
    best_route=Temp_route(best_index(1),:)%这里如果有多个最优解，只显示第一个
    best_q=min(Temp_q)
    
    