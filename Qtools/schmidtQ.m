function [U] = schmidtQ(in)
% Schmidt Orthogonalization
% recommend to use qMGS1 instead 



[~,n] = size(in);
% Init OrthMatrix 
tmp = zeros(size(in)); U = quaternion(tmp,tmp,tmp,tmp);
U(:,1) = in(:,1); U(:,1) = U(:,1)/frob(U(:,1));

% Orthogonalization
for k=2:n
    for t=1:k-1
        U(:,k) = U(:,k) -   U(:,t)*(U(:,t)'*in(:,k));
    end
    U(:,k) = U(:,k) + in(:,k); U(:,k) = U(:,k)/normQf(U(:,k));
end
 

end