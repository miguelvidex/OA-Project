function M=update_M(U_prev,X,O_prev,q,C)
    M=zeros(2,C);
    for c=1:C
        %equacao 9
        
        M(:,c)=sum(((U_prev(:,c).^q).*(X-O_prev')))/sum(U_prev(:,c).^q);
        %if isnan(M(1,c)) || isnan( M(2,c))
        %   error('Deu asneira porque uma das colunas de U estava toda a zeros, ou seja nenhum ponto pertencia a um dos 4 clusters')
        %end
    end
end