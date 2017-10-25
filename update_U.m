function U=update_U(X,M,O,lambda,q,C,N)
    U=zeros(N,C);
    %Hard K-means
    if q==1
        %equacao 14
        for i=1:N
            [~,c_min]=min(sqrt(sum((X(i,:)-M'-O(:,i)').^2,2)));
            U(i,c_min)=1;
        end
    %Soft K-means
    else
        %equacao 13
        ;
    end
end