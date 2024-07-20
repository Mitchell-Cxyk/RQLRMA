function [accuracy,failindex,RegTime]=pca_color_reg_rate(Xrtr,Xgtr,Xbtr,Xrte,Xgte,Xbte,ytr,yte,numsv)
%
% to compute the reg-rate of pca  with k firstly largent eigenvectors.
% accuracy--the rate of reg
% dim-- the number of the images in the training set
% tim--time for recognizing all images in the testing set.

% References:
% Z. Jia, M. K. Ng, and G. -J. Song,``Lanczos Method for Large-Scale
% Quaternion Singular Value Decomposition'',preprint.

%by Zhigang Jia
%on Feb 13 2018



if nargin<9
    %training set  
    [nr d]=size(Xrtr);

    %testing set
    [ne d]=size(Xrte);

%    tic
    t0=cputime;
    [UU0,UUr,UUg,UUb,D,mu] = pca_color (Xrtr,Xgtr,Xbtr);
    t1=cputime-t0;
    %%
    accuracy=[];
    failindex=[];
    
    t=[];
    for k=1:min(size(UUr,2),30)
        t0=cputime;
        U0=UU0(:,1:k);
        Ur=UUr(:,1:k);
        Ug=UUg(:,1:k);
        Ub=UUb(:,1:k);
        [Y0tr,Yrtr,Ygtr,Ybtr] = project_color(U0,Ur,Ug,Ub, Xrtr,Xgtr,Xbtr,mu);
        [Y0te,Yrte,Ygte,Ybte] = project_color(U0,Ur,Ug,Ub, Xrte,Xgte,Xbte,mu);
        P=[Y0tr,Yrtr,Ygtr,Ybtr];
        Q=[Y0te,Yrte,Ygte,Ybte];

        [r,d]=size(Yrte);
        accu=0;%to denote the number of sucesesively images.

        for i=1:r%r--is the number of testing images.
            c= knnclassify(Q(i,:),P,ytr);
            if(c==yte(i))
                accu=accu+1;
            end
        end
        accuracy=[accuracy,accu/r];
        t(k)=cputime-t0;
    end
    RegTime=t+t1;
    
elseif nargin==9
    %training set  
    [nr d]=size(Xrtr);

    %testing set
    [ne d]=size(Xrte);

    t0=cputime;
    [UU0,UUr,UUg,UUb,D,mu]=pca_color(Xrtr,Xgtr,Xbtr);

    %
    accuracy=[];
    failindex=[];

    for k=numsv
        U0=UU0(:,1:k);
        Ur=UUr(:,1:k);
        Ug=UUg(:,1:k);
        Ub=UUb(:,1:k);
        [Y0tr,Yrtr,Ygtr,Ybtr] = project_color (U0,Ur,Ug,Ub, Xrtr,Xgtr,Xbtr, mu);
        [Y0te,Yrte,Ygte,Ybte] = project_color (U0,Ur,Ug,Ub, Xrte,Xgte,Xbte, mu);
        P=[Y0tr,Yrtr,Ygtr,Ybtr];
        Q=[Y0te,Yrte,Ygte,Ybte];

        [r,d]=size(Yrte);
        accu=0; %to denote the number of sucesesively images.

        for i=1:r %r--is the number of testing images.
            c= knnclassify(Q(i,:),P,ytr);
            if(c==yte(i))
                accu=accu+1;
            end
        end
        accuracy=[accuracy,accu/r];
    end
        RegTime=cputime-t0;
end