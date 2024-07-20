function [U,S,V]=svdQCQ(X, econ)

narginchk(1, 2), nargoutchk(0, 3)

if nargin == 2
    if isnumeric(econ) && econ ~= 0
        error('Use svd(X,0) for economy size decomposition.');
    end
    if ~isnumeric(econ) && ~strcmp(econ, 'econ')
        error('Use svd(X,''econ'') for economy size decomposition.');
    end
end

sz = size(X);
row_size = sz(1); col_size = sz(2);

threshold = 5;

%% row size is far smaller than the column size
if col_size/row_size >= threshold
    XXH = X*X';
    [U,S,~]=R_svdQCQ(XXH);      % for computing the left factors
    S = sqrt(S);
    V = (X'*U)./diag(S)';
%% column size is far smaller than the row size
elseif row_size/col_size >= threshold
    XHX = X'*X;
    [V,S,~]=R_svdQCQ(XHX);      % for computing the right factors
    S = sqrt(S);
    U=X*V./diag(S)';
else
    [U,S,V] = R_svdQCQ(X);
end

end

