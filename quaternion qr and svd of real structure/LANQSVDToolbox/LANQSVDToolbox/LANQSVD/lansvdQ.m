function [U,S,V,bnd,j] = lansvdQ(varargin)
%LANSVDQ  Compute a few largest singular values and singular vectors of quaternion matrices.
%   LANSVDQ computes singular triplets (u,v,sigma) such that
%   A*u = sigma*v and  A'*v = u*sigma. Only a few singular values
%   and singular vectors are computed  using the quaternion Lanczos
%   bidiagonalization algorithm with partial reorthogonalization (BPROQ).
%
%
%   The first input argument is either a  matrix or a
%   string containing the name of an M-file which applies a linear
%   operator to the columns of a given matrix.  In the latter case,
%   the second input must be the name of an M-file which applies the
%   transpose of the same operator to the columns of a given matrix,
%   and the third and fourth arguments must be M and N, the dimensions
%   of the problem.
%
%   [U,S,V] = LANSVDQ(A,K) computes the K largest singular values.
%
%   The full calling sequence is
%
%   [U,S,V] = LANSVDQ(A,K,SIGMA,OPTIONS)

%
%   where K is the number of singular values desired and
%   SIGMA is 'L'.
%
%   The OPTIONS structure specifies certain parameters in the algorithm.
%    Field name      Parameter                              Default
%
%    OPTIONS.tol     Convergence tolerance                  16*eps
%    OPTIONS.lanmax  Dimension of the Lanczos basis.
%    OPTIONS.p0      Starting vector for the Lanczos        rand(n,1)-0.5
%                    iteration.
%    OPTIONS.delta   Level of orthogonality among the       sqrt(eps/K)
%                    Lanczos vectors.
%    OPTIONS.eta     Level of orthogonality after           10*eps^(3/4)
%                    reorthogonalization.
%    OPTIONS.cgs     reorthogonalization method used        0
%                    '0' : iterated modified Gram-Schmidt
%                    '1' : iterated classical Gram-Schmidt
%    OPTIONS.elr     If equal to 1 then extended local      1
%                    reorthogonalization is enforced.

%   For quaternion matrix, added by Zhigang Jia, 5/1/2018
%   A quaternion matrix A=A0+A1i+A2j+A3k is saved as [A0 A2 A1 A3]
%
%   See also LANBPROQ,  SVDQ

% References:
% R.M. Larsen, Ph.D. Thesis, Aarhus University, 1998.
%
% B. N. Parlett, ``The Symmetric Eigenvalue Problem'',
% Prentice-Hall, Englewood Cliffs, NJ, 1980.
%
% H. D. Simon, ``The Lanczos algorithm with partial reorthogonalization'',
% Math. Comp. 42 (1984), no. 165, 115--142.

% Z. Jia, M. Wei, and S. Ling. A New Structure-Preserving Method for
%  ``Quaternion Hermitian Eigenvalue Problems''. J. Comput. Appl. Math.,
%  239:12-24,  2013.
% 
% Z. Jia, M. Wei, M. Zhao and Y. Chen
%  ``A new real structure-preserving quaternion QR algorithm''. J. Comput.
%  Appl. Math., 343:26-48, 2018.
%
% Z. Jia, M. K. Ng, and G. -J. Song,``Lanczos Method for Large-Scale
% Quaternion Singular Value Decomposition'',preprint.


% Rasmus Munk Larsen, DAIMI, 1998
% Modifications: Stephen Becker, srbecker@caltech.edu, 2008, 2009
% Modifications for quaterion matrices: Zhigang Jia, zhgjia@jsnu.edu.cn,on Feb 13 2018


%%%%%%%%%%%%%%%%%%%%% Parse and check input arguments. %%%%%%%%%%%%%%%%%%%%%%

persistent eTime;  
if isempty(eTime), eTime = 0; end
beginTime = cputime;

