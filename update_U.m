function U=update_U(X,M,O,lambda,q,C,N)

    U=zeros(N,C);
    Num=zeros(1,C);
    Quoc=0;
    %Hard K-means
    if q==1
        %equacao 14
        for i=1:N
            [~,c_min]=min(sqrt(sum((repmat(X(i,:),[C 1])-M'-repmat(O(:,i)',[C 1])).^2,2)));
            U(i,c_min)=1;
        end
    %Soft K-means
    else
        %equacao 13
        for i=1:N
            for c=1:C
                for cd=1:C
                    Num(cd) = (norm(X(i,:)-M(:,cd)'-O(:,i)',2))^2 + lambda*norm(O(:,i)',2);
                    Quoc = Quoc + (Num(c)/Num(cd))^(1/(q-1));
                end
                U(i,c) = Quoc^(-1);
                Quoc=0;
            end
        end
    end
end