%enhance the contrast in the original image
%it uses the histogram equalization function

img_mod=histeq(img);

%display results
figure('name','Figure elaborated');
subplot(2,2,1); imshow(img); title('Original image');
subplot(2,2,2); imshow(img_mod); title('Enhanced image');
subplot(2,2,3); imhist(img); %histogram of the original image
subplot(2,2,4); imhist(img_mod); %histogram of the enhanced histogram
