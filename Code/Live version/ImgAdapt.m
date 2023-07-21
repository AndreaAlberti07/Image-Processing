function [img_adapted, imgad_r, imgad_c]=ImgAdapt(img,block_dim)
%This function takes in input the original image 'img, and the dimension of
%the sub-block 'block_dim'. It adapts the image to the block dimension, by
%adding rows or columns if necessary. The added rows are created by
%duplicating the last n rows and same thing for the columns.
%imgad_r and imgad_c are respectively the number of rows of the adapted
%image and the number of columns.

        [img_r, img_c, ~]=size(img);

        %how many horizontal and vertical blocks i can create
        H_blocks=floor(img_c/block_dim);
        V_blocks=floor(img_r/block_dim);

        %how many pixels columns / row have to be added
        %block_dim - number of c/r not taken
        NumCol_to_add=block_dim-(img_c-H_blocks*block_dim); 
        NumRow_to_add=block_dim-(img_r-V_blocks*block_dim);
        
        if not(NumCol_to_add ==0)

            %duplicate the last NumCol columns, to make the image
            %img fully compatible with the choosen block dimension in
            %column
            VecCol_to_add=img(:,(img_c-NumCol_to_add+1):img_c);

            %add to the original image the column/rows needed
            img=cat(2,img,VecCol_to_add);
            [img_r, ~]=size(img);
        end

        if not(NumRow_to_add ==0)

            %duplicate the last NumRow rows, to make the image
            %img fully compatible with the choosen block dimension
            VecRow_to_add=img((img_r-NumRow_to_add+1):img_r,:);

            %add to the original image the column/rows needed
            img=cat(1,img,VecRow_to_add);

        end
        [imgad_r, imgad_c]=size(img);
        img_adapted=img;

end