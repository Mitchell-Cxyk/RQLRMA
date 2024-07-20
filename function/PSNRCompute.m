function PSNR=PSNRCompute(A,appA)
    m=size(A,1);
    n=size(A,2);
    maxPixel=0;
    for iter=1:numel(A)
        if abs(A(iter))>maxPixel
            maxPixel=abs(A(iter));
        end
    end
    PSNR=20*log10((maxPixel*(m*n)^(1/2))/norm(A-appA,'fro'));
end

