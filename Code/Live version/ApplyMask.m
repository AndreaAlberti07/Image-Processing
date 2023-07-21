function [img_rec,Elimination_ratio]=ApplyMask(img,MASK)
        %This function takes in input an image img (1 channel) and a
        %3D array MASK which has the same size of img but multiple channel.
        %Each channel of MASK is a mask that is tranformed in logical and
        %it is applied to dct2 of img. the coefficient of dct2 which are in
        %the position of the 1 of MASK are kept, while the others,
        %corresponding to the 0 of MASK are crossed out. The output img_rec
        %is the img which has been transformed, masked and back
        %transformed. Img_rec is 3D array and is channel is the results of
        %the application of a mask (channel) of MASK.
        
        img_trans=dct2(img); %make dct
        [img_r, img_c , ~]=size(img); %take dimension of img
        [~, ~, N_masks]=size(MASK); %compute the N. of iteration of for cycle = N. masks to apply to img_trans

        img_masked=ones(img_r,img_c,N_masks); %preallocate for speed
        img_rec=uint8(ones(img_r,img_c,N_masks)); %preallocate for speed
       

        for z=1:N_masks
            %This part of code just takes the mask and applies it to the img_trans
            mask=logical(MASK(:,:,z)); %transform MASK channel into logical
            masked=zeros(img_r,img_c); %initialize masked
            masked(mask)=img_trans(mask); %keep only the coefficients og img_trans corresponding to 1 in mask and put others to 0
            img_masked(:,:,z)=masked; %save each masked img in different levels of the array img_masked
            img_rec(:,:,z)=uint8(idct2(img_masked(:,:,z))); %do same as before, with inverted image

            N_eliminated_coeffs=sum(sum(MASK(:,:,z)==0)); %compute number of coefficients eliminated (0 value)
            Elimination_ratio(z)=N_eliminated_coeffs/(img_r*img_c);
        end
end