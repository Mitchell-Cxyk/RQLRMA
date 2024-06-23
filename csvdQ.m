function [Uq,Sq,Vq] = csvdQ(Qq,varargin)
  % disp('ComplexRepresentUsing...');
%
% 



% computer svd of the equivalent complex matrix of Qq
Ac = Qq.w+1i*Qq.x;
Bc = Qq.y+1i*Qq.z;
Cc = [Ac Bc;-conj(Bc) conj(Ac)];
[Uc, S, Vc] = svd(Cc,'econ');

% use the relationship between Cc and Qq to obtain Uq, Sq, and Vq
w = real(Uc(1:end/2,1:2:end));
x = imag(Uc(1:end/2,1:2:end));
y = real(-conj(Uc(end/2+1:end,1:2:end)));
z = imag(-conj(Uc(end/2+1:end,1:2:end)));
Uq=quaternion(w,x,y,z);


w = real(Vc(1:end/2,1:2:end));
x = imag(Vc(1:end/2,1:2:end));
y = real(-conj(Vc(end/2+1:end,1:2:end)));
z = imag(-conj(Vc(end/2+1:end,1:2:end)));

Vq=quaternion(w,x,y,z);

Sq=S(1:2:end,1:2:end);


if ~isempty(varargin)
    r = varargin{1};
    Uq = Uq(:,1:r);
    Sq = Sq(1:r,1:r);
    Vq = Vq(:,1:r);
end


end



