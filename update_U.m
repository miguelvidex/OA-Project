function U=update_U(X,M,O,lambda,q,C)
    U=zeros(size(X,1),C);
    %Hard K-means
    if lambda==1
        U(:,min(norm(X-M-O)))=1;
    %Soft K-means
    else
        ;
    end
end