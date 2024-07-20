clc;clear;
file_path='C:\Users\cxyk3\Documents\MatlabSrc\SyntheticData\dataAll\figure';%待转换图片位置
All_pic=dir(file_path);%所有图片文件的信息。
All_pic(1)=[];All_pic(1)=[];

for NN=1:size(All_pic)
    file_info=All_pic(NN);%一张图片的信息
    file_name=file_info.name;%图片的名字
    full_file_name=[file_path,'\',file_name];%图片的全名
    uiopen(full_file_name,1);
    name_size=size(file_name);
    for NNN=1:name_size(2)
        if file_name(NNN)=='.'
            name_num=NNN;%记下点的位置
        end
    end
    new_name=file_name(1:name_num-1);%点之前的部分
    str=['C:\Users\cxyk3\Documents\Paper-LaTex\siamart_sisc\sm_figure\synethetic\',new_name];
    export_fig(str,'-eps');
    close ;
end