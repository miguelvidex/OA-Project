function plot_it(M,O,X,U,N,t)
   clf
   hold on
   P=0;
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
   title(['t = ' num2str(t)])
   pause(P)
end