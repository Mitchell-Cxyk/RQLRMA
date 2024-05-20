function [QA] = tens2Q(T)
%TENS2Q convert a  (N+1)-th order tensor of size I_1\times \cdots I_N \times 4 or I_1\times \cdots I_N \times 4 to a 
% quaternion tensor of size I_1\times \cdots \times I_N, 
% where N >= 1
sz_tens = size(T);
sz_end = sz_tens(end); sz_without_end = sz_tens(1:end-1);
if ndims(T) == 1
   error('T should be a N-th order tensor (N>=2)'); 
end
if (sz_end ~=4) && (sz_end ~=3)
    error('the size of the last mode of T shoud be 3 or 4 ');
end

vT = reshape(T,prod(sz_tens)/sz_end,sz_end);

if ismatrix(T)
    if sz_end == 3
        QA = quaternion(zeros(sz_tens(1),1), T(:,1), T(:,2), T(:,3));
    else
        QA = quaternion(T(:,1),T(:,2),T(:,3),T(:,4));
    end
    return;
end

if sz_end == 3
    QA = quaternion(zeros(sz_without_end), reshape(vT(:,1),sz_without_end), reshape(vT(:,2),sz_without_end), reshape(vT(:,3),sz_without_end));
else
    QA = quaternion(reshape(vT(:,1),sz_without_end), reshape(vT(:,2),sz_without_end), reshape(vT(:,3),sz_without_end),reshape(vT(:,4),sz_without_end));
end


end

