function U=update_U_cvx(X,M,O,lambda,C,N)

   OBJ=size(N,C);
   for i=1:N
        for j=1:C
            OBJ(i,j)=(norm(X(i,:)-M(:,j)'-O(:,i)',2))^2 + lambda*norm(O(:,i)',2);
        end
   end
   cvx_begin;
       variable U(N,C)  nonnegative ;
       minimize(sum(sum(U.*OBJ,1),2));
       subject to
           sum(U,2)==ones(N,1);
           %------Extra constraints -------
           U(173,:)-U(247,:)==zeros(1,C);
           U(133,:)-U(267,:)==zeros(1,C);
           norm(U(25,:)+U(100,:),Inf)<=1;
    cvx_end;
end