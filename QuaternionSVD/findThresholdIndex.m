function index = findThresholdIndex(array, threshold)
    % 验证输入的阈值是否在0和1之间
    if threshold <= 0 || threshold > 1
        error('Threshold must be greater than 0 and less than or equal to 1');
    end
    
    % 计算整个数组的平方和开方（用于之后与阈值相比较）
    totalSumSqrt = norm(array);
    
    % 初始化前缀平方和
    prefixSumSqrt = 0;
    
    % 初始化下标
    index = 0;
    
    % 遍历数组
    for i = 1:length(array)
        % 累加前缀平方和
        %prefixSumSqrt = sqrt(prefixSumSqrt^2 + array(i)^2);
        prefixSumSqrt=norm(array(1:i));
        % 检查比例是否超过阈值
        if prefixSumSqrt / totalSumSqrt >= threshold
            % 设置下标
            index = i-1;
            break;
        end
    end
    
    % 如果循环结束还没有找到满足条件的下标，则返回-1作为错误标志
    if index == 0
        index = -1;
    end
end