%Do the negative of the image inserted and display both original and
%negative image

img_mod=imcomplement(img); %do the complement of the original img

%display results in the same figure
figure('name','Figure elaborated'); 
subplot(1,2,1); imshow(img); title('Original image');
subplot(1,2,2); imshow(img_mod); title('Negative image');
uiwait()