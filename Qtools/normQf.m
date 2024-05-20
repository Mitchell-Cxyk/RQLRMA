function [out] = normQf(A)
% the Frobenius norm of a quaternion matrix A
out = sqrt(norm(A.w,'fro')^2 + norm(A.x,'fro')^2 + norm(A.y,'fro')^2 + norm(A.z,'fro')^2  );
end

