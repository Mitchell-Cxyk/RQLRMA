%% Section 4.3: Example 3: Video Processing: Case 1
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
% load('yunlonglake.mat')
load('children.mat')
 %% for comparisom,compute the eigenvector of A^*A only one time. 
            t0=cputime;
            [D,V]=eigQ(timesQ(transQ(A),A));
            t_eigQ=cputime-t0;
    
%% choose k - number of chosen largest singular triplets
TIMEK=[];
PSNRK=[];
SSIMK=[];

for k=1:30
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
    % QEIG
        t0=cputime;
        Sk=diag(sqrt(D(1:k)));
        n=size(A,2)/4;
        Vk=V(:,[1:k,n+1:n+k,2*n+1:2*n+k,3*n+1:3*n+k]);
        Z=zeros(size(Sk));
        Uk=timesQ(timesQ(A,Vk),[inv(Sk),Z,Z,Z]);
        t2=cputime-t0+t_eigQ;
        % low rank approximation
        SQ=[Sk,Z,Z,Z];
        US=timesQ(Uk,SQ);
        A_lr2=timesQ(US,transQ(Vk));
   
    TIMEK=[TIMEK;[t1,t2]];
end

%% Plot the CPU time
figure1 = figure('InvertHardcopy','off','Color',[1 1 1]);

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create multiple lines using matrix input to plot
plot1 = plot(TIMEK,'MarkerSize',8,'LineWidth',3);
set(plot1(1),'DisplayName','lansvdQ','Marker','o','Color',[1 0 1]);
set(plot1(2),'DisplayName','eigQ','Marker','+','Color',[0 0 1]);

% Create xlabel
xlabel('Number of singular triplets (k=1:30)');

% Create ylabel
ylabel('CPU times (seconds)');


box(axes1,'on');
% Set the remaining axes properties
set(axes1,'FontSize',14,'FontWeight','bold');
% Create legend
legend1 = legend(axes1,'show');
set(legend1,'FontSize',16);


%% low-rank approximations
%% for yunlonglake Video
% % % err2norm=[];
% % % errFnorm=[];
% % % A_lr=A_lr1;
% % %     for numf2 =2:2:20
% % %           frame_lrapr=A_lr((numf2-1)*Height+1:numf2*Height,:)/255;
% % %           frame=A((numf2-1)*Height+1:numf2*Height,:)/255;
% % %           err2norm1(numf2)=normQ(frame-frame_lrapr,2)/normQ(frame,2);
% % %           errFnorm1(numf2)=normQ(frame-frame_lrapr,'fro')/normQ(frame,'fro');
% % % 
% % %           im=qm2im(A((numf2-1)*Height+1:numf2*Height,:)/255);
% % %           im_lr=qm2im(frame_lrapr,Width);
% % % 
% % %           PSNRVAL_s1(numf2)=psnr(im_lr, im);
% % %           SSIMVAL_s1(numf2)=ssim(im_lr, im);  
% % %     end
% % %    PSNRK=[PSNRK;PSNRVAL_s1];
% % %    SSIMK=[SSIMK;SSIMVAL_s1];
% % %    err2norm=[err2norm;err2norm1];
% % %    errFnorm=[errFnorm;errFnorm1];
% % % 
% % % 
% % %     A_lr=A_lr2;
% % %     for numf2 =2:2:20% 
% % %           frame_lrapr=A_lr((numf2-1)*Height+1:numf2*Height,:)/255;
% % %           frame=A((numf2-1)*Height+1:numf2*Height,:)/255;
% % %           err2norm2(numf2)=normQ(frame-frame_lrapr,2)/normQ(frame,2);
% % %           errFnorm2(numf2)=normQ(frame-frame_lrapr,'fro')/normQ(frame,'fro');
% % % 
% % %           im=qm2im(A((numf2-1)*Height+1:numf2*Height,:)/255);
% % %           im_lr=qm2im(frame_lrapr,Width);
% % %         
% % %           PSNRVAL_s2(numf2)=psnr(im_lr, im);
% % %           SSIMVAL_s2(numf2)=ssim(im_lr, im);  
% % %     end
% % %   PSNRK=[PSNRK;PSNRVAL_s2];
% % %   SSIMK=[SSIMK;SSIMVAL_s2];
% % %   err2norm=[err2norm;err2norm2];
% % %   errFnorm=[errFnorm;errFnorm2];
% % %     
% % %   PSNRs=PSNRK(:,2:2:20);
% % %   SSIMs=SSIMK(:,2:2:20);
% % %   ResErr2norm=err2norm(:,2:2:20);
% % %   ResErrFnorm=errFnorm(:,2:2:20);
% % % 
% % %   table=[mean(PSNRs');mean(SSIMs');mean(ResErr2norm');mean(ResErrFnorm')]'

%% for Children Video
%% low-rank approximations
err2norm=[];
errFnorm=[];
Height=360;
Width=1280;
A_lr=A_lr1;
    for numf2 =2:2:20
          frame_lrapr=A_lr((numf2-1)*Height+1:numf2*Height,:)/255;
          frame=A((numf2-1)*Height+1:numf2*Height,:)/255;
          err2norm1(numf2)=normQ(frame-frame_lrapr,2)/normQ(frame,2);
          errFnorm1(numf2)=normQ(frame-frame_lrapr,'fro')/normQ(frame,'fro');

          im=qm2im(A((numf2-1)*Height+1:numf2*Height,:)/255);
          im_lr=qm2im(frame_lrapr,Width);

          PSNRVAL_s1(numf2)=psnr(im_lr, im);
          SSIMVAL_s1(numf2)=ssim(im_lr, im);  
    end
   PSNRK=[PSNRK;PSNRVAL_s1];
   SSIMK=[SSIMK;SSIMVAL_s1];
   err2norm=[err2norm;err2norm1];
   errFnorm=[errFnorm;errFnorm1];


    A_lr=A_lr2;
    for numf2 =2:2:20% 
          frame_lrapr=A_lr((numf2-1)*Height+1:numf2*Height,:)/255;
          frame=A((numf2-1)*Height+1:numf2*Height,:)/255;
          err2norm2(numf2)=normQ(frame-frame_lrapr,2)/normQ(frame,2);
          errFnorm2(numf2)=normQ(frame-frame_lrapr,'fro')/normQ(frame,'fro');

          im=qm2im(A((numf2-1)*Height+1:numf2*Height,:)/255);
          im_lr=qm2im(frame_lrapr,Width);
        
          PSNRVAL_s2(numf2)=psnr(im_lr, im);
          SSIMVAL_s2(numf2)=ssim(im_lr, im);  
    end
  PSNRK=[PSNRK;PSNRVAL_s2];
  SSIMK=[SSIMK;SSIMVAL_s2];
  err2norm=[err2norm;err2norm2];
  errFnorm=[errFnorm;errFnorm2];
    
  PSNRs=PSNRK(:,2:2:20);
  SSIMs=SSIMK(:,2:2:20);
  ResErr2norm=err2norm(:,2:2:20);
  ResErrFnorm=errFnorm(:,2:2:20);

  table=[mean(PSNRs');mean(SSIMs');mean(ResErr2norm');mean(ResErrFnorm')]'


