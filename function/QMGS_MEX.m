function [Q,R]=QMGS_MEX(A)
AA=[A.w;A.x;A.y;A.z];
m=size(AA,1)/4;
n=size(AA,2);
% [QQ,RR]=qMGS_mex(AA);

if ispc
    % Windows platform
    [QQ,RR]=qMGS_mex(AA);
elseif ismac
    % macOS platform
    [~, result] = system('uname -m');
    if contains(result, 'arm64')
        [QQ,RR] = qMGSmacM1_mex(AA);
    else
        [QQ,RR]=qMGSmac_mex(AA);
    end
else
    error('Unsupported platform!');
end

Q=quaternion(QQ(1:m,:),QQ(m+1:2*m,:),QQ(2*m+1:3*m,:),QQ(3*m+1:4*m,:));
R=quaternion(RR(1:n,:),RR(n+1:2*n,:),RR(2*n+1:3*n,:),RR(3*n+1:4*n,:));
end