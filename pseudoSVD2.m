function varargout=pseudoSVD2(A)
% pseudoSVD2 can generate an orthonormal range for A by using complex SVD
% and a correction. It can find the correct range even if A has duplicated
% singular values and if A is very ill-conditioning.

% input: sketch matrix A (tall)
% output: varargout{1}: the range matrix H which is orthonormal
% output: vargargout{2} (optional): flag whether there exists bad part 1: has; 0: doesn't have


AA=Q2cplx(A);
[Ucc,~,~]=svd(AA,0);    % Ucc keeps the range of Chi_AA, which can be explored


%%%%%%%%%%%%%%%%%%%%%%%%
% detect the good and bad parts of Ucc by Ucc'*Ucc, ref. our paper
priH = constrPrimeH(Ucc);   % first construct the H as usual
pHpH = priH'*priH;          % if Ucc is abnormal, then pHpH will not be orth
absHH = abs(pHpH);          % compress to real
nn = vecnorm(absHH);            % compute the magnitude of each column of absHH
idx = nn>1.0000001;          % findout the abnormal columns of H whose magnitude must be larger than 1
% idx is a logical vector
% idx means the abnormal col. in H, then back to Ucc, we must duplicate
% each element of idx.
bad_idx_Ucc = repelem(idx, 2);


%%%%%%%%%%%%%%%%%%%%%%%%
% good part of Ucc

good_idx_Ucc = ~bad_idx_Ucc;    % good index in Ucc， logical

num_col_Ucc = 1: size(Ucc,2);
good_idx_Ucc = num_col_Ucc(good_idx_Ucc);   % transform to real index
good_idx_Ucc=good_idx_Ucc(1:2:end);
Ug=Ucc(:,good_idx_Ucc);
Ugq=cplx2Q([Ug,Qc2Qa(Ug)]);


Uq = []; has_bad_part = 0;
if sum(bad_idx_Ucc) > 0.1
    has_bad_part = 0;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % generating Ub
    % the idea is to use every column of  Ucc(:,badIndex) to generated a
    % quaternion column, and put them together, termed as Ub; Ub has 2t columns, while its column dim=t;
    % thus then apply
    % quaternion svd to Ub to obtain the true range. Of course, before applying
    % svd, randomly scale every column of Ub such that their do not exist
    % singular values with multiplicity larger than one.

    Ub=Ucc(:,bad_idx_Ucc);

    S=rand(1,size(Ub,2))+1;


    % base = linspace(1, 10, size(Ub,2));  % 生成n个等间距的数值
    % perturbation = 0.5 * rand(1, size(Ub,2)) - 0.25;  % 生成随机扰动，范围约为-0.25到+0.25
    % S = abs(base + perturbation);  % 将扰动添加到基线数值上

    Ub=Ub.*S;

    [Uq,~,~]=csvdQ(Qc2Q(Ub));

    Uq = Uq(:,1:size(Uq,2)/2);

    % end of generating Ub
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end


varargout{1}=[Ugq,Uq];
varargout{2}=has_bad_part;  % flag whether there exists bad part 1: has; 0: doesn't have

end


function priH = constrPrimeH(Ucc)

w = real(Ucc(1:end/2,1:2:end));
x = imag(Ucc(1:end/2,1:2:end));
y = real(-conj(Ucc(end/2+1:end,1:2:end)));
z = imag(-conj(Ucc(end/2+1:end,1:2:end)));
% Uq.w = real(Uc(1:end/2,1:2:end));
% Uq.x = imag(Uc(1:end/2,1:2:end));
% Uq.y = real(conj(Uc(end/2+1:end,1:2:end)));
% Uq.z = imag(conj(Uc(end/2+1:end,1:2:end)));
priH=quaternion(w,x,y,z);

end
