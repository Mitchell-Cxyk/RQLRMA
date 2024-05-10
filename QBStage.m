function [H,X] = QBStage(Y,W,Psi,rangefinder)
% QB stage of the randomized one-pass algorithm for quaternion low rank approximation
% input: Sketch Y \in \mathbb Q^{m\times s}, Sketch W \in \mathbb Q^{l\times n}, test matrix Psi \in \mathbb
% Q^{l\times n},  
% input: function handle rangefinder, usage: H = rangefinder(Y); 
% default rangefinder = @pseudoSVD2.

 

%%%%%% QB approximation with (non-)orthonormal rangefinder H
H=rangefinder(Y);
clear Y;
X=QLEQ(Psi*H,W);
clear W;
clear Psi;

end

