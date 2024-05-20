function [Qq] = Qr2Q(Qr)
%COMPLEX_REPRESENTATION_Q convert compact real representation back to a
% full real representation of a quaternion Q
%   
 
n = size(Qr,1)/4;

 Qq = [Qr, J1(n)*Qr, J2(n)*Qr, J3(n)*Qr];
end

