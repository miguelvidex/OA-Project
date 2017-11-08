function [M_final, O_final, U_final]=Algorithm_1(M_init,O_init,X,U_init,N,C,lambda,q,threshold,print_flag)
    if nargin < 10
      print_flag = 1;
    end
    if print_flag==1
        figure
        plot_it(M_init,O_init,X,U_init,N,1)
    end
    t=2;
    M{t}=update_M(U_init,X,O_init,q,C);
    O{t}=update_O(X,M{t},U_init,lambda,q,C,N);
    U{t}=update_U(X,M{t},O{t},lambda,q,C,N);
    if print_flag==1
        plot_it(M{t},O{t},X,U{t},N,t)
    end
    M{t-1}=M_init;
    while (norm(M{t}-M{t-1},'fro')/norm(M{t},'fro'))>threshold
       t=t+1;
       M{t}=update_M(U{t-1},X,O{t-1},q,C);
       O{t}=update_O(X,M{t},U{t-1},lambda,q,C,N);
       U{t}=update_U(X,M{t},O{t},lambda,q,C,N);
       if print_flag==1
        plot_it(M{t},O{t},X,U{t},N,t)
       end
    end
    
    M_final=M{t};
    O_final=O{t};
    U_final=U{t};
    if print_flag==1
        hold off
    end
end