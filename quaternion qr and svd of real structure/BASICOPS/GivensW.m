function Gw=GivensW(g0,g1,g2,g3)
    % by Zhigang Jia On August 12,2014
        sq=sqrt(g0*g0+g2*g2+g1*g1+g3*g3);
        tol=1e-14;
         if sq<=tol
             Gw=eye(4);
         else
           Gw=[  g0, g2, g1, g3;
                 -g2, g0, g3,-g1;
                 -g1,-g3, g0, g2;
                -g3, g1,-g2, g0]/sq; 
         end