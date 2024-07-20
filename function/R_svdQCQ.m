function [U,S,V]=R_svdQCQ(A)

    nanNum=numel(find(isnan(A)));
    if nanNum>0
        save("Amat","A");
        pause;
    end
[Ur,Sr,Vr]=R_svdQ(A);
% B=A;
A=[A.w,A.y,A.x,A.z];
% sizeB=size(B);
% m=sizeB(1);
% n=sizeB(2);
% k=n;
% [UA,svdA,VA]=R_svdQ(B);
% 
% BR=[B.w,B.y,B.x,B.z];
%     Uk=UA(:,[1:k,m+(1:k),2*m+(1:k),3*m+(1:k)]);
%     Vk=VA(:,[1:k,n+(1:k),2*n+(1:k),3*n+(1:k)]);
%     Sk=svdA(1:k,1:k);
%     Z=zeros(size(Sk));
%     SQ=[Sk,Z,Z,Z];
%     US=timesQ(Uk,SQ);
%     AV=timesQ(BR,Vk);
%     errAV_US2=normQ(AV-US);
%     display(errAV_US2);
% errR=normQ(timesQ(Ur,[Sr,zeros(size(Sr)),zeros(size(Sr)),zeros(size(Sr))])-timesQ(A,Vr));
% display(errR);
usize=size(Ur);
vsize=size(Vr);
k=min(usize(1),vsize(1));
qsize=[usize(2)/4,vsize(2)/4];
Uw=Ur(:,1:k);
Ux=Ur(:,qsize(1)+(1:k));
Uy=Ur(:,2*qsize(1)+(1:k));
Uz=Ur(:,3*qsize(1)+(1:k));
% Uarr=[Uw,Ux,Uy,Uz];
U=quaternion(Uw,Uy,Ux,Uz);

Vw=Vr(:,1:k);
Vx=Vr(:,qsize(2)+1:qsize(2)+k);
Vy=Vr(:,2*qsize(2)+1:2*qsize(2)+k);
Vz=Vr(:,3*qsize(2)+1:3*qsize(2)+k);
% Varr=[Vw,Vx,Vy,Vz];
V=quaternion(Vw,Vy,Vx,Vz);
S=Sr(1:k,1:k);
% Sarr=[S,zeros(size(S)),zeros(size(S)),zeros(size(S))];
% norm(timesQ(Uarr,Sarr)-timesQ(A,Varr))

