% 定义张量来存放所有数据
allData = zeros(20914, 20000, 3);

% 循环读取每个.mat文件
for i = 1:10
    % 构建文件名（这里假设文件命名为file1.mat, file2.mat, ..., file10.mat）
    indexStore=[2000,4000,6000,8000,10000,12000,14000,16000,18000,20000];
    filename = sprintf(['dataStore_',num2str(indexStore(i)),'.mat']);
    
    % 加载.mat文件
    loadedData = load(filename);
    
    % 假设每个.mat文件中的变量命名为cellArray
    cellArray = loadedData.StoreData; 
    
    % 检查cell数组大小
    if size(cellArray, 1) ~= 2000 || size(cellArray{1}, 1) ~= 20914 || size(cellArray{1}, 2) ~= 3
        error('数据维度与预期不符。请检查%s文件的内容。', filename);
    end
    
    % 提取并存储数据
    for j = 1:size(cellArray, 1) % 遍历cell数组
        idx = (i-1)*2000 + j; % 计算当前三阶张量的第二维索引
        allData(:, idx, :) = cellArray{j};
    end
end
DataQ=quaternion(zeros(size(allData,1),size(allData,2)),allData(:,:,1),allData(:,:,2),allData(:,:,3));

% 保存所有数据到新的.mat文件
save('DataQ.mat', 'DataQ');