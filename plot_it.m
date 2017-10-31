function plot_it(M,O,X,U,N,t)
   %time that you want between iterations
   clf
   hold on
   P=0;
   m_plot=plot(M(1,:),M(2,:),'ok');
   for i=1:N
       
       if O(:,i)~=0
            plot(X(i,1),X(i,2),'.r');
       elseif U(i,1)== 1 
            plot(X(i,1),X(i,2),'.g');
       elseif U(i,2)== 1 
            plot(X(i,1),X(i,2),'.m');
       elseif U(i,3)== 1 
            plot(X(i,1),X(i,2),'.c');
       else
            plot(X(i,1),X(i,2),'.b');
       end
   end
   title(['t = ' num2str(t)])
   pause(P)
end