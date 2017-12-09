function U=initU_randomly_hard(N,C)
    U=zeros(N,C);
    for i=1:N
        U(i,unidrnd(C))=1;
    end

end