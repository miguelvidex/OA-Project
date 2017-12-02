function U=update_U_cvx(X,M,O,lambda,C,N)

   OBJ=size(N,C);
   for i=1:N
        for j=1:C
            OBJ(i,j)=norm(X(i,:)-M(:,j)'-O(:,i)',2)+lambda*norm(O(:,i)',2);
        end
   end
   
   cvx_begin;
       variable U(N,C);
       minimize(sum(sum(U.*OBJ,1),2));
       subject to
           sum(U,2)==1;
           U>=0;
   cvx_end;

end