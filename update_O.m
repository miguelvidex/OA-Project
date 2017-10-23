function O=update_O(X,M,U_prev,lambda,q,C,N)
    O=zeros(2,N);
    r=zeros(2,N);
    for i=1:N
        %equacao 12
        for c=1:C
            D=U_prev(i,:).^q
            N=(U_prev(i,:).^q)*(X(i,:)-M')
            %r(i,:)=sum((U_prev(i,:).^q).*(X(i,:)-M'),2)/sum(U_prev(i,:).^q,2);
        end
        r=sum(N,2)/sum(D,2)
        %equacao 11
        O(i,:)=r(i,:)*(1-lambda/(2*norm(r(i,:))));
    end
end