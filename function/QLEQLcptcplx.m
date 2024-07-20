function cptX = QLEQLcptcplx(cptb,cptA)
% cptb = [b0 b1], b = b0+b1*j; cptA = [A0 A1]; A = A0+A1*j;
% cptX = [X0 X1];
% to solve X*A = b, using its compact complex representation
% cptX*Chi_A = cptb;
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

cptX = cptb/cplxcpt2full(cptA);

% CA=[[cptA.w+cptA.x*i,cptA.y+cptA.z*i];[-cptA.y+cptA.z*i,cptA.w-cptA.x*i]];
% Cb=[cptb.w+cptb.x*i,cptb.y+cptb.z*i];
% Cx=Cb/CA;
% Cx0=Cx(:,1:size(Cx,2)/2);
% Cx1=Cx(:,size(Cx,2)/2+1:size(Cx,2));
% output=quaternion(real(Cx0),imag(Cx0),real(Cx1),imag(Cx1));


    

end
