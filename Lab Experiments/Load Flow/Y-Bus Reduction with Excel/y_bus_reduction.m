clc;
clear all;
close all;
A = xlsread('y_bus_reduction');
n=4;
[row colm]=size(A);
z=1./zeros(n);
for i=1:row
    z(A(i,1),A(i,2))=A(i,3)+1j*A(i,4);
    z(A(i,2),A(i,1))=z(A(i,1),A(i,2));   
end
Y=-1./z;
for i=1:n
    Y(i,i)=-sum(Y(i,1:n));
end
fprintf('\n Z Matrix:\n')
disp(z);
fprintf('\n Y Bus Matrix:\n')
disp(Y);
D =Y;
w = length(Y);
n=4;
m=2;
Q= zeros(w);
 for k=1:m
     for s=1:w
         for t=1:w
             Q(s,t)=D(s,t)-(D(s,n)*D(n,t))/D(n,n);
         end
     end
     Q(:,n)=[ ];
     Q(n,:)=[ ];
     D =Q;
      n=n-1;
      w=w-1;
 end
 fprintf('\n Reduced Matrix is:  \n');
 Q


















