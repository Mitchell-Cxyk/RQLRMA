function T = mat2tensQ(M,size_tens,mode_row,mode_col)

% Authors: Hanxin Ya, Yuning Yang (yyang@gxu.edu.cn,
%           yuning.yang1207@gmail.com)

% Reference:
% [1] Hanxin Ya, Ying Wang, Yuning Yang, On Quaternion Higher-Order Singular Value Decomposition: Models and Analysis
%           https://arxiv.org/abs/2309.05211

    if isa(M,'myquaternion')
        T = myquaternion(mat2tens(M.q1,size_tens,mode_row,mode_col),mat2tens(M.q2,size_tens,mode_row,mode_col));
    else
        T = mat2tens(M,size_tens,mode_row,mode_col);
    end

end