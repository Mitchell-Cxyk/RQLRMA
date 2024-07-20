function A=extendQcol(A,E)
% extenQcol A to A=[A0 E0 A2 E2 A1 E1 A3 E3]

% by Zhigang Jia On February 13,2018

[A0,A1,A2,A3]=A2A0123(A);
[E0,E1,E2,E3]=A2A0123(E);
A=[A0 E0 A2 E2 A1 E1 A3 E3];
