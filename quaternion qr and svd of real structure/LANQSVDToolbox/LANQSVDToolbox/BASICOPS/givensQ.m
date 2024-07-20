function G=givensQ(g0,g1,g2,g3)
    % by Zhigang Jia On January 26,2015
        sq=sqrt(g0*g0+g2*g2+g1*g1+g3*g3);
        tol=1e-14;
         if sq<=tol
             G=eye(4);
         else 
           %% 24 flops
           G=[  g0, g2, g1, g3;
                 -g2, g0, g3,-g1;
                 -g1,-g3, g0, g2;
                -g3, g1,-g2, g0]/sq; 
         end