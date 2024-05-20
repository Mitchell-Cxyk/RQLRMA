function [j3] = J3(n)
% let Q be a quaternion matrix and its real representation be
% [Qw, ..., ..., ...;
%  Qx, ..., ..., ...;
%  Qy, ..., ..., ...;
%  Qz, ..., ..., ...]
% the first block is Qr, the second one is J1*Qr, the third is J2*Qr, the
% fourth is J3*Qr.

j3 = [
     0     0     0    -1;
     0     0     1     0;
     0    -1     0     0;
     1     0     0     0];
 
j3 = kron(j3,eye(n));

end
