function plot_it(M,O,X,U,N,t)
   hold on
   P=0;
   figure(t);
   hold on
   plot(M(1,:),M(2,:),'ok');
   for i=1:N
       [~,I] = max(U(i,:));
       if O(:,i)~=0
            plot(X(i,1),X(i,2),'.r');
       elseif I == 1 
            plot(X(i,1),X(i,2),'.g');
       elseif I == 2 
            plot(X(i,1),X(i,2),'.m');
       elseif I == 3 
            plot(X(i,1),X(i,2),'.c');
       else
            plot(X(i,1),X(i,2),'.b');
       end
   end
   if t==1
        title('Hard Key means')
   else
       title('Soft Key means')
   end
   pause(P)
   hold off
end