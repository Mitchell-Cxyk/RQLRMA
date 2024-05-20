function T = mat2tensQ(M,size_tens,mode_row,mode_col)

    if isa(M,'myquaternion')
        T = myquaternion(mat2tens(M.q1,size_tens,mode_row,mode_col),mat2tens(M.q2,size_tens,mode_row,mode_col));
    else
        T = mat2tens(M,size_tens,mode_row,mode_col);
    end

end