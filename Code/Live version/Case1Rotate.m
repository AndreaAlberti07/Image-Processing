% Rotate image by an angle choosen by the user. Display both original and
% rotated image

angle=input('Insert the rotation angle : '); %take angle as input
img_mod=imrotate(img,angle); %rotate the image by the choosen angle

%display the results
figure()
subplot(1,2,1); imshow(img); title('Original image');
subplot(1,2,2); imshow(img_mod); title(sprintf('Figure rotated by %d degrees',angle)); %display the modified image and the degrees