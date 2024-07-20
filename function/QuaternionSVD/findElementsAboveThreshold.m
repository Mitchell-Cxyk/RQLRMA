function [rowIdx, colIdx] = findElementsAboveThreshold(matrix, threshold)
    % 找出矩阵中大于阈值的元素的逻辑索引
    logicalIndexes = matrix > threshold;
    
    % 使用find函数同时获取行和列的索引
    [rowIdx, colIdx] = find(logicalIndexes);
end