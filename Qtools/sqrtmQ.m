function [sqrtA,resnorm,cond_sqrtChiA] = sqrtmQ(A)
% compute the square root of a Hermitian quaternion matrix using its
% complex representation

chiA = Q2cplx(A); 

if nargout == 1
    sqrtChiA = sqrtm(chiA);
elseif nargout == 2
    [sqrtChiA,resnorm] = sqrtm(chiA); 
else
[sqrtChiA,resnorm,cond_sqrtChiA] = sqrtm(chiA); 
end

sqrtA = cplx2Q(sqrtChiA);

end

 