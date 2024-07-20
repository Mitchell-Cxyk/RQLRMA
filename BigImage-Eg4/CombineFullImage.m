% 假定所有图像都放在同一个文件夹内，并且具有相同的维度
clear;clc;

folder = './figureSource'; % 图片所在文件夹的路径
filePattern = fullfile(folder, '*.tif'); % 图像文件的格式
files = dir(filePattern); % 获取文件夹内所有jpg文件
StartDirect='LeftBelow';
% 读取第一个图像以获取大小信息
%[sampleImageIndex,map] = imread(fullfile(folder, files(1).name));
%sampleImage=ind2rgb(sampleImageIndex,map);
[sampleImage] = imread(fullfile(folder, files(1).name));
[rows, columns, channels] = size(sampleImage);

%-------------------sketch size----------------------------
Omega_size=400;
Psi_size=800;

%---------------------------------------------------------

% 创建大矩阵，其大小是单个图片大小
bigMatrix = zerosq(rows, columns);
FullImage=zerosq(5*rows, 5*columns);
%Omega=ConstructTestMatrix(5*columns,Omega_size,'Gaussian','entry');

% for iter=1:4
% OmegaCell(:,:,iter)=part(Omega,iter);
% end
% OmegaCell=gpuArray(OmegaCell);
% Omega=quaternion(OmegaCell(:,:,1),OmegaCell(:,:,2),OmegaCell(:,:,3),OmegaCell(:,:,4));

%Psi=ConstructTestMatrix(Psi_size,5*rows,'Gaussian','entry');

% for iter=1:4
% PsiCell(:,:,iter)=part(Psi,iter);
% end
% PsiCell=gpuArray(PsiCell);
% Psi=quaternion(PsiCell(:,:,1),PsiCell(:,:,2),PsiCell(:,:,3),PsiCell(:,:,4));

% LeftSketch=zerosq(Psi_size,5*columns);
% RightSketch=zerosq(5*rows,Omega_size);
% 使用嵌套循环填充大矩阵
if strcmp(StartDirect,'LeftUpper')
for i = 0:4
    for j = 0:4
        index = i * 5 + j + 1; % 计算图像的索引
        if index <= length(files)
            % 读取图像
            % [sampleImageIndex,map] = imread(fullfile(folder, files(index).name));
            % sampleImage=ind2rgb(sampleImageIndex,map);
            % currentImage = quaternion(zeros(size(sampleImage,1),size(sampleImage,2)),sampleImage(:,:,1),sampleImage(:,:,2),sampleImage(:,:,3));
            [sampleImage] = imreadqtodouble(fullfile(folder, files(index).name));
            %imshowQ(sampleImage);
            currentImage = sampleImage;
            % 放置图像在大矩阵的正确位置
            %bigMatrix(i*rows+1:(i+1)*rows, j*columns+1:(j+1)*columns, :) = currentImage;
            if size(currentImage,1)<rows
                if size(currentImage,2)<columns
                    bigMatrix(1:size(currentImage,1),1:size(currentImage,2)) = currentImage;
                else
                    bigMatrix(1:size(currentImage,1),:)=currentImage(:,1:size(bigMatrix,2));
                end
            else
                if size(currentImage,2)<columns
                    bigMatrix(:,1:size(currentImage,2)) = currentImage(1:size(bigMatrix,1),:);
                else
                    bigMatrix=currentImage(1:size(bigMatrix,1),1:size(bigMatrix,2));
                end 
            end
        end

        % for iter=1:4
        %     ACell(:,:,iter)=part(bigMatrix,iter);
        % end
        %     ACell=gpuArray(ACell);
        %     bigMatrix=quaternion(ACell(:,:,1),ACell(:,:,2),ACell(:,:,3),ACell(:,:,4));

        % RightSketch(i*rows+1:(i+1)*rows,:)=RightSketch(i*rows+1:(i+1)*rows,:)+gather(bigMatrix*Omega(j*columns+1:(j+1)*columns,:));
        % LeftSketch(:,j*columns+1:(j+1)*columns)=LeftSketch(:,j*columns+1:(j+1)*columns)+gather(Psi(:,i*rows+1:(i+1)*rows)*bigMatrix);
        % RightSketch(i*rows+1:(i+1)*rows,:)=RightSketch(i*rows+1:(i+1)*rows,:)+bigMatrix*Omega(j*columns+1:(j+1)*columns,:);
        % LeftSketch(:,j*columns+1:(j+1)*columns)=LeftSketch(:,j*columns+1:(j+1)*columns)+Psi(:,i*rows+1:(i+1)*rows)*bigMatrix;
        % bigMatrix = zerosq(rows, columns);
    end
    
end
elseif strcmp(StartDirect,'LeftBelow')
    for i = 0:4
        for j = 0:4
            i
            j
            index = (4-i) * 5 + j + 1; % 计算图像的索引
            if index <= length(files)
                % 读取图像
                % [sampleImageIndex,map] = imread(fullfile(folder, files(index).name));
                % sampleImage=ind2rgb(sampleImageIndex,map);
                % currentImage = quaternion(zeros(size(sampleImage,1),size(sampleImage,2)),sampleImage(:,:,1),sampleImage(:,:,2),sampleImage(:,:,3));
                [sampleImage] = imreadqtodouble(fullfile(folder, files(index).name));
                %imshowQ(sampleImage);
                currentImage = sampleImage;
                % 放置图像在大矩阵的正确位置
                %bigMatrix(i*rows+1:(i+1)*rows, j*columns+1:(j+1)*columns, :) = currentImage;
                if size(currentImage,1)<rows
                    if size(currentImage,2)<columns
                        bigMatrix(1:size(currentImage,1),1:size(currentImage,2)) = currentImage;
                    else
                        bigMatrix(1:size(currentImage,1),:)=currentImage(:,1:size(bigMatrix,2));
                    end
                else
                    if size(currentImage,2)<columns
                        bigMatrix(:,1:size(currentImage,2)) = currentImage(1:size(bigMatrix,1),:);
                    else
                        bigMatrix=currentImage(1:size(bigMatrix,1),1:size(bigMatrix,2));
                    end 
                end
            end
            % RightSketch(i*rows+1:(i+1)*rows,:)=RightSketch(i*rows+1:(i+1)*rows,:)+bigMatrix*Omega(j*columns+1:(j+1)*columns,:);
            % LeftSketch(:,j*columns+1:(j+1)*columns)=LeftSketch(:,j*columns+1:(j+1)*columns)+Psi(:,i*rows+1:(i+1)*rows)*bigMatrix;
            % bigMatrix = zerosq(rows, columns);
            FullImage(i*rows+1:(i+1)*rows,j*columns+1:(j+1)*columns)=bigMatrix;
        end
    end
end
% clear Omega;
% clear bigMatrix;
% save(['data/Sketchmap,',num2str(Omega_size),'.mat'],'RightSketch','LeftSketch','Psi','-v7.3');

% 显示大矩阵
imshowQ(FullImage);

% 如果需要，可以保存此大矩阵为图像
%imwrite(bigMatrix, 'combinedImage.jpg');