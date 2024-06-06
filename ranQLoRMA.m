function [H,S,V] = ranQLoRMA(A,varargin)
% randomized one-pass algorithm for quaternion low rank approximation
% A: data matrix
% varargin{1}: target rank r, optional
% varargin{2}: rangefinder, a function handel, optional, default = @pseudoSVD2
% varargin{3}: left sketch size s, optional
% varargin{4}: right sketch size l, optional
% varargin{5}: distribution of the test matrices, optional, default =
% Gaussian
% varargin{6}: independence of the entries of the test matrices, default =
% entry (entry-wise independent)

if isempty(varargin)
    [H,S,V] = csvdQ(A);
    return;
end

r = varargin{1};
rangefinder = @pseudoSVD2;  % optional choise = @pseudoQR if you want faster (m>10000)
distr = 'Gaussian';
independence = 'entry';
power=0;
size_input = length(varargin);

switch size_input
    case 1
        s = r+5;
        l = 2*s+5;
    case 2
        rangefinder = varargin{2};
        s = r+5;
        l = 2*s+5;
    case 3
        rangefinder = varargin{2};
        s = varargin{3};
        l = 2*s+5;
    case 4
        rangefinder = varargin{2};
        s = varargin{3};
        l = varargin{4};
    case 5
        rangefinder = varargin{2};
        s = varargin{3};
        l = varargin{4};
        distr = varargin{5};
    case 6
        rangefinder = varargin{2};
        s = varargin{3};
        l = varargin{4};
        distr = varargin{5};
        independence = varargin{6};

 case 7
        rangefinder = varargin{2};
        s = varargin{3};
        l = varargin{4};
        distr = varargin{5};
        independence = varargin{6};
        power=varargin{7};
end

%%%%%% constructing sketches
[m,n] = size(A);
Omega=ConstructTestMatrix(n,s,distr,independence);
Y = A*Omega;
clear Omega;
for iter=1:power
    Y=A'*Y;
    Y=A*Y;
end
Psi=ConstructTestMatrix(l,m,distr,independence);
W=Psi*A;
%%%%%% QB approximation with (non-)orthonormal rangefinder H

[H,X] = QBStage(Y,W,Psi,rangefinder);
clearvars Y W Psi;

%%%%% truncation stage using QSVD

[H,S,V] = TruncationStage(H,X,r);

end

