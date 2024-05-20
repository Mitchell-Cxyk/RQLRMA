function [in] = l_inprodQ(a,b)
%INPRODQ left inner product between two quaternion (multi)arrays 
% <a,b>_l = a.'* conj(b)

    in = a(:).'*conj(b(:));
 
end

