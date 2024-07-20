%% Section 4.1: Example 1: Principal Component Analysis--case 2
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

	
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear 
% clc



CPU=[];
RES=[];
STORE=[];
%% rand matrix
for m=200:200:5000  % for the seconde case
    n=m*0.1;
%    mySeed = 20;rng(mySeed);
    r=5;A=lowrankQ_randn(m,n,r);
    [A0,A1,A2,A3]=A2A0123(A); 
    A=[A0 A2 A1 A3];
    %% LANQSVD
    k=0.1*n;
    t0=cputime;
    [U,S,V] = lansvdQ_restart(A,k);
    t1=cputime-t0;
    %% test results
    Z=zeros(size(S));
    SQ=[S,Z,Z,Z];
    US=timesQ(U,SQ);
    AV=timesQ(A,V);
    errAV_US1=normQ(AV-US)/normQ(A);
    %% QSVD
    t0=cputime;
    [UA,svdA,VA]=svdQ(A);
    Uk=UA(:,[1:k,m+(1:k),2*m+(1:k),3*m+(1:k)]);
    Vk=VA(:,[1:k,n+(1:k),2*n+(1:k),3*n+(1:k)]);
    Sk=svdA(1:k,1:k);
    t2=cputime-t0;
    %% test results
    Z=zeros(size(Sk));
    SQ=[Sk,Z,Z,Z];
    US=timesQ(Uk,SQ);
    AV=timesQ(A,Vk);
    errAV_US2=normQ(AV-US)/normQ(A);
    %% output
    sizeA=[m,n]
    comtime=[t1,t2]
    comres=[errAV_US1,errAV_US2]
    %% save CPU times and  errors
    CPU=[CPU;[t1,t2]];
    RES=[RES;[errAV_US1,errAV_US2]];
end



%% figure

YMatrix1=CPU;

% Create figure
figure1 = figure('InvertHardcopy','off','Color',[1 1 1]);

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create multiple lines using matrix input to semilogy
semilogy1 = semilogy(YMatrix1,'LineWidth',3);
set(semilogy1(1),'DisplayName','lansvdQ','Marker','o','Color',[1 0 1]);
set(semilogy1(2),'DisplayName','svdQ','Marker','v','Color',[0 0 0]);

% Create xlabel
xlabel('m');

% Create ylabel
ylabel('CPU time');
box(axes1,'on');
% Set the remaining axes properties
set(axes1,'FontSize',14,'FontWeight','bold','XTick',[1,5 10 15 20 25],...
    'XTickLabel',{'200','1000','2000','3000','4000','5000'},'YMinorTick','on',...
    'YScale','log');
% Create legend
legend1 = legend(axes1,'show');
set(legend1,...
     'FontSize',14);

%%
YMatrix1=RES;

% Create figure
figure1 = figure('InvertHardcopy','off','Color',[1 1 1]);

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create multiple lines using matrix input to semilogy
semilogy1 = semilogy(YMatrix1,'LineWidth',3);
set(semilogy1(1),'DisplayName','lansvdQ','Marker','o','Color',[1 0 1]);
set(semilogy1(2),'DisplayName','svdQ','Marker','v','Color',[0 0 0]);

% Create xlabel
xlabel('m');

% Create ylabel
ylabel('Residue');


box(axes1,'on');
% Set the remaining axes properties
set(axes1,'FontSize',14,'FontWeight','bold','XTick',[1,5 10 15 20 25],...
    'XTickLabel',{'200','1000','2000','3000','4000','5000'},'YMinorTick','on',...
    'YScale','log');
% Create legend
legend1 = legend(axes1,'show');
set(legend1,...
  'FontSize',14);



