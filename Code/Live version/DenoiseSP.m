function DenoiseSP(img)
%this function takes an image, applies a Salt and Pepper noise selected, then displays the results 
%showing
% - the original image and the original denoised (so it can be used to
% denoise an already noised image uploaded by the user)
% - the noised image (the original with a SP noise applied) and its denoised version.
    
    [~, ~, img_l]=size(img);

%appliying the noise to the original image

    img_noised=imnoise(img,'salt & pepper');

%determine if the image is gray-level or color, and then applying a
%salt&pepper denoise method depending on the case we are in

    if img_l==1 %if image is gray level
       img_filtered=medfilt2(img_noised,[3 3]); %apply a median filter on 3-by-3 sub-blocks
        
       %create a mask putting 1 where the salt and pepper noise is present
       %in the original image 'img', so where there are 0 or 255 values.
       mask=(img==0 | img==255); %it is a logical array
       img_no_noise=img;
       img_no_noise(mask)=img_filtered(mask); %replace the noised pixels with the median, the other pixels are left unchanged, so that they are loyal to original image values

       %computing error
        MSE=immse(img_no_noise,img);
        SSIM=ssim(img_no_noise,img);
        PSNR=psnr(img_no_noise,img);

       %display results
        figure('name','Results of different denoising methods')
        subplot(1,3,1); imshow(img); title('Original image');
        subplot(1,3,2); imshow(img_noised); title('Noised image');
        subplot(1,3,3); imshow(img_no_noise); title('Median filter');
        annotation('textbox',[.7 .15 .2 .1], 'String', sprintf(' MSE = %5.4f\n SSIM = %3.2f\n PSNR = %3.2f',MSE,SSIM,PSNR),'FitBoxToText','on','FontSize',18,'FontWeight','bold','LineWidth',1.5);
        set(gcf, 'Position', get(0,'Screensize'));

    else %if the image is not gray level
        %splitting the image into channels
        [channelR, channelG, channelB]=imsplit(img_noised);

        %apply a median filter to each single channel
        img_filteredR=medfilt2(channelR);
        img_filteredG=medfilt2(channelG);
        img_filteredB=medfilt2(channelB);

        %computing a logical mask on each single channel
        maskR=(channelR==0 | channelR==255);
        maskG=(channelG==0 | channelG==255);
        maskB=(channelB==0 | channelB==255);

        %replacing the noised pixels with their median value [3 3] for each
        %single channel
        img_no_noiseR=channelR;
        img_no_noiseR(maskR)=img_filteredR(maskR);
        img_no_noiseG=channelG;
        img_no_noiseG(maskG)=img_filteredG(maskG);
        img_no_noiseB=channelB;
        img_no_noiseB(maskB)=img_filteredB(maskB);

        %unifying channel
        img_no_noise=cat(3,img_no_noiseR,img_no_noiseG,img_no_noiseB);

        %computing error
        MSE=immse(img_no_noise,img);
        SSIM=ssim(img_no_noise,img);
        PSNR=psnr(img_no_noise,img);

        %displaying results
        figure('name','Results of different denoising methods')
        subplot(1,3,1); imshow(img); title('Original image');
        subplot(1,3,2); imshow(img_noised); title('Noised image');
        subplot(1,3,3); imshow(img_no_noise); title('Median filter');
        annotation('textbox',[.7 .15 .2 .1], 'String', sprintf(' MSE = %5.4f\n SSIM = %3.2f\n PSNR = %3.2f',MSE,SSIM,PSNR),'FitBoxToText','on','FontSize',18,'FontWeight','bold','LineWidth',1.5);
        set(gcf, 'Position', get(0,'Screensize'));

    end  

end