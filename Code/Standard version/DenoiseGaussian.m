function DenoiseGaussian(img)
%this function takes an image 'img' as input and applies to it a Gaussian
%noise. Then denoise this image using the wavelet (put to 0 the details).
%If the image is gray level it shows three subplot: 
%- original image
%- noised image
%- denoised image
%If the image is RGB, it shows the three subplot as the case before, but is
%also displays the same three plot for each channel RGB.
    
    [img_r, img_c, img_l]=size(img);
    img=im2double(img);

%appliying the noise to the original image
    
    img_noised=imnoise(img,'gaussian');
   
    if img_l==1 
        %applying a wavelet
        wn='haar';
        [ca, ch, cv, cd]=dwt2(img_noised,wn);
        
        [zero_r, zero_c]=size(ca);
        %denoise image using wavelet acting on the details H,V,D      
        ch=zeros(zero_r,zero_c);
        cv=zeros(zero_r,zero_c);
        cd=zeros(zero_r,zero_c);
     
        %reconstructing the image using the inverse wavelet
        img_rec=idwt2(ca, ch, cv, cd, wn);
        img_rec1=histeq(img_rec);

        %computing errors
        MSE=immse(img_rec1,img);
        SSIM=ssim(img_rec1,img);
        PSNR=psnr(img_rec1,img);
    
        %display the results
        figure('name','Results of the denoising')
        subplot(1,3,1); imshow(img); title('Original image');
        subplot(1,3,2); imshow(img_noised); title('Noised image');
        subplot(1,3,3); imshow(img_rec1); title('Denoised image');
        annotation('textbox',[.75 .01 .2 .1], 'String', sprintf(' MSE = %5.4f\n SSIM = %3.2f\n PSNR = %3.2f',MSE,SSIM,PSNR),'FitBoxToText','on','FontSize',18,'FontWeight','bold','LineWidth',1.5);
        set(gcf, 'Position', get(0,'Screensize'));

    else
        %do the same thing but in the case the image is colored.

        wn='haar';

        %extract images channels
        [img0R, img0G, img0B]=imsplit(img);
        [imgR, imgG, imgB]=imsplit(img_noised);

        %apply wavelet to each single channel
        [caR, chR, cvR, cdR]=dwt2(imgR,wn); [caG, chG, cvG, cdG]=dwt2(imgG,wn); [caB, chB, cvB, cdB]=dwt2(imgB,wn);
        [zero_r, zero_c]=size(caR);

        %denoise imgae
        chR=zeros(zero_r,zero_c); cvR=zeros(zero_r,zero_c); cdR=zeros(zero_r,zero_c);
        chG=zeros(zero_r,zero_c); cvG=zeros(zero_r,zero_c); cdG=zeros(zero_r,zero_c);
        chB=zeros(zero_r,zero_c); cvB=zeros(zero_r,zero_c); cdB=zeros(zero_r,zero_c);
    
        %reconstructing the image using the inverse wavelet
        img_recR=idwt2(caR, chR, cvR, cdR, wn); img_recG=idwt2(caG, chG, cvG, cdG, wn); img_recB=idwt2(caB, chB, cvB, cdB, wn);
        img_rec1R=imadjust(img_recR); img_rec1G=imadjust(img_recG); img_rec1B=imadjust(img_recB);
        img_rec=cat(3,img_recR,img_recG,img_recB);
        img_rec1=cat(3,img_rec1R,img_rec1G,img_rec1B);

        %computing errors

        [r,c,l]=size(img_rec1);

        if not(r==img_r)
            img_rec1(r,:,:)=[];
        end

        if not(c==img_c)
            img_rec1(:,c,:)=[];
        end


        MSE=immse(img_rec1,img);
        SSIM=ssim(img_rec1,img);
        PSNR=psnr(img_rec1,img);
    
        %display the results
        figure('name','Results of the denoising')
        subplot(4,3,1); imshow(img); title('Original image');
        subplot(4,3,2); imshow(img_noised); title('Noised image');
        subplot(4,3,3); imshow(img_rec1); title('Denoised image');
        subplot(4,3,4); imshow(img0R); title('Original R channel')
        subplot(4,3,5); imshow(imgR); title('Noised R channel')
        subplot(4,3,6); imshow(img_rec1R); title('Denoised R channel')
        subplot(4,3,7); imshow(img0G); title('Original G channel')
        subplot(4,3,8); imshow(imgG); title('Noised G channel')
        subplot(4,3,9); imshow(img_rec1G); title('Denoised G channel')
        subplot(4,3,10); imshow(img0B); title('Original B channel')
        subplot(4,3,11); imshow(imgB); title('Noised B channel')
        subplot(4,3,12); imshow(img_rec1B); title('Denoised B channel')
        annotation('textbox',[.75 .01 .2 .1], 'String', sprintf(' MSE = %5.4f\n SSIM = %3.2f\n PSNR = %3.2f',MSE,SSIM,PSNR),'FitBoxToText','on','FontSize',18,'FontWeight','bold','LineWidth',1.5);
        set(gcf, 'Position', get(0,'Screensize'));
    end

end