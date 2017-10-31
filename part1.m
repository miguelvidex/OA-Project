clear all
close all
load('dataset/dataset_project6_clustering.mat')

%number of elements in dataset
N;
%Input data matrix X
X=[dataset(:,1),dataset(:,2)];
%number of clusters C
C=N_clusters;
%q = 1 implies hard K-means
q=1.5;
%
lambda=10;
%matrix with outliers(initialize it without outliers)
O{1}=zeros(2,N);
%Solutions are saved in U
U{1}=zeros(N,C);
ponto_medio= mean(X);

for i=1:length(X) 
    %Cluster 1
    if X(i,1)>ponto_medio(1) && X(i,2)>ponto_medio(2)
        U{1}(i,1)=1;
        %plot(X(i,1),X(i,2),'r.')
    %Cluster 2    
    elseif X(i,1)<ponto_medio(1) && X(i,2)>ponto_medio(2)
        U{1}(i,2)=1;
        %plot(X(i,1),X(i,2),'b.')
    %Cluster 3       
    elseif X(i,1)>ponto_medio(1) && X(i,2)<ponto_medio(2)
        U{1}(i,3)=1;
        %plot(X(i,1),X(i,2),'g.')
    %Cluster 4
    else   
        U{1}(i,4)=1;
        %plot(X(i,1),X(i,2),'k.')
    end
end

threshold=10^(-6);

M{1}=zeros(2,C);

figure
plot_it(M{1},O{1},X,U{1},N,1)

t=2;
M{t}=update_M(U{t-1},X,O{t-1},q,C);
O{t}=update_O(X,M{t},U{t-1},lambda,q,C,N);
U{t}=update_U(X,M{t},O{t},lambda,q,C,N);

plot_it(M{t},O{t},X,U{t},N,t)

while (norm(M{t}-M{t-1},'fro')/norm(M{t},'fro'))>threshold
   t=t+1;
   M{t}=update_M(U{t-1},X,O{t-1},q,C);
   O{t}=update_O(X,M{t},U{t-1},lambda,q,C,N);
   U{t}=update_U(X,M{t},O{t},lambda,q,C,N);
   plot_it(M{t},O{t},X,U{t},N,t)
end

hold off
%norm of the error between the center of mass that we found and the real ones
error_mass_centers=[norm(M{t}(:,1)-center_1'),norm(M{t}(:,2)-center_2'),norm(M{t}(:,3)-center_3'),norm(M{t}(:,4)-center_4')]

cluster=ones(N,1)*5;
for i=1:N
    if O{t}(:,i)==0
        [~,cluster(i,1)]=max(U{t}(i,:));
    end
end
%number of points that are not int the corrected cluster
errors_clustering=sum(dataset(:,3)-cluster)
