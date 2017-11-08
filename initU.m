function U=initU(X,N,C)
    
    U=zeros(N,C);
    ponto_medio= mean(X);
    %inicialization of matrix U
    for i=1:N
        %Cluster 1
        if X(i,1)>ponto_medio(1) && X(i,2)>ponto_medio(2)
            U(i,1)=1;
        %Cluster 2    
        elseif X(i,1)<ponto_medio(1) && X(i,2)>ponto_medio(2)
            U(i,2)=1;
        %Cluster 3       
        elseif X(i,1)>ponto_medio(1) && X(i,2)<ponto_medio(2)
            U(i,3)=1;
        %Cluster 4
        else   
            U(i,4)=1;
        end
    end
end