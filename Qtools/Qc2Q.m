function [Q] = Qc2Q(Qc)
% convert the compact complex representation back to quaternion class
    Q0 = Qc(1:end/2,:);
    Q1 = -conj(Qc(end/2+1:end,:));
    Q = quaternion(real(Q0),imag(Q0),real(Q1),imag(Q1) );
end

