function [Q,R] = MGSQqr(A)
%
% description.
%
% @since 1.0.0
% @param {type} [name] description.
% @return {type} [name] description.
% @see dependencies
%

    AA=[A.w;A.x;A.y;A.z];
    m=size(AA,1)/4;
    n=size(AA,2);
    RR=zeros(4*n,n);
    for s=1:n-1
        RR(s,s)=norm(AA(:,s));
        AA(:,s)=AA(:,s)/RR(s,s);
        GD=Realp(AA(1:m,s),AA(1+m:2*m,s),AA(2*m+1:3*m,s),AA(3*m+1:4*m,s));
        RR([s,s+m,s+2*m,s+3*m],s+1:n)=GD'*AA(:,s+1:n);
        DF=zeros(4*m,n);
        %DF=quaternion(zeros(m,n),zeros(m,n),zeros(m,n),zeros(m,n));
        for t=s+1:n
            DF(1:m,t)=RR(s,t)*AA(1:m,s)-RR(s+m,t).*AA(m+1:2*m,s)-RR(s+2*m,t).*AA(2*m+1:3*m,s)-RR(s+3*m,t).*AA(3*m+1:4*m,s);
            DF(m+1:2*m,t)=RR(s+m,t)*AA(1:m,s)+RR(s,t).*AA(m+1:2*m,s)-RR(s+3*m,t).*AA(2*m+1:3*m,s)+RR(s+2*m,t).*AA(3*m+1:4*m,s);
            DF(2*m+1:3*m,t)=RR(s+2*m,t)*AA(1:m,s)+RR(s+3*m,t).*AA(m+1:2*m,s)+RR(s,t).*AA(2*m+1:3*m,s)-RR(s+m,t).*AA(3*m+1:4*m,s);
            DF(3*m+1:4*m,t)=RR(s+3*m,t)*AA(1:m,s)-RR(s+2*m,t).*AA(m+1:2*m,s)+RR(s+m,t).*AA(2*m+1:3*m,s)+RR(s,t).*AA(3*m+1:4*m,s);
        end
%         for t=s+1:n
%             RRST=quaternion(RR(s,t),RR(s+m,t),RR(s+2*m,t),RR(s+3*m,t));
%             Vs=quaternion(AA(1:m,s),AA(m+1:2*m,s),AA(2*m+1:3*m,s),AA(3*m+1:4*m,s));
%             DF(:,t)=RRST*Vs/(Vs'*Vs);
%         end
%         DFw=DF.w;DFx=DF.x;DFy=DF.y;DFz=DF.z;
%         AA(:,s+1:n)=AA(:,s+1:n)-[DFw(:,s+1:n);DFx(:,s+1:n);DFy(:,s+1:n);DFz(:,s+1:n)];
          AA(:,s+1:n)=AA(:,s+1:n)-DF(:,s+1:n)/(AA(:,s)'*AA(:,s));
    end
    RR(n,n)=norm(AA(:,n));
    AA(:,n)=AA(:,n)/RR(n,n);
    QQ=AA;
    Q=quaternion(QQ(1:m,:),QQ(m+1:2*m,:),QQ(2*m+1:3*m,:),QQ(3*m+1:4*m,:));
    R=quaternion(RR(1:n,:),RR(n+1:2*n,:),RR(2*n+1:3*n,:),RR(3*n+1:4*n,:));


end
