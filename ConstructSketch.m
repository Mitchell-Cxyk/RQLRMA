function [Y,W] = ConstructSketch(varargin)
    narginchk(2,3);
    if nargin==2
        A=varargin{1};
        Omega=varargin{2};
        Psi=randq(1,size(A,1));
    elseif nargin==3
        A=varargin{1};
        Omega=varargin{2};
        Psi=varargin{3};
    else
        disp('error parameters number!\n')
    end
%
% description.
%
% @since 1.0.0
% @param {quaternionMatrix} [A,Omega,Psi] A is data matrix, Omega is right test matrix, Psi is left test matrix.
% @return {quaternionMatrix} [Y,W] Y=A*Omega, W=Psi*A.
% @see dependencies
%
% [Omega,~,~]=mysvdQ(Omega);
% size(Omega)
% [~,~,Psi]=mysvdQ(Psi);
% size(Psi)
Y=A*Omega;
W=Psi*A;
end
