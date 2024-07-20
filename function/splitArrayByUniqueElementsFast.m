function subarrays = splitArrayByUniqueElementsFast(array,threshold)
    % 初始化
    tolerance=threshold;
    %minOccurrences=4;
    % len = length(array);
    % usedIndices = false(len, 1);  % 记录哪些索引已经被用过
    % indicesArrays = {};  % 存储结果的Cell数组

    % for i = 1:len
    %     if ~usedIndices(i)
    %         % 找到与array(i)近似相等的所有元素的索引
    %         approxEqualIndices = find(abs(array - array(i)) < tolerance);
    % 
    %         if length(approxEqualIndices) >= minOccurrences
    %             indicesArrays{end+1} = approxEqualIndices;
    % 
    %             % 标记这些索引已经被处理过，防止重复计数
    %             usedIndices(approxEqualIndices) = true;
    %         end
    %     end
    % end
    arraydiffEven=array(3:end)-array(1:end-2);
    indeces=find(abs(arraydiffEven)<tolerance);
    % arraydiffEven=abs(array(3:2:end)-array(1:2:end-2));
    % arraydiffNearby=abs(array(2:2:end)-array(1:2:end-1));
    % throwdiff=find(arraydiffNearby<1e-14);
    if ~isempty(indeces)
        % 计算数组元素之间的差值
        differences = diff(indeces);
        % 找到差值大于1的地方，这将是不连续的点
        splitPoints = find(differences > 1);
        % 初始化分割后数组的单元数组
        subarrays = {};
        % 计算每一段的起始索引
        startIdx = [1; splitPoints+1];
        % 计算每一段的结束索引
        endIdx = [splitPoints; numel(indeces)];
        % 根据分割点，将数组分割成子数组
        for i = 1:length(startIdx)
            subarrays{i} = [indeces(startIdx(i):endIdx(i));indeces(endIdx(i))+1;indeces(endIdx(i))+2];
        end
    else
        subarrays={};
    end

end