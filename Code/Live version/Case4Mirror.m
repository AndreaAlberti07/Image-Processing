% Take the image and mirror it
img_mod=uint8(zeros(img_r,img_c)); %initialize img_mod


%check if the image is color or grey level
if img_l==1 %if it is grey level
    for i=1:img_r %for each row do:
        for j=1:img_c %take the pixels on the right and place them at the place of left pixels
        img_mod(i,j)=img(i,img_c+1-j); %example: the last on right is put at the place of the first on left
        end
    end
else %if the image is colored, do the same but for each channel
    for z=1:img_l %do as above but for each channel
        for i=1:img_r
            for j=1:img_c
                img_mod(i,j,z)=img(i,img_c+1-j,z);%z is the channel
            end
        end
    end
end

%display results
figure('name','Figure elaborated');
subplot(1,2,1); imshow(img); title('Original image');
subplot(1,2,2); imshow(img_mod); title('Mirrored image');
