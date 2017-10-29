function M=update_M(U_prev,X,O_prev,q,C)
    M=zeros(2,C);
    for c=1:C
        %equacao 9
        M(:,c)=sum((repmat((U_prev(:,c).^q),[1 2]).*(X-O_prev'))/sum(U_prev(:,c).^q));
    end
end