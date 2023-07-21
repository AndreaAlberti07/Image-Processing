if not(img_l==1) %if the image is not gray level
    msgbox('The opened image is not gray level. It will be converted into gray level.','WARNING','warn');
    img_gray=rgb2gray(img); %convert it to gray level
end


THRESH1=input('Insert information percentage you want to keep (between 0 and 1) : ');
ContributeThreshold(img_gray,THRESH1); %see function file

