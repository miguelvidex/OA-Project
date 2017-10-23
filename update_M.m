function M=update_M(U_prev,X,O_prev,q,C)
    M=zeros(2,C);
    for i=1:C
        M(:,i)=sum(((U_prev(:,i)^q).*(X-O_prev))/sum(U_prev(:,i)^q));
    end
end