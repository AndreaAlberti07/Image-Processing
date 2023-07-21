%If the image is grey apply to it a colormap, if RGB converts it to gray-level
%it converts to grey also images that have 2 channels

if  (img_l==3) %image has more than 1 channel
    imgRGB=rgb2gray(img); %converts it to gray level

    %display the results
    figure('name','Figure elaborated');
    subplot(1,2,1); imshow(img); title('Original image');
    subplot(1,2,2); imshow(imgRGB); title('Gray level image')

else %image is not RGB

    if (img_l==2)
        img=img(:,:,1);
    end
    
    selected_option=input('Do you want to assign more importance to:\n1 - Red channel \n2 - Green channel \n3 - Blue channel \n4 - Random\n  - Your Choice : ');

    switch selected_option
    
        case 1
            r_intensity=1; g_intensity=1/2; b_intensity=1/2;
        case 2
            r_intensity=1/2; g_intensity=1; b_intensity=1/2;
        case 3
            r_intensity=1/2; g_intensity=1/2; b_intensity=1;
        case 4
            r_intensity=rand(); g_intensity=rand(); b_intensity=rand();
    
    end
        
        %modify manually each channel
        imgR=img.*r_intensity; imgG=img.*g_intensity; imgB=img.*b_intensity;
        imgRGB=cat(3,imgR,imgG,imgB);
        imgRGB=im2double(imgRGB);

        %apply a colormap
        cmap=hsv(256); %define the colormap to be applied
        img_mod=ind2rgb(img,cmap); %apply the choosen colormap

        %display the results
        figure('name','Figure elaborated');
        subplot(1,3,1); imshow(img); title('Original image');
        subplot(1,3,2); imshow(abs(imgRGB)); title('Colored image');
        subplot(1,3,3); imshow(img_mod); title('Colormap image')

end
uiwait()