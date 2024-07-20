function PSNR=psnrFromErrorF(error,A)
    m=size(A,1);
    n=size(A,2);
    maxPixel=0;
%     for iter=1:numel(A)
%         if abs(A(iter))>maxPixel
%             maxPixel=abs(A(iter));
%         end
%     end
    maxPixel=abs(A(1,1,1));
    PSNR=20*log10((maxPixel*(m*n)^(1/2))/error);
end