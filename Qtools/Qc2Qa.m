function Qa=Qc2Qa(Qc)
% convert the compact complex representation Qc to Qa = J\overline{Qc}
Qa=zeros(size(Qc));
Qa(1:end/2,:)=-conj(Qc(end/2+1:end,:));
Qa(end/2+1:end,:)=conj(Qc(1:end/2,:));