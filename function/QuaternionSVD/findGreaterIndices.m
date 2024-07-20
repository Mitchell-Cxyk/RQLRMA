function idx = findGreaterIndices(arr1, arr2)
    % 确保两个数组长度相同
    if length(arr1) ~= length(arr2)
        error('两个数组长度必须相同。');
    end
    
    % 使用逻辑索引查找满足条件的下标
    idx = find(arr2 > arr1);
end