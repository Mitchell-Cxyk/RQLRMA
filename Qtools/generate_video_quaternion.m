function [II] =  generate_video_quaternion(num_frame)

fid = fopen('akiyo.yuv','r');
row=176*2;col=144*2; 
frames=num_frame; % total=300
Y=zeros(row,col,frames);
U=zeros(row/2,col/2,frames);
V=zeros(row/2,col/2,frames);
UU=zeros(row,col,frames); 
VV=zeros(row,col,frames);
I=zeros(col,row,num_frame,3);
for frame=1:frames
[Y(:,:,frame),count] = fread(fid,[row,col],'uchar');
[U(:,:,frame),count1]=fread(fid,[row/2,col/2],'uchar');
[V(:,:,frame),count2]=fread(fid,[row/2,col/2],'uchar');
UU(1:2:row-1,1:2:col-1,frame)=U(:,:,frame);
UU(1:2:row-1,2:2:col,frame)=U(:,:,frame);
UU(2:2:row,1:2:col-1,frame)=U(:,:,frame);
UU(2:2:row,2:2:col,frame)=U(:,:,frame);
VV(1:2:row-1,1:2:col-1,frame)=V(:,:,frame);
VV(1:2:row-1,2:2:col,frame)=V(:,:,frame);
VV(2:2:row,1:2:col-1,frame)=V(:,:,frame);
VV(2:2:row,2:2:col,frame)=V(:,:,frame);
R = Y + 1.140 * (VV-128 );
G = Y + 0.395 * (UU-128 ) - 0.581 *(VV-128);
B = Y + 2.032 *(UU-128);
for i=1:row %
for j=1:col
if R(i,j,frame)<0
R(i,j,frame)=0;
end
if R(i,j,frame)>255
R(i,j,frame)=255;
end
if G(i,j,frame)<0
G(i,j,frame)=0;
end
if G(i,j,frame)>255
G(i,j,frame)=255;
end
if B(i,j,frame)<0
B(i,j,frame)=0;
end
if B(i,j,frame)>255
B(i,j,frame)=255;
end
end
end
R=R/255;G=G/255;B=B/255;
I(:,:,frame,1)= R(:,:,frame)';
I(:,:,frame,2) = G(:,:,frame)';
I(:,:,frame,3) = B(:,:,frame)';
% quaternion(zeros(size(R(:,:,frame)')),R(:,:,frame)',G(:,:,frame)',B(:,:,frame)');
% imwrite(I(:,:,frame),['C:\Users\yahan\Desktop\MATLAB\3\',num2str(frame), '.jpg'])
end

II = myquaternion(complex(zeros(size(I(:,:,:,1))),I(:,:,:,1)), complex( I(:,:,:,2),I(:,:,:,3) ) );

end