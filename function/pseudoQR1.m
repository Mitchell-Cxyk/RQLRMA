function H=pseudoQR1(A,varargin)
% first a qr step, followed by solving H'*HX = H' less  than three times as the
% correction steps. The %varargin{1}% is power iter times to evaluate the
% epsilon.
if isempty(varargin)
    Power=2;
end
if length(varargin)==1
    Power=varargin{1};
end
H=complexQR(A);
x0 = randnQ([size(H,2),1]);
for iter=1:3
    %disp('stablize');
    x2=x0;
    for iterPower=1:Power
        x2=x2/normQf(x2);
        x2=H*x2;
        x2=H'*x2;
        delta=sqrt(normQf(x2));
    end
    Z=QLEQL(H,H'*H);
    x=x0;
    for iterPower=1:Power
        x=x/normQf(x);
        x=Z*x;
        x=Z'*x;
        epsilon=sqrt(normQf(x));
    end
    H=H+Z/epsilon;
    if delta*epsilon<5      % cond(H_new) is small enough
        % fprintf('iter=%d,cond=%f',iter,delta*epsilon);
        break;
    end
    x0 = x;
end
end