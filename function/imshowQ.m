function   imshowQ(Q)
% imshowQ shows a quaternion matrix to a picture
     
    A = zeros(size(Q.w)); 
    A(:,:,1) = Q.x; A(:,:,2) = Q.y; A(:,:,3) = Q.z;
    imshow(A);

end

