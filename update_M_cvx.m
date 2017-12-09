function M=update_M_cvx(U,X,O,q,C)
  
   cvx_begin;
       variable M(2,C);
       minimize(sum(sum(U.*((norm(X-M'-O',2))^2+lambda*norm(O',2)),1),2));
       subject to
           sum(U,2)==1;
           U>=0;
   cvx_end;

end