# RQLRMA

## Requirments:
Before Running， please:

1. Download CFD Data from https://drive.google.com/drive/folders/14tOb7NjfFLBfp685MDVOSAnlpMTdi1dJ?usp=drive_link
2. Download figureSource Folder from https://drive.google.com/drive/folders/1YoCgwb9KUALzwNR1YbmZzSfdEtIdZBGO?usp=drive_link
3. Install QTFM Toolbox, we also offer it in folder.
4.Add all files in workfolder.

then put the DataQ.mat(It in the CFD Data Folder) in BigCFD-Eg2 Folder, and put the figureSource Folder in BigImage-Eg4.

## Running
You can run the run.m in the main folder to run all experiments except BigImage.

**Be careful**
Please run the BigImage experiment carefully, it may cost much memory and time. please run the RunExampleAndPaint.m and wait. Even though our linear update have reduce the memory requirement, the computation of approximation error need to input two full image, which may cost much memory(may more than 64GB).

All figures you can found in the special folders as '*.fig' or '*.png'.

Coded by: Chao Chang
Guangxi Unvi. Nanning, China.
Contact: cxyk3333@163.com
Created: July 20, 2024.
If you have any problem, please contact Chao Chang via cxyk3333@163.com.
