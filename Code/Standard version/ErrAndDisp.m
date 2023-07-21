function ErrAndDisp(Full_img_rec,img,MASK,ratio)   
%This function takes in input the original image 'img' and the Full_img_rec
%which is a 3D array, with n levels. Each level is the reconstruction of
%the original image, masked with different technics. This function compute
%the error between each level and the original image and plot:
%- original image
%- mask applied
%- img reconstructed
%- error
%all for each mask (channel of the vector MASK)
        
if ~exist('ratio','var')
     % third parameter does not exist, so default it to something

     img=im2double(img);
       Full_img_rec=im2double(Full_img_rec);
       [~, ~, N_iter]=size(Full_img_rec);
       mask_numbers=1:1:N_iter; %defining a vector of which each element is a number of mask
       MSE=zeros(1,N_iter); %initialize MSE vector (each element is MSE of a different mask respect to original image)
       SSIM=zeros(1,N_iter); %initialize SSIM vector (each element is SSIM of a different mask)
       PSNR=zeros(1,N_iter); %initialize PSNR vector (each element is PSNR of a different mask)

       for z=1:N_iter

            %compute metrics of error between the reconstructed and the original
            %image
            MSE(z)=immse(Full_img_rec(:,:,z),img);
            SSIM(z)=ssim(Full_img_rec(:,:,z),img);
            PSNR(z)=psnr(Full_img_rec(:,:,z),img);
        
            %improve error visualization
            error=imadjust(img-Full_img_rec(:,:,z));
        
            figure('name',sprintf('Mask number %d',z)); %show the mask number
            subplot(2,3,1); imshow(img); title('Original image');
            subplot(2,3,2); imshow(MASK(:,:,z)); title('Mask applied');
            subplot(2,3,3); imshow(Full_img_rec(:,:,z)); title('Reconstructed image');
            subplot(2,3,4); imshow(error); title('Error image');
            annotation('textbox',[.53 .27 .2 .1], 'String', sprintf(' MSE = %5.4f\n SSIM = %3.2f\n PSNR = %3.2f',MSE(z),SSIM(z),PSNR(z)),'FitBoxToText','on','FontSize',18,'FontWeight','bold','LineWidth',1.5);
            
        end
            
            %plot in one figure the 3 used metrics for each mask generated
            
            figure('name','Error measurement comparaison');
            subplot(1,3,1); plot(mask_numbers,MSE,'b-o','color','r'); title('Mean Square Error'); xlabel('Mask Number'); ylabel('MSE'); 
            subplot(1,3,2); plot(mask_numbers,SSIM,'b-o','color','g'); title('Structure Similarity Index'); xlabel('Mask Number'); ylabel('SSIM'); 
            subplot(1,3,3); plot(mask_numbers,PSNR,'b-o','color','b'); title('Peak Signal to Noise Ratio'); xlabel('Mask Number'); ylabel('PSNR'); 
            set(gcf, 'Position', get(0,'Screensize'));
      
else
       
    %if ratio exists

    img=im2double(img);
       Full_img_rec=im2double(Full_img_rec);
       [~, ~, N_iter]=size(Full_img_rec);
       mask_numbers=1:1:N_iter; %defining a vector of which each element is a number of mask
       MSE=zeros(1,N_iter); %initialize MSE vector (each element is MSE of a different mask respect to original image)
       SSIM=zeros(1,N_iter); %initialize SSIM vector (each element is SSIM of a different mask)
       PSNR=zeros(1,N_iter); %initialize PSNR vector (each element is PSNR of a different mask)

       for z=1:N_iter

            %compute metrics of error between the reconstructed and the original
            %image
            MSE(z)=immse(Full_img_rec(:,:,z),img);
            SSIM(z)=ssim(Full_img_rec(:,:,z),img);
            PSNR(z)=psnr(Full_img_rec(:,:,z),img);
        
            %improve error visualization
            error=imadjust(img-Full_img_rec(:,:,z));
        
            figure('name',sprintf('Mask number %d, Elimination ratio = %1.2f',z,ratio(z))); %show the mask number
            subplot(2,3,1); imshow(img); title('Original image');
            subplot(2,3,2); imshow(MASK(:,:,z)); title('Mask applied');
            subplot(2,3,3); imshow(Full_img_rec(:,:,z)); title('Reconstructed image');
            subplot(2,3,4); imshow(error); title('Error image');
            annotation('textbox',[.53 .27 .2 .1], 'String', sprintf(' MSE = %5.4f\n SSIM = %3.2f\n PSNR = %3.2f',MSE(z),SSIM(z),PSNR(z)),'FitBoxToText','on','FontSize',18,'FontWeight','bold','LineWidth',1.5);
            
        end
            
            %plot in one figure the 3 used metrics for each mask generated
            
            figure('name','Error measurement comparaison');
            subplot(1,3,1); plot(mask_numbers,MSE,'b-o','color','r'); title('Mean Square Error'); xlabel('Mask Number'); ylabel('MSE'); 
            subplot(1,3,2); plot(mask_numbers,SSIM,'b-o','color','g'); title('Structure Similarity Index'); xlabel('Mask Number'); ylabel('SSIM'); 
            subplot(1,3,3); plot(mask_numbers,PSNR,'b-o','color','b'); title('Peak Signal to Noise Ratio'); xlabel('Mask Number'); ylabel('PSNR'); 
            set(gcf, 'Position', get(0,'Screensize'));
end

end