function [qt] = generate_randn_qtensor(sz_tens)
%GENERATE_RANDN_QTENSOR 此处显示有关此函数的摘要
%   此处显示详细说明
    qt = quaternion(randn(sz_tens),randn(sz_tens),randn(sz_tens),randn(sz_tens));  
end

