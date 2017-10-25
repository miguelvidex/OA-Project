function O=update_O(X,M,U_prev,lambda,q,C,N)
    O=zeros(2,N);
    r=zeros(2,N);
    for i=1:N
        %equacao 12
        D=zeros(1,C)
        N=
        for c=1:C
            D=D+U_prev(i,:).^q
            N=N+(U_prev(i,:).^q)*(X(i,:)-M')
            %r(i,:)=sum((U_prev(i,:).^q).*(X(i,:)-M'),2)/sum(U_prev(i,:).^q,2);
        end
        r=N/D
        %equacao 11
        O(:,i)=r(:,i)*(1-lambda/(2*norm(r(i,:))));
    end
end