function H=pseudoPolar(Y)
% first a qr step, followed by solving H'*HX = H' three times as the
% correction steps
H=pesudoQR(Y);

% computing the polar factor U of A
 
 
[A,alpha,condA] = sqrtmQ(H'*H);
H = QLEQL(H,A);

[A,alpha,condA] = sqrtmQ(H'*H);
H = QLEQL(H,A);



% H = QLEQL(H,sqrtmQ(H'*H));