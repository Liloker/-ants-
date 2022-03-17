function [best_route,best_q]=BSO_arg(X,distance_ANT,ANT_k_rr)
    % BSO�㷨
    %���� -> ÿ�������������Ž� -> ��ÿ�����Ž����2-opt -> �Ƚ��¾�ֵ -> ������
    %% K-means���ಢ����ÿ�����е����Ž�
    global type n cost_matrix
    K=3; %KֵΪ������Ŀ
    [Idx,C,sumD,D]=kmeans(X,K);
%     X: N*P�����ݾ���,����N��30��·������,pΪһ��·������
%     K: ��ʾ��X����Ϊ���࣬Ϊ����
%     Idx: N*1���������洢����ÿ����ľ�����
%     C: K*P�ľ��󣬴洢����K����������λ��
%     sumD: 1*K�ĺ��������洢����������е���������ĵ����֮��
%     D: N*K�ľ��󣬴洢����ÿ�������������ĵľ���

    %����K����,����ÿ��������Ž�
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
        K_best_route=X(best_route_index,:);%�õ���K�����е�����·������
        K_best_q=distance_ANT(best_route_index);
        best_route4K=[best_route4K;K_best_route];
        best_q4K=[best_q4K;K_best_q];
    end
    disp('ͨ��kmeans���࣬��ÿ����������������·���������')
    best_route4K
    best_q4K
    %% ��ÿ�����Ž����2-opt���������
    opt_routes=[];
    opt_qs=[];
    for kinds=1:K
        %disp('2-opt��תλ��');
        random=randperm(23,2);
        left=min(random)+1;
        right=max(random); %����ѭ���ڲ����Ƕ�ÿ�����ŵĴ���λ�ö���һ���������ⲿ��һ��
        best_route_inK=best_route4K(kinds,:); %best_route_inK�洢best_route4K����һ�У�������д���
        %�����ת����
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
        %��opt��ת���еĴ���
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
    disp('2-opt�����ת�õ����������Լ���Ӧ����')
    opt_routes
    opt_qs
    %% �Ƚ�K-mean��2-opt��������Ž�
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
    disp('��K�����У�ÿһ������Ž�����2-opt�����ȣ����Ž�Ϊ��')
    Temp_route
    disp('ÿ�����е������Ž��ٽ��бȽ�,�õ�best_route �� best_q��')
    best_index=find(Temp_q==min(Temp_q));
    best_route=Temp_route(best_index(1),:)%��������ж�����Ž⣬ֻ��ʾ��һ��
    best_q=min(Temp_q)
    
    