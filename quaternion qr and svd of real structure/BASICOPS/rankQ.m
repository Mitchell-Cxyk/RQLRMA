function r=rankQ(A,tol)
    % [~,D,~]=svdQ([A{1},A{3},A{2},A{4}]);
    % by Zhigang Jia On January 24,2018
     [~,D,~]=svdQ(A);
     if nargin==2
        r=rank(D,tol);
     else
         r=rank(D);
     end
end