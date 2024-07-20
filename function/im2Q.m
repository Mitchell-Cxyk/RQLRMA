function [A] = im2Q(img_name)
%IM2Q convert an image to a pure quaternion
 
    A = im2double(imread(img_name));
[m,n,~] = size(A); 
    A = quaternion(zeros(m,n), A(:,:,1),A(:,:,2),A(:,:,3) );

end

