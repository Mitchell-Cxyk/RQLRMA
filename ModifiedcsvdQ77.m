function [U,S,V]=ModifiedcsvdQ77(A,varargin)
%% Based on solving the complex svd of the complex representation of the input matrix A: which we refer to chiA.
%% This idea is not new; we find that it was already observed in the 1988 paper:
% [1] Angelika Bunse-Gerstner, Ralph Byers, and Volker Mehrmann. A quaternion
% QR algorithm. Numer. Math., 55(1):83–9, 1988
%% Although it was not explicitly pointed out there.
%% The first paper we are awared to explicitly describe this method is the 2004 paper:
% [2] Nicolas Le Bihan and J´erˆome Mars. Singular value decomposition of quaternion matrices: A new
% tool for vector-sensor signal processing. Signal Processing,
% 84(7):1177–1199, 2004 
%% It was explicitly pointed out that if chiA = [U_1 U_2] *diag(Sigma, Sigma) * [V_1^*, V_2^*] is a complex SVD of chiA,
%% then from U_1, Sigma, V_1 one can construct the quaternion SVD of A.
%% In our extensive experiments, this method is much faster than the competetors 
%% (and even one or two order of magnitude faster in various modern personal computers!)
%% The reason is obvious: using Matlab's built in function svd in the complex arithmetic 
%% (directly computing the complex svd of chiA by Matlab's svd)  can fully exploit features such as
%% the parallelism and memory managment in modern computing architecture, leading to its efficiency.

%% This method has been implemented as the function csvdQ, 
%% usage: [u,s,v]= csvdQ(A); u,v: (partially) unitary quaternion matrices; s: diagonal matrix with singular values arraged decreasingly on the diagonal

%% Maybe in 99% instances, the above method works very well. However, this method is not always correct. 
%% There are still two severe issues to be addressed:
%% 1) When A is too ill-conditioned, due to rounding errors, the small singular values may not appear exactly twice,
%% and their order may even be disturbed; This has been pointed out in [1];
%% 2) When the quaternion matrix A has duplicated singular values, i.e., Sigma above consists of duplicated singular values.

%% In the above two cases, directly computing the complex SVD of chiA cannot give the correct quaternion SVD for A 
%% (Orthonormality will be lost; reconstruction is not correct)
%% This even happens to the very simple example: if A = U*eye(1,1)*V^* with U,V arbitrary unitary quaternion matrices,
%% then directly solving [uu,ss,vv] = csvdQ(A) give the wrong results: uu,vv not unitary anymore; ||A-uu*ss*vv'|| is also wrong

%% This function aims to address the above two issues,
%% such that even with duplicated singular values or even A is very ill-conditioned,
%% our method can still return correct svd decomposition of A.
%% Roughly speaking, the first step is to still perform csvdQ to chiA, but then, if there exists duplicated singular values or small ones,
%% The key is the following correction steps:
%% we will split each singular-subspace, computing again the correct quaternion singular vectors corresponding to each singular-subspace,
%% and then concat them to form the final left and right orthornormal matrices for A.
%% The details have not been written as a paper, but the related theory for the corrections is described in our manuscript:
% Chao Chang, Yuning Yang, One-Pass Randomized Algorithm with Practical Rangefinder for Large-Scale Quaternion Matrix Approximation,
% https://arxiv.org/abs/2404.14783
%% see section 3.2 of this manuscript for the theoretical background (of course, here we need to split the sinigular subspace which is more complicated) than this paper.

%% If any question or encountering bugs or issues, please contact us:
% Chao Chang, Yuning Yang (yyang@gxu.edu.cn; yuning.yang1207@gmail.com) 
%% If you think that this function is helpful, please give us a star for the github:
% https://github.com/Mitchell-Cxyk/RQLRMA (containing this function ModifiedcsvdQ77)
%% and you can give us a credit by citing
% Chao Chang, Yuning Yang, One-Pass Randomized Algorithm with Practical Rangefinder for Large-Scale Quaternion Matrix Approximation,
% https://arxiv.org/abs/2404.14783

