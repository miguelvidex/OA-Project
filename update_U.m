function U=update_U(X,M,O,lambda,q,C,N)
    U=zeros(N,C);
    %Hard K-means
    if lambda==1
        for i=1:N
            [~,c_min]=min(norm(repmat(X(i,:),[C,1])-M'-O(:,i)'));
            U(i,c_min)=1;
        end
    %Soft K-means
    else
        ;
    end
end