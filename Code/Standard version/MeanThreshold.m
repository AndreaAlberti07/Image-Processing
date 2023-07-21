function [img_rec, mask]=MeanThreshold(img)
%take an image 'img' as input, and produces in output 2 different
%thresholded images. In the img_rec1 elements > mean are crossed out, in
%img_rec2 the opposite. All img_rec are unified in the 3D 'img_rec' array and
%'mask' is a 3D array in which are stored the used mask.

    [img_r , img_c, ~]=size(img);
    img=im2double(img);

            % all elements > mean value are crossed out --> mask 1
            % all elements < mean value are crossed out --> mask 2
            
            img_trans=dct2(img);
            mean_value=mean(abs(img_trans(:)));
            mask1=abs(img_trans)<mean_value; %put 1 where condition is respected (< mean)
            mask1(1,1)=1; %keep the DC coefficients always    
            mask2=abs(img_trans)>mean_value; %put 1 where condition is respected (> mean)
            mask2(1,1)=1; %keep the DC coefficients always

            %put 0 where threshold unrespected in img_trans
            img_trans_masked1=zeros(img_r,img_c);
            img_trans_masked1(mask1)=img_trans(mask1);
            img_rec1=idct2(img_trans_masked1);
            
            %put 0 where threshold unrespected in img_trans
            img_trans_masked2=zeros(img_r,img_c);
            img_trans_masked2(mask2)=img_trans(mask2);
            img_rec2=idct2(img_trans_masked2);   

            img_rec=cat(3,img_rec1,img_rec2);
            mask=cat(3,mask1,mask2);
end