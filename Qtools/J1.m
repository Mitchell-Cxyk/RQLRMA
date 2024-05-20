function [j1] = J1(n)
% let Q be a quaternion matrix and its real representation be
% [Qw, ..., ..., ...;
%  Qx, ..., ..., ...;
%  Qy, ..., ..., ...;
%  Qz, ..., ..., ...]
% the first block is Qr, the second one is J1*Qr, the third is J2*Qr, the
% fourth is J3*Qr.

j1 = [
     0    -1     0     0;
     1     0     0     0;
     0     0     0     1;
     0     0    -1     0];
 
j1 = kron(j1,eye(n));

end
