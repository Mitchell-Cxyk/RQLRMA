function M = tens2matQ(T,mode_row,mode_col)
    if isa(T,'myquaternion')
        M = myquaternion(tens2mat(T.q1,mode_row,mode_col),tens2mat(T.q2,mode_row,mode_col)  );
    else
        M = tens2mat(T,mode_row,mode_col);
    end
end
