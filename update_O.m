function O=update_O(X,M,U_prev,lambda,q)
    O=zeros(2,N);
    r=zeros(2,n);
    for i=1:size(X,1)
        r(i,:)=sum(((U_prev(:,i)^q).*(X-M))/sum(U_prev(:,i)^q,2),2);
        O(i,:)=r(i,:).*(1-lambda/(2*norm(r(i,:))));
    end
end