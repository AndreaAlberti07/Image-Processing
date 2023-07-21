function [img_rec, img_rec1]=ImBand(img,band_direction)
%This function takes an image, and using wavelet transform extracts the
%detail (band) specified by the user. 1 = horizontal details , 2 = vertical
%details , 3 = diagonal details.

    [img_r, img_c, img_l]=size(img);

    %converting to grey if there is more than one level
    if img_l==1 
        %applying Haar wavelet which is optimal for edge detection
        wn='haar';
        [ca, ch, cv, cd]=dwt2(img,wn);
    
        %extraction of the band specified by user
        switch band_direction
    
            case 1 %extracts horizontal details
                ca=zeros(img_r/2,img_c/2);
                cv=zeros(img_r/2,img_c/2);
                cd=zeros(img_r/2,img_c/2);
    
            case 2 %extracts vertical details
                ca=zeros(img_r/2,img_c/2);
                ch=zeros(img_r/2,img_c/2);
                cd=zeros(img_r/2,img_c/2);
    
            case 3 %extracts diagonal details
                ca=zeros(img_r/2,img_c/2);
                ch=zeros(img_r/2,img_c/2);
                cv=zeros(img_r/2,img_c/2);
    
        end
    
        %reconstructing the image using the inverse wavelet
        img_rec=idwt2(ca, ch, cv, cd, wn);
        img_rec1=imadjust(mat2gray(img_rec)); %improve visualization
        %The difference between img_rec and img_rec1 is only in term of
        %visualization

    else
        %do the same thing but in the case the image is colored. The
        %different thing is that this program will output the border for
        %each single channel, which can deliver more information.

        wn='haar';

        %extract images channels
        [imgR, imgG, imgB]=imsplit(img);

        %apply wavelet to each single channel
        [caR, chR, cvR, cdR]=dwt2(imgR,wn); [caG, chG, cvG, cdG]=dwt2(imgG,wn); [caB, chB, cvB, cdB]=dwt2(imgB,wn);
        
        %extraction of the band specified by user
        zero_r=round(img_r/2); zero_c=round(img_c/2);
            
        switch band_direction

            case 1 %extracts horizontal details
                caR=zeros(zero_r,zero_c); cvR=zeros(zero_r,zero_c); cdR=zeros(zero_r,zero_c);
                caG=zeros(zero_r,zero_c); cvG=zeros(zero_r,zero_c); cdG=zeros(zero_r,zero_c);
                caB=zeros(zero_r,zero_c); cvB=zeros(zero_r,zero_c); cdB=zeros(zero_r,zero_c);
    
            case 2 %extracts vertical details
                caR=zeros(zero_r,zero_c); chR=zeros(zero_r,zero_c); cdR=zeros(zero_r,zero_c);
                caG=zeros(zero_r,zero_c); chG=zeros(zero_r,zero_c); cdG=zeros(zero_r,zero_c);
                caB=zeros(zero_r,zero_c); chB=zeros(zero_r,zero_c); cdB=zeros(zero_r,zero_c);
    
            case 3 %extracts diagonal details
                caR=zeros(zero_r,zero_c); chR=zeros(zero_r,zero_c); cvR=zeros(zero_r,zero_c);
                caG=zeros(zero_r,zero_c); chG=zeros(zero_r,zero_c); cvG=zeros(zero_r,zero_c);
                caB=zeros(zero_r,zero_c); chB=zeros(zero_r,zero_c); cvB=zeros(zero_r,zero_c);
    
        end

        %reconstructing the image using the inverse wavelet
        img_recR=idwt2(caR, chR, cvR, cdR, wn); img_recG=idwt2(caG, chG, cvG, cdG, wn); img_recB=idwt2(caB, chB, cvB, cdB, wn);
        img_rec1R=imadjust(mat2gray(img_recR)); img_rec1G=imadjust(mat2gray(img_recG)); img_rec1B=imadjust(mat2gray(img_recB));
        img_rec=cat(3,img_recR,img_recG,img_recB); %3D array in which each channel is  the reconstructed image of each color RGB
        img_rec1=cat(3,img_rec1R,img_rec1G,img_rec1B); %3D array in which each channel is  the reconstructed image of each color RGB
    end
end
