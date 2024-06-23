function [Q, R] = qMGS1(A)
AA=[A.w;A.x;A.y;A.z];
    m=size(AA,1)/4;
    n=size(AA,2);
RR = zeros(4*n, n);
for s = 1 : n-1
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
QQ = AA;


 
    Q=quaternion(QQ(1:m,:),QQ(m+1:2*m,:),QQ(2*m+1:3*m,:),QQ(3*m+1:4*m,:));
    R=quaternion(RR(1:n,:),RR(n+1:2*n,:),RR(2*n+1:3*n,:),RR(3*n+1:4*n,:));

end


    function GR=Realp1(Aw,Ax,Ay,Az)
        GR=[Aw,Ax,Ay,Az; -Ax,Aw,Az,-Ay; -Ay, -Az,Aw,Ax; -Az,Ay,-Ax,Aw];
    end
