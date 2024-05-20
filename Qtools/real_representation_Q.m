function [rA] = real_representation_Q(A)
% Given a quaternion matrix A, return its real representation
% recommend to use Q2real instead
A0 = A.w; A1 = A.x; A2 = A.y; A3 = A.z;

rA = [A0 -A1 -A2 -A3; A1 A0 -A3 A2; A2 A3  A0  -A1; A3 -A2 A1 A0];
end

