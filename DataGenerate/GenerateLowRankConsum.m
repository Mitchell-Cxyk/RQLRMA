function output = GenerateLowRankConsum(m,n,SingularValue)
    %
    % description.
    %
    % @since 1.0.0
    % @param {type} [name] description.
    % @return {type} [name] description.
    % @see dependencies
    %
    %A=randq(m,n);
    %[U,S,V]=mysvdQ(A);
    u=randq(m,1)/sqrt(m);
    v=randq(n,1)/sqrt(n);
    U=eyeq(m,n)-2*u*u(1:n)';
    V=eyeq(n)-2*v*v';
    %mn=min(m,n);
%     S=zeros(n,n);
%     
%     if strcmp(Decay,'High')||strcmp(Decay,'high')
%         gamma=1;
%     elseif strcmp(Decay,'Mid')||strcmp(Decay,'Midium')||strcmp(Decay,'midium')||strcmp(Decay,'mid')
%         gamma=0.5;
%     elseif strcmp(Decay,'Low')||strcmp(Decay,'low')
%         gamma=0.25;
%         
%     
%     end
%     
%     S(1:R,1:R)=eye(R);
%     for i=R:min(m,n)
%         S(i,i)=10^(-1*gamma*(i-R));
%     end
S=SingularValue;
if size(S,1)==1||size(S,2)==1
S=diag(S);
end
    
    A=U*S*V';
    output=A;
        
    
    end
    