if nargin<1 || length(varargin)<1
    U = eTime;
    eTime = 0;
    return;
end

A = varargin{1};
IMPLICIT = isstr(A) || isa(A,'function_handle');
if ~IMPLICIT
%     if ~isreal(A)
%         error('A must be real')
%     end
    [m,n] = size(A);n=n/4;
%     if length(varargin) < 2, k=min(min(m,n),6); else  k=varargin{2}; end
    if length(varargin) < 2, k=min(m,n);        else  k=varargin{2}; end
    if length(varargin) < 3, sigma = 'L';       else  sigma=varargin{3}; end
    if length(varargin) < 4, options = [];      else  options=varargin{4}; end
else
    if length(varargin)<4
        error('Not enough input arguments.');
    end
    Atrans = varargin{2};
    m = varargin{3};
    n = varargin{4};
    if length(varargin) < 5, k=min(min(m,n),6); else k=varargin{5};       end
    if length(varargin) < 6, sigma = 'L';       else sigma=varargin{6};   end
    if length(varargin) < 7, options = [];      else options=varargin{7}; end
end

if ~isnumeric(n) || real(abs(fix(n))) ~= n || ~isnumeric(m) || ...
        real(abs(fix(m))) ~= m || ~isnumeric(k) || real(abs(fix(k))) ~= k
    error('M, N and K must be positive integers.')
end


% Quick return for min(m,n) equal to 0 or 1 or for zero A.
if min(n,m) < 1 || k<1
    if nargout<3
        U = zeros(k,4);
    else
        U = eye(m,4*k); S = zeros(k,4*k);  V = eye(n,4*k);  bnd = zeros(k,1);
    end
    return
elseif min(n,m) == 1 && k>0
    if IMPLICIT
        % Extract the single column or row of A
        if n==1
            A = feval(A,1);
        else
            A = feval(Atrans,1)';
        end
    end
    if nargout==1
        U = normQ(A);
    else
        [U,S,V] = svdQ(full(A));
        bnd = 0;
    end
    return
end

% A is the matrix of all zeros (not detectable if A is defined by an m-file)
if isnumeric(A)
    if  nnz(A)==0
        if nargout<3
            U = zeros(k,4); 
        else
            U = eye(m,4*k); S = zeros(k,4*k);  V = eye(n,4*k);  bnd = zeros(k,1); % quaternion
        end
        return
    end
end

lanmax = min(m,n);
tol = 16*eps;
p = rand(m,4)-[0.5*eye(m,1),zeros(m,3)];
% Parse options struct
if isstruct(options)
    c = fieldnames(options);
    for i=1:length(c)  % SRB changing strcmp to strcmpi
        if any(strcmpi(c(i),'p0')), p = getfield(options,'p0'); p=p(:); end
        if any(strcmpi(c(i),'tol')), tol = getfield(options,'tol'); end
        if any(strcmpi(c(i),'lanmax')), lanmax = getfield(options,'lanmax'); end
    end
end

% Protect against absurd options.
tol = max(tol,eps);
lanmax = min(lanmax,min(m,n));
if size(p,1)~=m
    error('p0 must be a vector of length m')
end

lanmax = min(lanmax,min(m,n));
if k>lanmax
    error('K must satisfy  K <= LANMAX <= MIN(M,N).');
end

% added by SRB, 5/13/09
if strcmp(sigma,'T')
    % thresholding mode; similar to 'L' mode
    if  ~isfield(options,'minSingValue') || isempty(options.minSingValue)
        error('lansvdQ: in Thresholding mode, OPTIONS.minSingValue must be specified');
    end
    minSingValue = options.minSingValue;
    sigma = 'L';
    
    if  ~isfield(options,'increaseK') || isempty(options.increaseK)
        increaseK = 10;
    else
        increaseK = options.increaseK;
    end
else
    minSingValue = inf;
end



