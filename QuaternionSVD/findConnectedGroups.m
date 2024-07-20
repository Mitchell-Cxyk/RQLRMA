function groups = findConnectedGroups(edges)
    n = max(edges(:)); % 找到节点的最大值
    visited = false(1, n); % 记录访问过的节点
    groups = {}; % 存储所有的连通组
    for i = 1:n
        if ~visited(i)
            startNode = i;
            group = dfs(edges, startNode, visited);
            groups{end+1} = group;
            visited([group]) = true; % 更新这些节点为已访问
        end
    end
end

function group = dfs(edges, node, visited)
    group = node;
    visited(node) = true;
    % 找到所有与当前节点相连的节点
    connectedNodes = unique([edges(edges(:,1)==node, 2); edges(edges(:,2)==node, 1)]);
    for i = 1:length(connectedNodes)
        if ~visited(connectedNodes(i))
            group = [group, dfs(edges, connectedNodes(i), visited)]; % 递归搜索
        end
    end
    group = unique(group); % 确保组内节点是唯一的
end