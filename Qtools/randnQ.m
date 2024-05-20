function [qt] = randnQ(sz_tens)
% generate a quaternion tensor with every entry being N(0,1)
    qt = quaternion(randn(sz_tens),randn(sz_tens),randn(sz_tens),randn(sz_tens));  
end

