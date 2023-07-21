function NumelThreshold(img,PERCENTAGE_KEPT)
%This function takes as input the original image 'img' and a
%PERCENTAGE_KEPT which is a percentage. The function does the dct2 of img
%and then discard a certain number of coefficients, keeping only the
%percentage of the total number of coefficients specified by
%PERCENTAGE_KEPT. The coefficients are not eliminated randomly. They are
%sorted by decreasing order and only the last x coefficients are
%eliminated. So the idea is to eliminate the coefficients related to the
%high frequencies and as a results the lost information regard the border
%of the original image.
        
        [img_r, img_c, ~]=size(img);
        img=im2double(img);
        img_black=img; %store img cause it will be modified by next steps
        img_trans=dct2(img); %do the transform
        img_trans0=img_trans; %store img_trans cause it will be modified
        
        %sort the coefficients of img_trans
        [~, index_original_vector]=sort(abs(img_trans(:)),'descend');
        %compute the position inside index_original_vector from which we can
        %start eliminating coefficients. 
        index_original_vector_position=round(img_r*img_c*PERCENTAGE_KEPT); %the first x coefficients, corresponding to PERCENTAGE_KEPT of the total (img_r*img_c) are kept
        num_discarded=0; %initialize variable
        
        for i=(index_original_vector_position):(numel(index_original_vector)) %starting from the above computed position discard coefficients
            %starting from the index vector produced by 'sort' go back to
            %the position of each element in the img_trans matrix
            index=index_original_vector(i);
            column=ceil(index/img_r);
            row=mod(index,img_r);
            if row==0
                row=img_r;
            end
            img_trans(row,column)=0; %put element to 0
            img_black(row,column)=0; %put element to 0
            num_discarded=num_discarded+1; %compute the number of coefficients discarded
        end
        
        I_inverse=idct2(img_trans);
       
        %-------- Computing error --------
        
        error=abs(img-I_inverse);
        error=imadjust(error); %better visualization
        
        %--------- Display results ------------
        %in the first figure I apply the same threshold used for the dct_image to
        %the original image. In this way it is evident the difference of crossing
        %out pixels in the original image and crossing out the same pixels (in terms of absolute position) 
        %in a trasformed image
    
        figure('name','Original image vs Original image thresholded');
        subplot(1,2,1); imshow(img); title('Orginal');
        subplot(1,2,2); imshow(img_black); title('Thresholded');
        
        figure('name',sprintf('DCT Transform with %d elements discarded',num_discarded));
        subplot(2,2,1); imshow(img); title('Original Image');
        subplot(2,2,2); imshow(log(abs(img_trans0)),[]); colormap jet; freezeColors; freezeColors(colorbar); title('DCT image');
        subplot(2,2,3); imshow(I_inverse); title('Reconstructed image');
        subplot(2,2,4); imshow(error); colormap gray; freezeColors; colorbar; title('Error image');

end