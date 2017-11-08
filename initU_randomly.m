function U=initU_randomly(N,C)
    %inicialization of matrix U
    U=zeros(N,C);
    for i=1:N
        U(i,:)=randfixedsum(C,1,1,0,1);
    end
    %U(i,:)=randfixedsum(C,N,1,0,1);
    %U=U';
end