function [M_final, O_final, U_final,t]=Algorithm_1(M_init,O_init,X,U_init,N,C,lambda,q,threshold,print_flag,cvx_flag)

    if nargin < 11
      print_flag = 1;
    end
    if print_flag==1
        figure
        plot_it(M_init,O_init,X,U_init,N,1);
    end
    t=2;
    M{t}=update_M(U_init,X,O_init,q,C);
    O{t}=update_O(X,M{t},U_init,lambda,q,C,N);
    U{t}=update_U(X,M{t},O{t},lambda,q,C,N);
    
%     U_cvx{t}=update_U_cvx(X,M{t},O{t},lambda,C,N);
%     sum(sum(U{t}-update_U_cvx(X,M{t},O{t},lambda,C,N),1),2)
    
    if print_flag==1
        plot_it(M{t},O{t},X,U{t},N,t)
    end
    M{t-1}=M_init;
    if cvx_flag ==1
        while (norm(M{t}-M{t-1},'fro')/norm(M{t},'fro'))>threshold
            t=t+1;
            M{t}=update_M(U{t-1},X,O{t-1},q,C);
            O{t}=update_O(X,M{t},U{t-1},lambda,q,C,N);
            U{t}=update_U_cvx(X,M{t},O{t},lambda,C,N);
        end
    else
        while (norm(M{t}-M{t-1},'fro')/norm(M{t},'fro'))>threshold
            t=t+1;
            M{t}=update_M(U{t-1},X,O{t-1},q,C);
            O{t}=update_O(X,M{t},U{t-1},lambda,q,C,N);
            U{t}=update_U(X,M{t},O{t},lambda,q,C,N);
            if print_flag==1
                plot_it(M{t},O{t},X,U{t},N,t)
            end
        end
    end
    M_final=M{t};
    O_final=O{t};
    U_final=U{t};
    if q==1
        figure(12)
    else
        figure(14)
    end
    hold on
    cor=rand(1,3);
    for i=1:t
        plot(M{1,i}(1,:),M{1,i}(2,:),'.','color',cor)
    end
    title(['Actualizacao dos centros de massa para diferentes valores de \lambda para q=' num2str(q)])
    xlabel('x') % x-axis label
    ylabel('y') % y-axis label
    
    fprintf('lambda:%f number of iterations:%d \n',lambda,(t-1))
    if print_flag==1
        hold off
    end
end