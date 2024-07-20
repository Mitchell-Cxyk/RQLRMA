function gap = GenerateGap(value)
if value<1e-15
    gap=1e-10;
else
    gap=0.5*10^(-8/10*log10(value)-8);
    gap=gap*value;
end
end