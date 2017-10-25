close all;
clear;

load('dataset_project6_clustering');


plot(dataset(:,1),dataset(:,2),'.');
hold on;
pinic=[mean(dataset(:,1)) mean(dataset(:,2))];
plot(pinic(1),pinic(2),'x');
C = 4;
U = zeros(N,C);

for i=1:N
    if (dataset(i,1) > pinic(1)) && (dataset(i,2) > pinic(2))
        U(i,:) = [1 0 0 0];
    elseif (dataset(i,1) < pinic(1)) && (dataset(i,2) > pinic(2))
end

