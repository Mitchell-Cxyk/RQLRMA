function M = tens2matQ(T,mode_row,mode_col)


% Authors: Hanxin Ya, Yuning Yang (yyang@gxu.edu.cn,
%           yuning.yang1207@gmail.com)

% Reference:
% [1] Hanxin Ya, Ying Wang, Yuning Yang, On Quaternion Higher-Order Singular Value Decomposition: Models and Analysis
%           https://arxiv.org/abs/2309.05211

    if isa(T,'myquaternion')
        M = myquaternion(tens2mat(T.q1,mode_row,mode_col),tens2mat(T.q2,mode_row,mode_col)  );
    else
        M = tens2mat(T,mode_row,mode_col);
    end
end
