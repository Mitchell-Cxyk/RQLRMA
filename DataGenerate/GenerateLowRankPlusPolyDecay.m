function output = GenerateLowRankPlusPolyDecay(m,n,R,Decay)
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
if strcmp(Decay,'High')||strcmp(Decay,'high')
    gamma=2;
elseif strcmp(Decay,'Mid')||strcmp(Decay,'Midium')||strcmp(Decay,'midium')||strcmp(Decay,'mid')
    gamma=1.5;
elseif strcmp(Decay,'Low')||strcmp(Decay,'low')
    gamma=1;
    

end

S(1:R,1:R)=eye(R);
for i=R+1:size(S,1)
    S(i,i)=(i-R+1)^(-1*gamma);
end

A=U*S*V';
output=A;
    

end
