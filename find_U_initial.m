close all
clear all
load('dataset/dataset_project6_clustering.mat')
%print flag
print_flag=0;
%number of elements in dataset
N;
%Input data matrix X
X=[dataset(:,1),dataset(:,2)];
%number of clusters C
C=N_clusters;
%q = 1 implies hard K-means
q_hard=1;
q_soft=1.5;
%
lambda=10;
%matrix with outliers(initialize it without outliers)
O_init=zeros(2,N);
%Solutions are saved in U (initialize it)
%U{1}=initU(X,N,C);
U_init=initU_randomly(N,C);
cvx_flag=0;

%threshold to exit the 
threshold=10^(-3);

M_init=zeros(2,C);

N_points=100;
n_outliers=zeros(1,N_points);
loglambda=logspace(-1,2,N_points);
best_U_indice=1;
for log_lambda_i=1:N_points
    [M_aux, O_aux, U_aux]=Algorithm_1(M_init,O_init,X,U_init,N,C,loglambda(log_lambda_i),q_hard,threshold,print_flag,cvx_flag);
    [M_aux_soft, O_aux_soft, U_aux_soft]=Algorithm_1(M_init,O_init,X,U_init,N,C,loglambda(log_lambda_i),q_soft,threshold,print_flag,cvx_flag);
    if any(isnan(M_aux(:)))
        n_outliers(1,log_lambda_i)=nan;
        n_outliers_soft(1,log_lambda_i)=nan;
    else
        n_outliers(1,log_lambda_i)= sum(O_aux(1,:)~=0 & O_aux(2,:)~=0,2);
        n_outliers_soft(1,log_lambda_i)= sum(O_aux_soft(1,:)~=0 & O_aux_soft(2,:)~=0,2);
        if abs(n_outliers(1,log_lambda_i)-80)< abs(n_outliers(1,best_U_indice)-80)
            best_U = U_aux;
            best_U_indice=log_lambda_i;
        end
    end
end
figure(10)
semilogx(loglambda,n_outliers,'-s')
grid on
title('Numero de outliers no varrimento no \lambda')
xlabel('\lambda') % x-axis label
ylabel('Numero de outliers') % y-axis label
figure(9)
semilogx(loglambda,n_outliers_soft,'-s')
grid on
title('Soft K-means')
xlabel('\lambda') % x-axis label
ylabel('Numero de outliers') % y-axis label

U_init=best_U;
save('Init_variables.mat', 'U_init')
