clear;
stImageFilePath  = 'E:\test1\eye36\';
stImageSavePath  = 'E:\test1\';
dirImagePathList = dir(strcat(stImageFilePath,'*.jpg'));        %读取该目录下全部图片的路径（字符串格式）
iImageNum        = length(dirImagePathList);                    %获取图片的总数量
%if iImageNum > 0                                                %批量读入图片，进行五官检測，再批量检測
 %   for i = 1 : iImageNum
 %       iSaveNum      = int2str(i);
 %       stImagePath   = dirImagePathList(i).name;
 %       mImageCurrent = imread(strcat(stImageFilePath,stImagePath));
 %       mFaceResult   = face_segment(mImageCurrent);
 %       imwrite(mFaceResult,strcat(stImageSavePath,iSaveNum,'.jpg')); 
 %   end
%end

mImageCurrent = imread('C:\Users\iair\Desktop\8.jpg');
mFaceResult   = face_segment(mImageCurrent);
imwrite(mFaceResult,'E:\test1\8.jpg'); 