%% Usage:
% input: A: a quaternion matrix (should be the QTFM's quaternion class)
% varargin: 'full' || 'econ' || r; default = 'full'
% 'full' compute a compact svd of A; all the nonzero singular values will
% be included
% 'econ': discard the small singular values < s(1)*1e-13
% r: rank r approximation to A
% output: [U,S,V]: A = U*S*V' is a quaternion SVD of A
if ~isa(A,'quaternion')
if isreal(A)
    A=rowReal2Q(A);
else
    A=rowComplex2Q(A);
end
end



indexList=[];
transflag=0; %indicate if doing adjoint
rk=min(size(A,1),size(A,2));
flag='full'; %default setting is 'full', meaning that the very small singular values will be included
if ~isempty(varargin)
    if isnumeric(varargin{1})
        rk=varargin{1};
    else
        flag=varargin{1};
    end
end
if size(A,1)<size(A,2)
    A=A';
    transflag=1;
end
m=size(A,1);n=size(A,2);
[Uall,Sall,Vall]=svd(Q2cplx(A),'econ');
restFlag=0; % index before the restPart
Sall=diag(Sall); %Uall,Vall are matrices, Sall is a vector.
Uc=(Uall(:,1:2:end));Vc=(Vall(:,1:2:end));S=Sall(1:2:end); %initialization U S V to store output.
endflag=0; %indicate useful part in U S V.
updateFlag=1;
BadIndex=[];
restNum=length(Sall); %initialization rest part length.
while restNum>n-rk
    % throw the small singular value part. If need full U V, input must be
    % 'full'; otherwise  'econ' or 0 can be set to get a partial U V.
    if Sall(restFlag+1)<Sall(1)*1e-10 %if true, it is the final circle
        if strcmp(flag,'full')||rk<n
            index=2*rk-restFlag; %Collectting all rest index
            Vqin=Qc2Q(Vall(:,restFlag+1:restFlag+index));
            Vqin=Vqin*diag(rand(index,1)*0.5+1);
            [Vqin,~,~]=csvdQ(Vqin);
            Vqin=Vqin(:,1:index/2); %Construct rest V
            Vc(:,restFlag/2+1:restFlag/2+index/2)=Q2Qc(Vqin); %update Vc
            Uqin=Qc2Q(Uall(:,restFlag+1:restFlag+index));
            Uqin=Uqin*diag(rand(index,1)*0.5+1);
            [Uqin,~,~]=csvdQ(Uqin);
            Uqin=Uqin(:,1:index/2);%Construct rest U
            Uc(:,restFlag/2+1:restFlag/2+index/2)=Q2Qc(Uqin); %update Uc
            updateFlag=1;%indicate update
            endflag=rk;
            break;
            %full U:m n, S:n V:n n.
        elseif strcmp(flag,'econ') % throw singular values smaller than Sall(1)*1e-13
            endflag=restFlag/2; %throw those.
            rk=endflag;
            break;
        else
            disp('error input! para must be full or econ');
        end
    else
        threshold=GenerateGap(Sall(restFlag+1)); %Compute Gap
        index=find(abs(Sall(restFlag+1:end)-Sall(restFlag+1))<threshold,1,"last");
        index=floor(index/2)*2; %force index to be even
        indexList(end+1)=index;
        if index == 0
            error('threshold of singular values gap too small!')
        end
        %Vin=Vrest(:,1:index);
        if index>2 %Bad index
            updateFlag=1;
            Vqin=Qc2Q(Vall(:,restFlag+1:restFlag+index));
            Vqin=Vqin*diag(rand(index,1)*0.5+1);
            %Vqin=Vqin.*((1:size(Vqin,2))*2+rand(1,index)*0.5);
            [Vqin,~,~]=csvdQ(Vqin);
            vhv=abs(Vqin'*Vqin);
            Vqin=Vqin(:,1:index/2); %Construct Vqin
            BadIndex=[BadIndex,restFlag/2+1:restFlag/2+index/2];
            %Uqin=A*Vqin./Sall(restFlag+1:2:restFlag+index)';
        else    % meanning index = 2, (multiplicity = 2 in the complex domain), a good singular vector 
            updateFlag=0;
        end
    end
    if updateFlag
        Vc(:,restFlag/2+1:restFlag/2+index/2)=Q2Qc(Vqin);%Update Vqin in Vc
        S(restFlag/2+1:restFlag/2+index/2)=Sall(restFlag+1:2:restFlag+index);
    end

    restFlag=restFlag+index;%Update restFlag
    restNum=2*n-restFlag;
    endflag=restFlag/2;
    %----------------------debug orthogonalization--------------
    % restFlag

    % Vtmp=Qc2Q(Vc);
    % index
    %condQU=condQ(U(:,1:endflag))
    % condQV=condQ(Vtmp(:,1:endflag))
    %-----------------------------------------------------------
    %------------------debug norm error--------------
    %disp(['normF:',num2str(normQf(A-U(:,1:endflag)*diag(S(1:endflag))*V(:,1:endflag)'))]);
    %--------------------------------------------
end

V=Qc2Q(Vc);%Compute V from Vc
if ~isempty(BadIndex)%Compute U
    % Ubad=A*V(:,BadIndex)./S(BadIndex)';
    Ubad=A*V(:,BadIndex);
    colNorms = sqrt(sum((Ubad.w.^2+Ubad.x.^2+Ubad.y.^2+Ubad.z.^2), 1));
    Ubad=Ubad./colNorms;
    U=Qc2Q(Uc);
    U(:,BadIndex)=Ubad; 
else
    U=Qc2Q(Uc);
end
if endflag<n%Compute U V S
    S=diag(S(1:endflag));
    U=U(:,1:endflag);
    V=V(:,1:endflag);
else
    S=diag(S);
end
if transflag==1% whether m>n
    tmp=U;
    U=V;
    V=tmp;
end
if endflag>rk
    U=U(:,1:rk);
    V=V(:,1:rk);
    S=S(1:rk,1:rk);
end
end

function gap = GenerateGap(value)
if value<1e-15
    gap=1e-10;
else
    gap=0.5*10^(-8/10*log10(value)-8);
    gap=gap*value;
end
end


