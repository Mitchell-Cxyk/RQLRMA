function [out] = normQf(A)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
out = sqrt(norm(A.w,'fro')^2 + norm(A.x,'fro')^2 + norm(A.y,'fro')^2 + norm(A.z,'fro')^2  );
end

