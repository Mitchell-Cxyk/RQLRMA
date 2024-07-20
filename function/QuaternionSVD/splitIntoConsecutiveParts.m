function parts = splitIntoConsecutiveParts(arr)
    % 计算数组中相邻元素之间的差异
    diffs = diff(arr);
    
    % 找出差异不为1的位置，这些位置是序列的断点
    breakPoints = [0, find(diffs ~= 1), numel(arr)];
    
    % 预分配cell数组以存储结果，直接使用断点的数量来预分配大小
    numParts = numel(breakPoints) - 1;
    parts = cell(1, numParts);
    
    % 使用找到的断点位置分割数组
    for k = 1:numParts
        parts{k} = arr((breakPoints(k) + 1):breakPoints(k + 1));
    end
end