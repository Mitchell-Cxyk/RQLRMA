function A=timesQ(B,C)
%  A=B*C
%B=[B0 B2 B1 B3]  denotes a quaternion matrix B=B0+B1*i+B2*j+B3*k
%C=[C0 C2 C1 C3]  denotes a quaternion matrix C=C0+C1*i+C2*j+C3*k
%A=[A0 A2 A1 A3]  denotes a quaternion matrix A=A0+A1*i+A2*j+A3*k

%by zhigang 
%On Jan 25,2015
%
[B0,B1,B2,B3]=A2A0123(B);
[C0,C1,C2,C3]=A2A0123(C);
A0=B0*C0-B2*C2-B1*C1-B3*C3;
A2=B0*C2+B2*C0-B1*C3+B3*C1;
A1=B0*C1+B2*C3+B1*C0-B3*C2;
A3=B0*C3-B2*C1+B1*C2+B3*C0;
%
A=[A0 A2 A1 A3];
