function [Rr] = Q2real(Qq)
%COMPLEX_REPRESENTATION_Q real representation of a quaternion matrix Qq
%   

Q0 = Qq.w; Q1 = Qq.x; Q2 = Qq.y; Q3 = Qq.z;

Rr = [Q0, -Q1, -Q2, -Q3;
    Q1, Q0, -Q3, Q2;
    Q2, Q3, Q0, -Q1;
    Q3, -Q2, Q1, Q0];

end

