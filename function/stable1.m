function output=stable1(A)
pinvAconj=QLEQL(A,A'*A);
%pinvAconj=QLEQL(A,A'*A+eye(size(A,2)))-A;
omega=randq(size(A,2),1)/sqrt(size(A,2));
epsilon=norm(pinvAconj*omega);
output=A+pinvAconj/epsilon;
end
