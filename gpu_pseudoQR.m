function Q=pesudoQR(A)

Y=[A.w+i*A.x;-conj(A.y+i*A.z)];
Y_gpu=gpuArray(Y);
[Q1_gpu,~]=qr(Y_gpu,0);
Q1=gather(Q1_gpu);
Q.w=real(Q1(1:end/2,:));
Q.x=imag(Q1(1:end/2,:));
Q.y=real(-conj(Q1(end/2+1:end,:)));
Q.z=imag(-conj(Q1(end/2+1:end,:)));
Q=quaternion(Q.w,Q.x,Q.y,Q.z);
end
