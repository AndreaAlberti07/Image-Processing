function ContributeThreshold(img,THRESH1)
%This thresholding method cut out all the values that give small contribute to the image
%In particular cut out coefficients whose abs(sum) represent a percentage
%which is smaller than 1-THRESH1. The percentage is computed over the entire abs(sum) of the coefficients values.
    
    [img_r , ~, ~]=size(img);
    img_double=im2double(img);
    img_black=img_double;
    
    %aply the dct 
    img_trans=dct2(img_double);
    img_trans0=img_trans; %store the coefficient matrix to use it later, cause the original will be changed


    % THRESHOLDING --> Applied to entire img_trans not to each blocK
    [img_trans_sorted, index_original_vector]=sort(abs(img_trans(:)),'descend'); %sort img_trans values in 'abs value' by descend
    index=1; %index sarà la posizione in img_trans_sorted dell'elemento a partire dal quale posso eliminare valori
    
    tot_pixels_values=sum(abs(img_trans(:)));
    
    while (sum(abs(img_trans_sorted(1:index)))/tot_pixels_values)<THRESH1 %keep values until their importance does not exceed THRESH1
          index=index+1;
    end
    
    %dato index, index_original_vector(index) mi dice la posizione che
    %quell'elemento aveva all'interno del vettore originario non ordinato.
    %Adesso devo risalire alla posizione in matrice e porre ogni elemento da
    %eliminare = 0.
    
    n_iter=numel(img_trans_sorted)-index; %number of elements to be put to 0
    
    for i=1:n_iter
        index1=index_original_vector(index); %position of a value inside the original not sorted vector
        column=ceil(index1/img_r); %column of that element in the original matrix (img-trans)
        row=mod(index1,img_r); %row in the original image
        if row==0
           row=img_r; %because if mod(index1,img_r)=0, means that values was the last (so last row)
        end
        img_trans(row,column)=0; %set to 0 those coefficients into the coefficients matrix
        img_black(row,column)=0; %this is the original image 'img', where the same coefficients are discarded.
        %it is usefull to show the importance of having the dct. In fact
        %looking at this image will be clear that discarding the same
        %coefficients into the original image without any transform, would
        %end up in a result which would be horrible.
        index=index+1;
    end
    
    %faccio la transformata inversa
    img_rec=idct2(img_trans);
    
    %compute the error
    error=abs(img_double-img_rec);
    error=imadjust(error); %enhancing contrast
    
    %-------- display results ----------
    %in the first figure I apply the same threshold used for the dct_image to
    %the original image. In this way it is evident the difference of crossing
    %out pixels in the original image and crossing out the same pixels (in terms of absolute position) 
    %in a trasformed image
    
    figure('name','Original image vs Original image thresholded');
    subplot(1,2,1); imshow(img_double); title('Orginal');
    subplot(1,2,2); imshow(img_black); title('Thresholded');
    
    figure('name',sprintf('DCT Transform with elimination ratio = %1.2f',n_iter/numel(img_double)));
    subplot(2,2,1); imshow(img_double); freezeColors; title('Original Image');
    subplot(2,2,2); imshow(log(abs(img_trans0)),[]); colormap("jet"); freezeColors; freezeColors(colorbar); title('DCT image');
    subplot(2,2,3); imshow(img_rec); freezeColors; title('Reconstructed image');
    subplot(2,2,4); imshow(error); colormap gray; freezeColors; freezeColors(colorbar); title('Error image'); 

end