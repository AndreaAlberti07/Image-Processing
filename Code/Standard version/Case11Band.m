%ask to the user which detail it wants to have in output. It can also
%choose to have all of them
band_direction=input('Insert the details wou want to extract : \n1 - Horizontal \n2 - Vertical \n3 - Diagonal \n4 - All\n  - Your choice --> ');


    if img_l==2
        img=img(:,:,1);
        msgbox('The opened image is not gray level. It will be converted into gray level.','WARNING','warn');
    end


if band_direction==4 %if user wants all the details together
    %Indipendentely on if the image is colored or not, if the user wants
    %the 3 details together, the visualization is the same in the sense
    %that details are not classified by colors, but they are unified in the
    %same recontructed detail.
    [img_recH, img_rec1H]=ImBand(img,1); %extract Horizontal details
    [img_recV, img_rec1V]=ImBand(img,2); %extract Vertical details
    [img_recD, img_rec1D]=ImBand(img,3); %extract Diagonal details

    %img_rec and img_rec1 are the same thing, they represent the detail of
    %the original image. The difference is that the two are elaborated in
    %different ways for visualization, so they are visualized differently.
    %Both are displayed since it might be that different information can be
    %extracted from them.

    %showing results
    figure('name','Image and the Horizontal details');
    %Horizontal details
    subplot(3,3,1); imshow(img); title('Original image');
    subplot(3,3,2); imshow(img_recH); title('Horizontal details'); 
    subplot(3,3,3); imshow(img_rec1H); title('Horizontal details');
    
    %Vertical details
    subplot(3,3,4); imshow(img); title('Original image');
    subplot(3,3,5); imshow(img_recV); title('Vertical details');
    subplot(3,3,6); imshow(img_rec1V); title('Vertical details');

    %Diagonal details
    subplot(3,3,7); imshow(img); title('Original image');
    subplot(3,3,8); imshow(img_recD); title('Diagonal details');
    subplot(3,3,9); imshow(img_rec1D); title('Diagonal details');
    set(gcf, 'Position', get(0,'Screensize')); %expand window to full size

elseif img_l==3

    %In the case img is colored and the users choose a particular detail,
    %is displayed not only the detail choosen relative to the entire
    %image, but also the details of the single channels R,G,B to provide
    %more information.
    %In the case user select to visualize all details together the sigle
    %channel details are not displayed

    [img_rec, img_rec1]=ImBand(img,band_direction);
    
    figure('name','Image and the choosen details');
    %global detail (comprehensive of all colors)
    subplot(4,3,1); imshow(img); title('Original image');
    subplot(4,3,2); imshow(img_rec); title('Choosen details');
    subplot(4,3,3); imshow(img_rec1); title('Choosen details');
    %red channel detail
    subplot(4,3,4); imshow(img(:,:,1)); title('Original image - R channel');
    subplot(4,3,5); imshow(img_rec(:,:,1)); title('Choosen details - R channel');
    subplot(4,3,6); imshow(img_rec1(:,:,1)); title('Choosen details - R channel');
    %green channel detail
    subplot(4,3,7); imshow(img(:,:,2)); title('Original image - G channel');
    subplot(4,3,8); imshow(img_rec(:,:,2)); title('Choosen details - G channel');
    subplot(4,3,9); imshow(img_rec1(:,:,2)); title('Choosen details - G channel');
    %blue channel detail
    subplot(4,3,10); imshow(img(:,:,2)); title('Original image - B channel');
    subplot(4,3,11); imshow(img_rec(:,:,3)); title('Choosen details - B channel');
    subplot(4,3,12); imshow(img_rec1(:,:,3)); title('Choosen details - B channel');
    set(gcf, 'Position', get(0,'Screensize'));

else %if users wants only one detail and the image is gray level
    [img_rec, img_rec1]=ImBand(img,band_direction);

    %showing results
    figure('name','Image and the choosen details');
    subplot(1,3,1); imshow(img); title('Original image');
    subplot(1,3,2); imshow(img_rec); title('Choosen details');
    subplot(1,3,3); imshow(img_rec1); title('Choosen details');
    set(gcf, 'Position', get(0,'Screensize'));
end

uiwait()