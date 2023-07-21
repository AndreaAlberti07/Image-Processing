function [img_rec, mask]=PercentageThreshold(img,PERCENTAGE)
%takes an image 'img' as input, and produces in output 2 different
%thresholded images. In the img_rec1 elements > PERCENTAGE*max are crossed out, in
%img_rec2 the opposite. All img_rec are unified in the 3D img_rec array and
%mask is a 3D array in which are stored the used masks.

    [img_r , img_c, ~]=size(img);
    img=im2double(img);

        % all elements > PERCENTAGE*max are crossed out
        % all elements < PERCENTAGE*max are crossed out

        img_trans=dct2(img);
        maximum=max(img_trans(:));
        mask1=img_trans<maximum*PERCENTAGE; %put 1 where condition is respected
        mask1(1,1)=1; %keep the DC coefficient
        mask2=img_trans>(maximum*PERCENTAGE); %put 1 where condition is respected
        mask2(1,1)=1; %keep DC coefficient

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