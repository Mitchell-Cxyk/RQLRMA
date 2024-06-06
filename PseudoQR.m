function H=pseudoQR(A)
% first a qr step, followed by solving H'*HX = H' three times as the
% correction steps
H=complexQR(A);
for iter=1:3
    %disp('stablize');
Z=QLEQL(H,H'*H);
Pro=randq(size(Z,2),1);
for iterPower=1:2
Pro=Pro/norm(Pro);
Pro=Z*Pro;
Pro=Z'*Pro;
epsilon=sqrt(norm(Pro));
end
H=H+Z/epsilon;
end
end