%reduce the contrast in the image applying using imadjust in a proper way 
%on the original values

%check if the mage is color or not
if img_l==1 %if it is grey level

    img_mod=imadjust(img,[],[],0.2);

else %if it is color, do the same but for each channel
    imgR=img(:,:,1); imgG=img(:,:,2); imgB=img(:,:,3); %extract img channels

    %gamma < 1 pushes pixels to higher values
    %gamma > 1 pushes pixels to lower values
    gamma=0.2;

    img_modR=imadjust(imgR,[],[],gamma); %red channel modified
    img_modG=imadjust(imgG,[],[],gamma); %green channel modified
    img_modB=imadjust(imgB,[],[],gamma); %blue channel modified

    img_mod=cat(3,img_modR,img_modG,img_modB); %recreate a rgb recontructed image, sticking together the channels along the 3 dimension
    
end

%display results
figure('name','Figure elaborated');
subplot(2,2,1); imshow(img); title('Original image');
subplot(2,2,2); imshow(img_mod,[0,255]); title('Enhanced image');
subplot(2,2,3); imhist(img); %histogram of the original image
subplot(2,2,4); imhist(img_mod); %histogram of the modified image
uiwait()