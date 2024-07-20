function H=approxPolar(A,iterTime)
% first a qr step, followed by solving H'*HX = H' three times as the
% correction steps
H=A;
x0 = randnQ([size(H,2),1]);
for iter=1:iterTime
    %disp('stablize');
    Z=QLEQL(H,H'*H);
    x=x0;
    for iterPower=1:2
        x=x/normQf(x);
        x=Z*x;
        x=Z'*x;
        epsilon=sqrt(normQf(x));
    end
    H=H+Z/epsilon;
    x0 = x;
end
end