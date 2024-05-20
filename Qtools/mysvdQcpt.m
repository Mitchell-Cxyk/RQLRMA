function [U,S,V] = mysvdQcpt(X, econ)
% efficient svd by doing XHX or XXH if X is a thin or fat quaternion matrix
% X is the compactly complex representation of the quaternion matrix with X
% = [X0 X1] with X = X0 + X1j
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
row_size = sz(1); col_size = sz(2)/2;

threshold = 5;

%% row size is far smaller than the column size
if col_size/row_size >= threshold
    XXH = mtimesQcpt(X,conjtransQcpt(X));
    [U,S,~]=svdQcpt(XXH);      % for computing the left factors
    S = sqrt(S);
%     V = (X'*U)./diag(S)' 
    V = mtimesQcpt(conjtransQcpt(X),U)./[diag(S)' diag(S)'];
%% column size is far smaller than the row size
elseif row_size/col_size >= threshold
    XHX = mtimesQcpt(conjtransQcpt(X),X);
    [V,S,~]=svdQcpt(XHX);      % for computing the right factors
    S = sqrt(S);
%     U=X*V./diag(S)';
    U = mtimesQcpt(X,V)./[diag(S)' diag(S)'];
else
    [U,S,V] = svdQcpt(X);
end
end