%%%%%%%%%%%%%%%%%%%%% Here begins the computation  %%%%%%%%%%%%%%%%%%%%%%

% if strcmp(sigma,'S')
%     if IMPLICIT
%         error('Shift-and-invert works only when the matrix A is given explicitly.');
%     else
%         % Prepare for shift-and-invert Lanczos.
%         if issparse(A)
% %             pmmd = colmmd(A);
%             pmmd = colamd(A); % SRB: colmmd is deprecate, use colamd instead
%             A.A = A(:,pmmd);
%         else
%             A.A = A;
%         end
%         if m>=n
%             if issparse(A.A)
%                 A.R = qr(A.A,0);
%                 A.Rt = A.R';
%                 p = A.Rt\(A.A'*p); % project starting vector on span(Q1)
%             else
%                 [A.Q,A.R] = qr(A.A,0);
%                 A.Rt = A.R';
%                 p = A.Q'*p; % project starting vector on span(Q1)
%             end
%         else
%             error('Sorry, shift-and-invert for m<n not implemented yet!')
%             A.R = qr(A.A',0);
%             A.Rt = A.R';
%         end
%         condR = condest(A.R);
%         if condR > 1/eps
%             error(['A is rank deficient or too ill-conditioned to do shift-and-' ...
%                 ' invert.'])
%         end
%     end
% end

ksave = k;
neig = 0; nrestart=-1;
j = min(k+max(8,k)+1,lanmax);
U = []; V = []; B = []; anorm = []; work = zeros(2,2);

while neig < k
    %%%%%%%%%%%%%%%%%%%%% Compute Lanczos bidiagonalization %%%%%%%%%%%%%%%%%  
    if ~isreal(B)  
        error('lansvd: bi-diag part not real');
    end
    if ~IMPLICIT
        [U,B,V,p,ierr,w] = lanbproQ(A,j,p,options,U,B,V,anorm); %ZGJ-->quaternion
    else
        [U,B,V,p,ierr,w] = lanbproQ(A,Atrans,m,n,j,p,options,U,B,V,anorm);
    end
    work= work + w;

    if ierr<0 % Invariant subspace of dimension -ierr found.
        j = -ierr;
    end
    
    %%%%%%%%%%%%%%%%%% Compute singular values and error bounds %%%%%%%%%%%%%%%%
    % Analyze B
    resnrm = norm(p);
    % We might as well use the extra info. in p.
    %    S = svd(full([B;[zeros(1,j-1),resnrm]]),0);
    %    [P,S,Q] = svd(full([B;[zeros(1,j-1),resnrm]]),0);
    %    S = diag(S);
    %    bot = min(abs([P(end,1:j);Q(end,1:j)]))';
    

    % B should always be real, so bdsqr can remain unmodified
    if ~isreal(B)
        temp = imag( [ diag(B); diag(B,-1)] );
        if norm(temp) > 100*eps
            error('lansvd: bidiagional matrix from lanbpro is complex');
        else
            B = real(B);
        end
    end
    
    % If we only have one singular value, then B
    % will be a single element.
    if length(B) == 1
        S = B; bot = 1;
    else
        [S,bot] = bdsqr(diag(B),[diag(B,-1); resnrm]);
    end
    
    % Use Largest Ritz value to estimate ||A||_2. This might save some
    % reorth. in case of restart.
    anorm=S(1);
    
    % Set simple error bounds
    bnd = resnrm*abs(bot);
    
    % Examine gap structure and refine error bounds
    bnd = refinebounds(S.^2,bnd,n*eps*anorm);
    
    %%%%%%%%%%%%%%%%%%% Check convergence criterion %%%%%%%%%%%%%%%%%%%%
    i=1;
    neig = 0;
    while i<=min(j,k)
        if (bnd(i) <= tol*abs(S(i)))
            neig = neig + 1;
            i = i+1;
        else
            i = min(j,k)+1;
        end
    end
    
    %%%%%%%%%% Check whether to stop or to extend the Krylov basis? %%%%%%%%%%
    if ierr<0 % Invariant subspace found
        if j<k
            warning(['Invariant subspace of dimension ',num2str(j-1),' found.'])
        end
        j = j-1;
        break;
    end
    if j>=lanmax % Maximal dimension of Krylov subspace reached. Bail out
        if j>=min(m,n)
            neig = ksave;
            break;
        end
        if neig<ksave
            warning(['Maximum dimension of Krylov subspace exceeded prior',...
                ' to convergence.']);
        end
        break;
    end
    
    % Increase dimension of Krylov subspace
    if neig>0
        % increase j by approx. half the average number of steps pr. converged
        % singular value (j/neig) times the number of remaining ones (k-neig).
        j = j + min(100,max(2,0.5*(k-neig)*j/(neig+1)));
    else
        % As long a very few singular values have converged, increase j rapidly.
        %    j = j + ceil(min(100,max(8,2^nrestart*k)));
        j = max(1.5*j,j+10);
    end
    j = ceil(min(j+1,lanmax));
    nrestart = nrestart + 1;

    
    %  check if smallest singular value is less than
    % the threshold; if it isn't, then increase k
    mn = min( abs( S(1: min(j,k))) );
    if mn > minSingValue
        k = k + increaseK;  ksave = k;
        j2 = ceil( min(k+max(8,k)+1,lanmax) );
        j2 = min(j2, lanmax) ;
        j = max( j, j2 );
    %else
        %fprintf('mn is %f\n',mn);
    end   
    
end



%%%%%%%%%%%%%%%% Lanczos converged (or failed). Prepare output %%%%%%%%%%%%%%%
k = min(ksave,j);

if nargout>2
    j = size(B,2);
    % Compute singular vectors
    [P,S,Q] = svd(full([B;[zeros(1,j-1),resnrm]]),0);
    S = diag(S);
    if size(Q,2)~=k
        Q = Q(:,1:k);
        P = P(:,1:k);
    end
    Z=zeros(size(Q));
    Q=[Q,Z,Z,Z];
    Z=zeros(size(P));
    P=[P,Z,Z,Z];
    % Compute and normalize Ritz vectors (overwrites U and V to save memory).
    
    if resnrm~=0
        U = timesQ(U,P(1:j,:)) + timesQ((p/resnrm),P(j+1,:));
    else
        U = timesQ(U,P(1:j,:));
    end
    V = timesQ(V,Q);
    cV=size(V,2)/4;
    cU=size(U,2)/4;
    for i=1:k
        nq = normQ(V(:,[i,cV+i,2*cV+i,3*cV+i]));
        if isfinite(nq) && nq~=0 && nq~=1
            V(:,[i,cV+i,2*cV+i,3*cV+i]) = V(:,[i,cV+i,2*cV+i,3*cV+i])/nq;
        end
        nq = normQ(U(:,[i,cU+i,2*cU+i,3*cU+i]));
        if isfinite(nq) && nq~=0 && nq~=1
            U(:,[i,cU+i,2*cU+i,3*cU+i]) = U(:,[i,cU+i,2*cU+i,3*cU+i])/nq;
        end
    end
end

% Pick out desired part the spectrum
S = S(1:k);
bnd = bnd(1:k);

% if strcmp(sigma,'S')
%     [S,p] = sort(-1./S);
%     S = -S;
%     bnd = bnd(p);
%     if nargout>2
%         if issparse(A.A)
%             U = A.A*(A.R\U(:,p));
%             V(pmmd,:) = V(:,p);
%         else
%             U = A.Q(:,1:min(m,n))*U(:,p);
%             V = V(:,p);
%         end
%     end
% end

if nargout<3
    U = S;
    S = B; % Undocumented feature -  for checking B.
else
    S = diag(S);
end

eTime = eTime + cputime - beginTime;
