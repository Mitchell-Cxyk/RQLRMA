function output = QLEQL(b,A)
%
% Quaternion linear equality solver if A is tall matrix, it is solution of  x*A=b, where x is select from most zeros.
%If A is wide, x is least square solution of x*A=b;
%
%
% @since 1.0.0
% @param {quarternion matrix} [b,A] output=b/A;
% @return {quaternion matrix} [output] 
% @see dependencies
%
CA=[[A.w+A.x*i,A.y+A.z*i];[-A.y+A.z*i,A.w-A.x*i]];
Cb=[b.w+b.x*i,b.y+b.z*i];
Cx=Cb/CA;
Cx0=Cx(:,1:size(Cx,2)/2);
Cx1=Cx(:,size(Cx,2)/2+1:size(Cx,2));
output=quaternion(real(Cx0),imag(Cx0),real(Cx1),imag(Cx1));


    

end
