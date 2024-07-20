function G1=GRSGivens(g1,g2,g3,g4)
if [g2,g3,g4]==0*[g2,g3,g4]
    G1=eye(4);
else
    G1=REALPM(g1,g2,g3,g4)/norm([g1,g2,g3,g4]);
end