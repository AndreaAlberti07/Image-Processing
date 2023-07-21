if not(img_l==1) %if the image is not gray level
    msgbox('The opened image is not gray level. It will be converted into gray level.','WARNING','warn');
    img=rgb2gray(img); %convert it to gray level
end

disp('You can select among different types of threshold, choose the one you want, inserting the number below : ')
disp('- 1 : threshold applied to sub-image blocks');
disp('- 2 : threshold applied to entire image directly');
case_selected=input('- Your choice --> ');

switch case_selected
    
    case 1 %this threshold is applied to sub-images of choosen dimension
        %ask to the user a block dimension it prefers
        disp('');
        block_dim=input('Insert the sub-block dimension you prefer (block is squared nxn) : ');

        disp('Please choose an option : ')
        disp('- 1 : threshold based on mean value - over(fig 1) / under(fig 2) mean crossed out');
        disp('- 2 : threshold based on max value - over(fig 1) / under(fig 2) max crossed out');
        disp('- 3 : threshold based on variance and mean - over(fig 1) / under(fig 2) mean+-2var crossed out');
        case_selected=input('- Your choice --> ');
        
        %adapt the image to the choosen block dimension
        [img_adapted, img_r, img_c]=ImgAdapt(img,block_dim);
        
        Row_img_rec=[]; Full_img_rec=[]; %helpfull later 
        Row_mask=[]; Full_mask=[]; %helpfull later
        
        for i=1:block_dim:img_r %moving along the rows

                for j=1:block_dim:img_c %moving along the columns
                    block=img_adapted((i:i+block_dim-1),(j:j+block_dim-1)); %see function definition
                    
                    switch case_selected
            
                        case 1       
                            %functions defined in its file
                            [block_rec, mask]=MeanThreshold(block);
                            
                        case 2
                            %functions defined in its file
                            [block_rec, mask]=MaxHalfThreshold(block);
                        
                        case 3
                            %functions defined in its file
                            [block_rec, mask]=SigmaThreshold(block);

                    end
                            
                    
                    Row_img_rec=cat(2,Row_img_rec,block_rec); %creates a multidimensional array in which each level is a row of the image 'img' filtered and reconstructed
                    Row_mask=cat(2,Row_mask,mask); %creates a multidimensional array, in which each level is a row of the applied mask
                    %during the cycle these arrays will acquire a
                    %new block at each step, till creating an
                    %entire row of block_dim-by-img_c dimensions with multiple
                    %layers
                end
                
            Full_img_rec=cat(1,Full_img_rec,Row_img_rec); %array multidimensionale. Ogni livello è l'immagine originale, mascherata e ricostruita
            Row_img_rec=[]; %azzero altrimenti ho problemi nel riniziare il ciclo j
            Full_mask=cat(1,Full_mask,Row_mask); %3D array, each layer is a rappresentation of the mask applied to each sub-block
            Row_mask=[];
            %these arrays at each iteration aquire an entire row of size
            %block_dim-by-img_c (Row_img_rec and Row_mask) and at the end will
            %contain multiple channels, each one rapresenting the
            %mask applied to each sublock, or the img_reconstructed
   
        end

        %see function file for details
        ErrAndDisp(Full_img_rec,img_adapted,Full_mask); 
        uiwait()


    case 2 %more advanced threshold, but applied to entire image
        disp('- 1 : threshold based on importance');
        disp('- 2 : threshold based on number of coefficients');
        case_selected=input('- Your choice --> ');

        switch case_selected
             case 1
                 THRESH1=input('Insert information percentage you want to keep (between 0 and 1) : ');
                 ContributeThreshold(img,THRESH1); %see function file

             case 2
                 PERCENTAGE_KEPT=input('Insert the percentage (from 0 to 1) of coefficients you want to keep : ');
                 NumelThreshold(img,PERCENTAGE_KEPT); %see function file
        end
end