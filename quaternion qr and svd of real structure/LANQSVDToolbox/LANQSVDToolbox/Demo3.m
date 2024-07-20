%% Section 4.2: Example 2: Face Recognition
% in paper:
% Z. Jia, M. K. Ng, and G. -J. Song,``Lanczos Method for Large-Scale
% Quaternion Singular Value Decomposition'',preprint.

%on Feb 13 2018

%  Contact information
% _________________________
% 
%   If there is any suggestion or comment, please feel free to contact the following authors:
%   
% 	Zhigang Jia:  School of Mathematics and Statistics, Jiangsu Normal University,
%                          Xuzhou, China (zhgjia@jsnu.edu.cn) 
% 
% 	Michael K. Ng: Centre for Mathematical Imaging and Vision and Department of Mathematics, 
% 			Hong Kong Baptist University (mng@math.hkbu.edu.hk)

%% imread color face images
clear 
close all
clc

load('Georgia_Tech_face_database.mat');
 %%  output the first person--cropped
M=15;
P1=cell(1,M);
for k=1:M
    P1{k}(:,:,1)=reshape(Xr(k,:)/255,height,width); %R
    P1{k}(:,:,2)=reshape(Xg(k,:)/255,height,width);  %G
    P1{k}(:,:,3)=reshape(Xb(k,:)/255,height,width);  %B
end      
figure ('NumberTitle','off','Name','Person1 (AT&T Facedatabase )'); 
hold on;
for i=1: min (15 ,M)
    subplot (3 ,5 ,i);
    imshow ( P1{i} );
    title ( sprintf ('Person1 #%i', i));
end
%%
y=ones(50*15,1);
for i=1:50
    y(15*(i-1)+1:15*i)=i;
end
uy=unique(y); 
n=length(y); % the number of images
d=width*height; % the size of images   width-by-height

%% training set and testing set
%training
tr=10;
Xrtr=[];
Xgtr=[];
Xbtr=[];
ytr=[];
% testing
te=15-tr;
Xrte=[];
Xgte=[];
Xbte=[];
yte=[];
for i=1:50
    Xrtr=[Xrtr;Xr(15*(i-1)+1:15*(i-1)+tr,:)];
    Xgtr=[Xgtr;Xg(15*(i-1)+1:15*(i-1)+tr,:)];
    Xbtr=[Xbtr;Xb(15*(i-1)+1:15*(i-1)+tr,:)];
    ytr=[ytr;y(15*(i-1)+1:15*(i-1)+tr)];
    
    Xrte=[Xrte;Xr(15*i-te+1:15*i,:)];
    Xgte=[Xgte;Xg(15*i-te+1:15*i,:)];
    Xbte=[Xbte;Xb(15*i-te+1:15*i,:)];
    yte=[yte;y(15*i-te+1:15*i)];
end
%% face reg rate
% QSVD
accuracy_c=[];
failindex_c=[];
RegTime_c=[];
for numsv=1:30;
    [accuracy,~,RegTime]=pca_color_reg_rate(Xrtr,Xgtr,Xbtr,Xrte,Xgte,Xbte,ytr,yte,numsv);
    accuracy_c=[accuracy_c,accuracy];
    RegTime_c=[RegTime_c,RegTime];
end
% LANQSVD
accuracy_c_lansvdQ=[];
failindex_c_lansvdQ=[];
RegTime_c_lansvdQ=[];
for numsv=1:30;
    [accuracy,~,RegTime]=pca_color_reg_rate_lansvdQ(Xrtr,Xgtr,Xbtr,Xrte,Xgte,Xbte,ytr,yte,numsv);
    accuracy_c_lansvdQ=[accuracy_c_lansvdQ,accuracy];
    RegTime_c_lansvdQ=[RegTime_c_lansvdQ,RegTime];
end
%% figure
YMatrix1=[accuracy_c',accuracy_c_lansvdQ'];
createfigure4(YMatrix1)
%%
YMatrix2=[ RegTime_c', RegTime_c_lansvdQ'];
createfigure5(YMatrix2)





