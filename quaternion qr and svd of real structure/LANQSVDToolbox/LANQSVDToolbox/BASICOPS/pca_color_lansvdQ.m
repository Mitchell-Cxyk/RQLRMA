function [U0,Ur,Ug,Ub,D,mu] = pca_color_lansvdQ (Xr,Xg,Xb,numsv)
% function [U0,Ur,Ug,Ub,D,mu] = pca_color_lansvdQ (Xr,Xg,Xb,numsv). To compute the pca by quaternionic computation using structure-preserving
% methods.
%Input:
%Xr--red color imformation
%Xg--green color imformation
%Xb--blue color imformation
%y-- the labels of images
%k-- (1<=k<=n) the number of the chosen principle eigenfaces or eigenvectors
%

%Output
%U=[U0,Ug,Ur,Ub]--the procjection matrix
%D--the eigenvalues
%mu --the mean of color faces

% References:
% Z. Jia, M. K. Ng, and G. -J. Song,``Lanczos Method for Large-Scale
% Quaternion Singular Value Decomposition'',preprint.

%by Zhigang Jia
%on Feb 13 2018
 %%   
    [n , d] = size(Xr);
    mu=[];
    mu(:,:,1) =mean(Xr);
    mu(:,:,2) =mean(Xg);
    mu(:,:,3) =mean(Xb);
 
%
    Xr = Xr - repmat (mean(Xr),n,1);
    Xg = Xg - repmat (mean(Xg),n,1);
    Xb = Xb - repmat (mean(Xb),n,1);
    
%
    X0=zeros(n,d);
    [~,S,U]=lansvdQ_restart([X0,Xg,Xr,Xb],numsv);
        [~,uc]=size(U);       
        U0=U(:,1:uc/4);
        Ur=U(:,uc/2+1:3*uc/4);
        Ug=U(:,uc/4+1:2*uc/4);
        Ub=U(:,3*uc/4+1:end);  

        for k=1:uc/4
            nmu=norm([U0(:,k);Ur(:,k);Ug(:,k);Ub(:,k)]);
            
            U0(:,k)= U0(:,k)/nmu;
            Ur(:,k)= Ur(:,k)/nmu;
            Ug(:,k)= Ug(:,k)/nmu;
            Ub(:,k)= Ub(:,k)/nmu;
        end
        D=S'*S;
end
