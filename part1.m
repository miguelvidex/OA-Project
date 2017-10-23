clear all
close all
load('dataset/dataset_project6_clustering.mat')

%number of elements in dataset
N;
%Input data matrix X
X=[dataset(:,1),dataset(:,2)]
%number of clusters C
C=N_clusters;
%q = 1 implies hard K-means
q=1;
%
lambda=0
%matrix with outliers
O{1}=zeros(2,N)
%Solutions are saved in U
U{1}=zeros(N,C)
ponto_medio= mean(X)

for i=1:length(X) 
    %Cluster 1
    if X(i,1)>ponto_medio(1) && X(i,2)>ponto_medio(2)
        U(i,1)=1
        %plot(X(i,1),X(i,2),'r.')
    %Cluster 2    
    elseif X(i,1)<ponto_medio(1) && X(i,2)>ponto_medio(2)
        U(i,2)=1
        %plot(X(i,1),X(i,2),'b.')
    %Cluster 3       
    elseif X(i,1)<ponto_medio(1) && X(i,2)<ponto_medio(2)
        U(i,3)=1
        %plot(X(i,1),X(i,2),'g.')
    %Cluster 4
    else   
        U(i,4)=1
        %plot(X(i,1),X(i,2),'k.')
    end
end

threshold=10^(-5);

t=2;
M{1}=update_M();
%only to enter on the loop
M{2}=ones(2,C);
while norm(mean(M{t},2)-mean(M{t-1},2))>threshold
   M{t}=update_M(U{t-1},X,O{t-1},q,C);
   O{t}=update_O(X,M{t},U{t-1},lambda,q);
   U{t}=update_U(X,M{t},O{t},lambda,q,C);
end

figure(1)
hold on
plot(X(:,1),X(:,2),'.')
plot(ponto_medio(1),ponto_medio(2),'*')
hold off
