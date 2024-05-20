function [res] = compareRangeQ(Y,H)
%COMPARERANGEQ compare the range of two quaternion matrices Y and H of the
%same size using complex representation

    [uY,~,~] = svd(Q2cplx(Y),0);
    [uH,~,~] = svd(Q2cplx(H),0);

   res= norm(uY*uY'-uH*uH','fro');

end

