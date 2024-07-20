%% Section 4.3: Example 3: Video Processing: Case 2
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

	

%%
close all
clear

%% load data
load('yunlonglake.mat')


%% choose k - number of chosen largest singular triplets

for k=30
    % LANQSVD
        t0=cputime;
        [Uk,Sk,Vk] = lansvdQ_restart(A,k);
        t1=cputime-t0;
        % low rank approximation
        dS=diag(Sk);
        Z=zeros(size(Sk));
        SQ=[Sk,Z,Z,Z];
        US=timesQ(Uk,SQ);
        A_lr1=timesQ(US,transQ(Vk));
end

%% low-rank approximations
PSNRK=[];
SSIMK=[];
A_lr=A_lr1;
m=Height;n=Width;
    for numf2 =2:2:20
          frame_lrapr=A_lr((numf2-1)*Height+1:numf2*Height,:)/255;
          im=qm2im(A((numf2-1)*Height+1:numf2*Height,:)/255);
          im_lr=qm2im(frame_lrapr,Width);
          
%%
if numf2>=2&&numf2<=10
i=numf2/2;
subplot (4 ,5 ,i);
%figure
set (gcf,'Position',[0,0,n,m]);
imshow(im,'border','tight','initialmagnification','fit');
title ( sprintf ('Frame #%i', 2*i));
subplot (4 ,5 ,5+i);
%figure
set (gcf,'Position',[0,0,n,m]);
imshow(im_lr,'border','tight','initialmagnification','fit');
title ( sprintf ('Approximation #%i', 2*i));
elseif numf2>=12&&numf2<=20
i=numf2/2;
subplot (4 ,5 ,5+i);
%figure
set (gcf,'Position',[0,0,n,m]);
imshow(im,'border','tight','initialmagnification','fit');
title ( sprintf ('Frame #%i', 2*i));
subplot (4 ,5 ,10+i);
%figure
set (gcf,'Position',[0,0,n,m]);
imshow(im_lr,'border','tight','initialmagnification','fit');
title ( sprintf ('Approximation #%i', 2*i));
end

          PSNRK=[PSNRK;psnr(im_lr, im)];
          SSIMK=[SSIMK;ssim(im_lr, im)];
    end


 %%
  tabl2=[2:2:20;PSNRK';SSIMK']
  %%