function [M_final, O_final, U_final,U_final_cvx,t,k]=Algorithm_1_joint(M_init,O_init,X,U_init,N,C,lambda,q,threshold,print_flag)
    if nargin < 10
        print_flag = 1;
    end
    if print_flag==1
        figure
        plot_it(M_init,O_init,X,U_init,N,1)
    end
    
    % Avaliadores de rapidez de convergência
    t=2;
    k=2;
    
    % Inicialização
    M{t}=update_M(U_init,X,O_init,q,C);
    O{t}=update_O(X,M{t},U_init,lambda,q,C,N);
    M_cvx{k}=M{t};
    O_cvx{k}=O{t};
    U{t}=update_U(X,M{t},O{t},lambda,q,C,N);
    if q==1
        U_cvx{k}=update_U_cvx(X,M_cvx{k},O_cvx{k},lambda,C,N);
    end
    %     sum(sum(U{t}-update_U_cvx(X,M{t},O{t},lambda,C,N),1),2)
    
    if print_flag==1
        plot_it(M{t},O{t},X,U{t},N,t)
    end
    M{t-1}=M_init;
    M_cvx{k-1}=M{t-1};
    
    while (norm(M{t}-M{t-1},'fro')/norm(M{t},'fro'))>threshold
        t=t+1;
        M{t}=update_M(U{t-1},X,O{t-1},q,C);
        O{t}=update_O(X,M{t},U{t-1},lambda,q,C,N);
        U{t}=update_U(X,M{t},O{t},lambda,q,C,N);
%         if q==1
%             U_cvx{t}=update_U_cvx(X,M{t},O{t},lambda,C,N);
%         end
        if print_flag==1
            plot_it(M{t},O{t},X,U{t},N,t)
        end
    end
    
    if q==1
        while (norm(M_cvx{k}-M_cvx{k-1},'fro')/norm(M_cvx{k},'fro'))>threshold
            k=k+1;
            M_cvx{k}=update_M(U_cvx{k-1},X,O_cvx{k-1},q,C);
            O_cvx{k}=update_O(X,M_cvx{k},U_cvx{k-1},lambda,q,C,N);
            U_cvx{k}=update_U_cvx(X,M_cvx{k},O_cvx{k},lambda,C,N);
        end  
    end

    M_final=M{t};
    O_final=O{t};
    U_final=U{t};
    if q==1
        U_final_cvx=U_cvx{k};
    else
        U_final_cvx=U_final;
        k=0;
    end

    if print_flag==1
        hold off
    end
end