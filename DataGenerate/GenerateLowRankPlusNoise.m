function output = GenerateLowRankPlusNoise(m,n,R,Noise)
%
% description.
%
% @since 1.0.0
% @param {type} [name] description.
% @return {type} [name] description.
% @see dependencies
%
u=randq(m,1)/sqrt(m);
    v=randq(n,1)/sqrt(n);
    U=eyeq(m,n)-2*u*u(1:n)';
    V=eyeq(n)-2*v*v';
    %mn=min(m,n);
    S=zeros(n,n);
if strcmp(Noise,'High')||strcmp(Noise,'high')
    gamma=1;
elseif strcmp(Noise,'Mid')||strcmp(Noise,'Midium')||strcmp(Noise,'midium')||strcmp(Noise,'mid')
    gamma=0.01;
elseif strcmp(Noise,'Low')||strcmp(Noise,'low')
    gamma=0.0001;
    

end

S(1:R,1:R)=eye(R);
G=randn(size(S,1),size(S,2));
%[~,G,~]=svd(G);
S=S+sqrt(gamma*R/(2*size(S,1)*size(S,2)))*(G);

A=U*S*V';
output=A;

