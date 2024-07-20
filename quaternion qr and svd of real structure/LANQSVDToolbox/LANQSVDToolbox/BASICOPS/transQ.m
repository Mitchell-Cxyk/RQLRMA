function AT=transQ(A)
%  AT=A^*
%A=[A0 A2 A1 A3]  denotes a quaternion matrix A=A0+A1*i+A2*j+A3*k
%AT=[A0 -A2 -A1 -A3]  denotes a quaternion matrix AT=A0'-A1'*i-A2'*j-A3'*k


%by zhigang 
%On Jan 25,2015
%
[A0,A1,A2,A3]=A2A0123(A);
%
AT=[A0' -A2' -A1' -A3'];
