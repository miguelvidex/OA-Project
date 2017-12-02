function O=update_O(X,M,U_prev,lambda,q,C,N)
    O=zeros(2,N);
    r=zeros(2,N);
    Num=zeros(2,1);
    for i=1:N
        %equacao 12
        Den=sum(U_prev(i,:).^q);
        for c=1:C
            Num=Num+(U_prev(i,c).^q)*(X(i,:)'-M(:,c));
        end
        %r(i,:)=sum((U_prev(i,:).^q).*(X(i,:)-M'),2)/sum(U_prev(i,:).^q,2);
        r(:,i)= Num/Den;
        %equacao 11
        O(:,i)=r(:,i)*max((1-lambda/(2*norm(r(:,i)))),0);
        Num=[0;0];
    end
end