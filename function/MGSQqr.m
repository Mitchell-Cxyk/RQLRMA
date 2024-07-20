function [Q,R] = MGSQqr(A)
%
% The script is using real representation modified Gram-Schmidt algorithm to get a thin QR decomposition of quaternion matrix A.
%
% @since 1.0.0
% @param {quaternion matrix} [A] data matrix, which is tall.
% @return {quaternion matrices} [Q,R] Q is orthognomal, R is upper-triangle.
% @see dependencies G. H. Golub and C. F. Van Loan, Matrix Computations, The John Hopkins University Press, 1996.
%

    AA=[A.w;A.x;A.y;A.z];
    m=size(AA,1)/4;
    n=size(AA,2);
    RR=zeros(4*n,n);
    for s=1:n
        RR(s,s)=norm(AA(:,s));
        if RR(s,s)~=0
        AA(:,s)=AA(:,s)/RR(s,s);
        end
        
% GD=Realp(AA(1:m,s),AA(1+m:2*m,s),AA(2*m+1:3*m,s),AA(3*m+1:4*m,s));

%         GDRR=Realp(RR(s,s+1:n),RR(s+m,s+1:n),RR(s+2*m,s+1:n),RR(s+3*m,s+1:n));
%         AA(:,s+1:n)=AA(:,s+1:n)-GDRR*AA([s,s+m,s+2*m,s+3*m],s+1:n);
    for k=s+1:n
    GD=Realp(AA(1:m,s),AA(1+m:2*m,s),AA(2*m+1:3*m,s),AA(3*m+1:4*m,s));
            RR([s,s+n,s+2*n,s+3*n],k)=GD'*AA(:,k);

        %AA(:,k)=AA(:,k)-Realp(AA(1:m,s),AA(m+1:2*m,s),AA(2*m+1:3*m,s),AA(3*m+1:4*m,s))*RR([s,s+n,s+2*n,s+3*n],k);
        AA(:,k)=AA(:,k)-GD*RR([s,s+n,s+2*n,s+3*n],k);
    end

    end
%     RR(n,n)=norm(AA(:,n));
%     AA(:,n)=AA(:,n)/RR(n,n);
    QQ=AA;
    Q=quaternion(QQ(1:m,:),QQ(m+1:2*m,:),QQ(2*m+1:3*m,:),QQ(3*m+1:4*m,:));
    R=quaternion(RR(1:n,:),RR(n+1:2*n,:),RR(2*n+1:3*n,:),RR(3*n+1:4*n,:));

    function GR=Realp(Aw,Ax,Ay,Az)
        GR=[Aw,-Ax,-Ay,-Az;Ax,Aw,-Az,Ay;Ay,Az,Aw,-Ax;Az,-Ay,Ax,Aw];
    end
end