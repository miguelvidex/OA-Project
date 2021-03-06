clear;
close all;
load('dataset/dataset_project6_clustering.mat')
%print flag
print_flag=0;
%Input data matrix X
X=[dataset(:,1),dataset(:,2)];
%number of clusters C
C=N_clusters;
%q = 1 implies hard K-means
q_hard=1;
q_soft=1.5;
cvx_flag=0;
best_lambda_i=[];


%matrix with outliers(initialize it all vectores outliers)
O_init=zeros(2,N);
%Solutions are saved in U (initialize it)
load('Init_variables.mat');

M_init=zeros(2,C);

%threshold to exit the 
threshold=10^(-6);
N_points=50;
n_outliers_hard=zeros(1,N_points);
n_outliers_soft=zeros(1,N_points);
k=1;
linelambda=linspace(2,20,N_points);
for lambda_i=1:N_points
    [M_final_hard{lambda_i}, O_final_hard{lambda_i}, U_final_hard{lambda_i},t_hard(lambda_i)]=Algorithm_1(M_init,O_init,X,U_init,N,C,linelambda(lambda_i),q_hard,threshold,print_flag,cvx_flag);
    n_outliers_hard(1,lambda_i)= sum(O_final_hard{lambda_i}(1,:)~=0 & O_final_hard{lambda_i}(2,:)~=0,2);
    if n_outliers_hard(1,lambda_i)==80
        best_lambda_i=[ best_lambda_i ; lambda_i];
    end
end
disp('Hard K-means done')

for lambda_i=1:N_points
    [M_final_soft{lambda_i}, O_final_soft{lambda_i}, U_final_soft{lambda_i},~]=Algorithm_1(M_init,O_init,X,U_init,N,C,linelambda(lambda_i),q_soft,threshold,print_flag,cvx_flag);
    n_outliers_soft(1,lambda_i)= sum(O_final_soft{lambda_i}(1,:)~=0 & O_final_soft{lambda_i}(2,:)~=0,2);
    
end
disp('Soft K-means done')
figure(13)
plot(linelambda,n_outliers_soft,'.-r')
title('SOFT K-Means')
xlabel('\lambda') % x-axis label
ylabel('Numero de outliers') % y-axis label

figure(11)
plot(linelambda,n_outliers_hard,'.-r')
title('HARD K-Means')
xlabel('\lambda') % x-axis label
ylabel('Numero de outliers') % y-axis label
%---------------------------------------------------
%             ANALYSIS OF THE RESULTS
%---------------------------------------------------

best_lambda_i=best_lambda_i(ceil(length(best_lambda_i)/2))
q=[q_hard q_soft];
lambda_final=linelambda(best_lambda_i)
M={M_final_hard{best_lambda_i} M_final_soft{best_lambda_i}};
O={O_final_hard{best_lambda_i} O_final_soft{best_lambda_i}};
U={U_final_hard{best_lambda_i} U_final_soft{best_lambda_i}};
for i=1:1:2
    %norm of the error between the center of mass that we found and the real ones
    [error_mass_center(1),cluster_i(1)]=min(sqrt(sum((M{i}(:,1)-[center_1',center_2',center_3',center_4']).^2, 1)));
    [error_mass_center(2),cluster_i(2)]=min(sqrt(sum((M{i}(:,2)-[center_1',center_2',center_3',center_4']).^2, 1)));
    [error_mass_center(3),cluster_i(3)]=min(sqrt(sum((M{i}(:,3)-[center_1',center_2',center_3',center_4']).^2, 1)));
    [error_mass_center(4),cluster_i(4)]=min(sqrt(sum((M{i}(:,4)-[center_1',center_2',center_3',center_4']).^2, 1)));

    cluster=ones(N,1)*5;
    for j=1:N
        if O{i}(:,j)==0
            [~,cluster(j,1)]=max(U{i}(j,:));
            cluster(j,1)=cluster_i(cluster(j,1));
        end
    end

    error_mass_center_set{i}=error_mass_center;
    n_outliers_set{i}= sum(O{i}(1,:)~=0 & O{i}(2,:)~=0,2);
    %number of points that are not int the corrected cluster
    errors_clustering_set{i}=length(nonzeros(dataset(:,3)-cluster));
    plot_it(M{i},O{i},X,U{i},N,i)
end

%---------------------------------------------------
%             CVX EVALUATION
%---------------------------------------------------

cvx_flag=1;
[M_CVX, O_CVX, U_CVX,t_cvx]=Algorithm_1(M_init,O_init,X,U_init,N,C,lambda_final,q_hard,threshold,print_flag,cvx_flag);
plot_it(M_CVX,O_CVX,X,U_CVX,N,3);
error_cvx = sum(sum(abs(U_CVX-U{1}),1),2)
n_outliers_cvx=sum(O_CVX(1,:)~=0 & O_CVX(2,:)~=0,2)
improvement = t_hard(best_lambda_i) - t_cvx
