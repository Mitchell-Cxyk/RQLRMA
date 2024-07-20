function Q=complexQR(A)
flag=2;
if flag==1
Y=[A.w;-A.y;-A.x;-A.z];
[Q1,~]=qr(Y,0);
% % Z=Y'*Y;
% % T=chol(Z);
% % Q1=Y/T;
  Q=quaternion(Q1(1:end/4,:),-Q1((end/2+1):(3*end/4),:),-Q1((end/4+1):end/2,:),-Q1((3*end/4+1):end,:));
end
  % Q1=zeros(size(A,1),size(A,2),4);
% for iter=1:4
%     [Q1(:,:,iter),~]=qr(part(A,iter),0);
% end
% Q=quaternion(Q1(:,:,1),Q1(:,:,2),Q1(:,:,3),Q1(:,:,4));
% Y=[A.w,A.x,A.y,A.z];
% [Q1,~]=qr(Y,0);
%  Q=quaternion(Q1(:,1:end/4),Q1(:,(end/4+1):end/2),Q1(:,(end/2+1):(3*end/4)),Q1(:,(3*end/4+1):end));
%[Q1,~]=qr(Y,0);
%Q=quaternion(Q1(1:end/4,:),Q1((end/4+1):end/2,:),-Q1((end/2+1):(3*end/4),:),Q1((3*end/4+1):end,:));
if flag==2
Y=[A.w+i*A.x;-conj(A.y+i*A.z)];
[Q1,~]=qr(Y,0);
Q.w=real(Q1(1:end/2,:));
Q.x=imag(Q1(1:end/2,:));
Q.y=real(-conj(Q1(end/2+1:end,:)));
Q.z=imag(-conj(Q1(end/2+1:end,:)));
Q=quaternion(Q.w,Q.x,Q.y,Q.z);
end
% a0=A.w;a1=A.x;a2=A.y;a3=A.z;
 %Y=REALPM(A.w,A.x,A.y,A.z);
%  Y=[a0 a1 a2 a3;-a1 a0 -a3 a2;-a2 a3 a0 -a1;-a3 -a2 a1 a0];
 %[Q1,~,~]=qr(Y,0);
 %V=quaternion(V1(1:end/4,1:4:end),-V1((end/2+1):3*end/4,1:4:end),-V1((end/4+1):end/2,1:4:end),-V1((3*end/4+1):end,1:4:end));
 
%  S1=sqrt(S1);
  %S=S1(1:4:end,1:4:end);
%  Q1=T*(V1/S1);
 %Q=quaternion(Q1(1:end/4,1:4:end),-Q1((end/2+1):3*end/4,1:4:end),-Q1((end/4+1):end/2,1:4:end),-Q1((3*end/4+1):end,1:4:end));
 %V=quaternion(V1(1:end/4,1:4:end),-V1((end/2+1):3*end/4,1:4:end),-V1((end/4+1):end/2,1:4:end),-V1((3*end/4+1):end,1:4:end));
 %ss=4;
 % 

% Ac = A.w+i*A.x;
% Bc = A.y+i*A.z;
% % Cc = [Ac;-conj(Bc)];
%  Cc=[Ac Bc;-conj(Bc) conj(Ac)];
%  [Uc,~,~] = qr(Cc,0);
% 
% % use the relationship between Cc and A to obtain Uq, Sq, and Vq
% Uq.w = real(Uc(1:end/2,1:2:end));
% Uq.x = imag(Uc(1:end/2,1:2:end));
% Uq.y = real(-conj(Uc(end/2+1:end,1:2:end)));
% Uq.z = imag(-conj(Uc(end/2+1:end,1:2:end)));
% % Uq.w = real(Uc(1:end/2,1:end));
% % Uq.x = imag(Uc(1:end/2,1:end));
% % Uq.y = real(-conj(Uc(end/2+1:end,1:end)));
% % Uq.z = imag(-conj(Uc(end/2+1:end,1:end)));
% % Uq.w = real(Uc(1:end/2,1:2:end));
% % Uq.x = imag(Uc(1:end/2,1:2:end));
% % Uq.y = real(conj(Uc(end/2+1:end,1:2:end)));
% % Uq.z = imag(conj(Uc(end/2+1:end,1:2:end)));
% Q=quaternion(Uq.w,Uq.x,Uq.y,Uq.z);
% 
%  