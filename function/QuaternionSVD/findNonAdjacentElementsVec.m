function idx = findNonAdjacentElementsVec(A)

% 处理特殊情况：数组太短，无法有相邻元素
if numel(A) < 3
    % 如果数组少于3个元素，所有元素都视为非相邻
    idx = 1:numel(A);
    return;
end

% 初始化逻辑向量，长度与A相同
nonAdjacent = false(size(A));

% 对于中间元素，左右不等于当前元素
nonAdjacent(2:end-1) = (A(2:end-1)-1 ~= A(1:end-2)) & (A(2:end-1) ~= A(3:end)-1);

% 单独处理第一个和最后一个元素
nonAdjacent(1) = A(1) ~= A(2)-1;
nonAdjacent(end) = A(end)-1 ~= A(end-1);

% 返回所有非相邻元素的下标
idx = find(nonAdjacent);

end