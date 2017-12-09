function U=update_U_ctrs(X,M,O,lambda,q,C,N)

    U=zeros(N,C);
    Num=zeros(1,C);
    Quoc=0;
    %Hard K-means
    if q==1
        %equacao 14
        for i=1:N
            if i==247
                U(i,:)=U(173,:);
            elseif i==263
                U(i,:)=U(133,:);
            else
                aux=sqrt(sum((repmat(X(i,:),[C 1])-M'-repmat(O(:,i)',[C 1])).^2,2));  
                [~,c_min]=min(aux);
                if U(25,c_min)==1 && i==100
                    aux(c_min)=10000;
                    [~,c_min]=min(aux);
                end
                U(i,c_min)=1;
            end
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