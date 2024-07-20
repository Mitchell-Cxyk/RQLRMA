function [A0,A1,A2,A3]=A2A0123(A)
% input A=[A0 A2 A1 A3]
% output: A0 A1 A2 A3
%by Zhigang Jia
% On Aug 14  2014

n=size(A,2)/4;


A0=A(:,1:n);
A2=A(:,(n+1):(2*n));
A1=A(:,(2*n+1):(3*n));
A3=A(:,(3*n+1):(4*n));
