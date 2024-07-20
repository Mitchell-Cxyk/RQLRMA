function nodeGroups = findNodeGroups(edgeList)
    % 创建一个图对象
    G = graph(edgeList(:,1), edgeList(:,2));
    % 找到每个节点所属的连通分量标签
    [bins, binSizes] = conncomp(G);
    % 初始化cell数组
    nodeGroups = cell(1, max(bins));
    % 遍历连通分量，按组分配节点
    for i = 1:max(bins)
        nodeGroups{i} = find(bins == i);
    end
    % 仅保留非空的连通分量
    nodeGroups = nodeGroups(~cellfun('isempty', nodeGroups));
end