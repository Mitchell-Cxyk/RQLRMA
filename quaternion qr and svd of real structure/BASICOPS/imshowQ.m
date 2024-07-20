function imshowQ(A)
% plot image
% by Zhigang Jia On February 18,2018
[m,n]=size(A);
n=n/4;
im(:,:,1)=A(:,2*n+1:3*n);
im(:,:,2)=A(:,n+1:2*n);
im(:,:,3)=A(:,3*n+1:4*n);
%  figure; 
%  imshow(im);
%  title('Color low-rank L')
%  if norm(A(:,1:n),'inf')>1e-2
%      figure; imshow(A(:,1:n)); title('Grey low-rank L')
%  end
set (gcf,'Position',[0,0,n,m]);
imshow(im,'border','tight','initialmagnification','fit');
