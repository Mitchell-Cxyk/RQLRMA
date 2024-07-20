function [Q, R] = qMGSWithPart(A,U)
AA=[A.w;A.x;A.y;A.z];
UU=[U.w;U.x;U.y;U.z];
rankU=size(UU,2);
    m=size(AA,1)/4;
    n=size(AA,2);
RR = zeros(4*n, n);
%RR(1:rankU,1:rankU)=eye(rankU);
GDU=Realp(UU(1 : m, :), UU(1 + m : 2 * m, :), UU(2 * m + 1 : 3 * m, :), ...
        UU(3 * m + 1 : 4 * m, :));
RLR=GDU'*AA(:,1:end);
AA(:,1:end)=AA(:,1:end)-GDU*RLR;
for s =1 : n-1
    RR(s, s) = norm(AA(:, s));
    AA(:, s) = AA(:, s) / RR(s, s);
    GD = Realp(AA(1 : m, s), AA(1 + m : 2 * m, s), AA(2 * m + 1 : 3 * m, s), ...
        AA(3 * m + 1 : 4 * m, s));
    RR([s, s + n, s + 2 * n, s + 3 * n], s + 1 : n) = GD' * AA(:, s + 1 : n);

        % GD=Realp(RR(s,s+1:n),RR(s+m,s+1:n),RR(s+2*m,s+1:n),RR(s+3*m,s+1:n));
        % AA(:,s+1:n)=AA(:,s+1:n)-GDRR*AA([s,s+m,s+2*m,s+3*m],s+1:n);    
    AA(:, s + 1 : n) = AA(:, s + 1 : n) - ...
        GD * RR([s, s + n, s + 2 * n, s + 3 * n], s + 1 : n);
end
RR(n, n) = norm(AA(:, n));
AA(:, n) = AA(:, n) / RR(n, n);
QQ = AA(:,1:end);


 
    Q=quaternion(QQ(1:m,:),QQ(m+1:2*m,:),QQ(2*m+1:3*m,:),QQ(3*m+1:4*m,:));
    Q=[U,Q];
    RLRQ=quaternion(RLR(1:rankU,:),RLR(1+rankU:2*rankU,:),RLR(1+2*rankU:3*rankU,:),RLR(3*rankU+1:4*rankU,:));
    R=quaternion(RR(1:n,:),RR(n+1:2*n,:),RR(2*n+1:3*n,:),RR(3*n+1:4*n,:));
    R=[eyeq(size(U,2)),RLRQ;zerosq(size(R,1),size(U,2)),R];
end


    function GR=Realp1(Aw,Ax,Ay,Az)
        GR=[Aw,Ax,Ay,Az; -Ax,Aw,Az,-Ay; -Ay, -Az,Aw,Ax; -Az,Ay,-Ax,Aw];
    end
