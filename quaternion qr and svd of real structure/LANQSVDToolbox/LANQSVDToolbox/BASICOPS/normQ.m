function r=normQ(A,opt)
    %compute norm of quaterinon matrix A in cell format
    %r=sqrt(norm(A{1},'fro')^2+norm(A{2},'fro')^2+norm(A{3},'fro')^2+norm(A{4},'fro')^2);
    % by Zhigang Jia On January 24,2018
    if nargin<=1
        r=norm(A,'fro');
    elseif nargin==2
        if opt=='d'
            [A0,A1,A2,A3]=A2A0123(A);
            r=norm([2*A1-A2-A3,2*A2-A3-A1,2*A3-A1-A2],'fro')/3;
        else
            r=norm(A,opt);
        end
    end
end