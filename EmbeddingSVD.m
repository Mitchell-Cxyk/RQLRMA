function H=EmbeddingSVD(A,flag)
% a randomized rangefinder, the range is still preserved, while the 
% condition number can be randomized in (1+delta)/(1-delta)
%
% inspired by FAST & ACCURATE RANDOMIZED ALGORITHMS FOR LINEAR SYSTEMS AND
% EIGENVALUE PROBLEMS Def. 2.1 and Sect. 2.2 use svdQ to replace qr as qr is
% slow in quaternion case.
% A: n*d let s = 2d
S=randq(size(A,2)*2,size(A,1));
SA = S*A;

if flag==1
 %SA = randq(size(A,2)*2,size(A,1))*A;   % S = randq(s,n); SA: s*d=2d*d
 [~,Sigma,V] = svdQ(SA);

 H = A*V./diag(Sigma)';
elseif flag==2
    [~,R]=MGSQqr(SA);
    H=QLEQL(A,R);
elseif flag==3
    U=pseudoSVD(SA);
    H=QLEQ(S,U);
elseif flag==4
    U=pseudoSVD1(SA);
    H=QLEQ(S,U);
elseif flag==5
    [U,~,~]=csvdQ(SA);
    H=QLEQ(S,U);
elseif flag==6
    [~,S,V]=svd(SA);
    H=A*V./diag(S)';
end



end