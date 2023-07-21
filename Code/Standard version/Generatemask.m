function [MASK , mask_numbers]=Generatemask(img,N_masks,mask_type)
%This function takes as input: original image 'img', number of masks user
%wants to be realized 'N_masks', the type of masks user wants 'mask_type'.
%The type could be 1 (case 1), 2 (case 2).
%The output is a 3D array 'MASK' in which is level is a different mask of
%the choosen type. Mask_numbers is just a vector of sequential real number
%that indicate the number of the mask.
    
    [img_r, img_c , ~]=size(img);
    mask=ones(img_r,img_c); %initialize array
    MASK=ones(img_r,img_c,N_masks); %initialize array 3D
    mask_numbers=1:1:N_masks; %defining a vector of which each element is a number of mask. It will be used in the error comparaison plot

            switch mask_type

                case 1 %RANDOM
                %Generate a random mask
                %Takes a row and starting from a random point, put to 0 all elements of row
                %Creates 'N_masks' differents mask and store them in
                %multidimensional array 'MASK'
            
                    for z=1:N_masks

                        for i=1:img_r
                            start_from=round((img_c-(img_c/N_masks)*z)+1); %each z cycle, mask is more aggressives
                            start=randi([start_from, img_c]); %define a start column

                            for j=start:img_c %put to 0
                                mask(i,j)=0;
                                mask(j,i)=0;
                            end
                            MASK(:,:,z)=mask; %MASK is not logical yet. It is made logical with the ApplyMask function
                        end
                    end
                    
                    %This is just a raw-algorithm to create masks. It doesn't follow any logic
                    %(except to eliminates more the coefficients with less informations, so
                    %lower right corner) and it is just to see the effects that different types 
                    %of masks have on the image. It could be improved by introducing 
                    %non linear fucntions that determines the line under which the coefficients
                    %must be put to 0. Example a piece of circumference that containes the
                    %upper-left angle, with the DC coefficient.
            
                
            % OTHER OPTION
            
                    %This second option follows a logic. it eliminates the
                    %coefficients in a smarter way, by crreating a "protection" around
                    %the upper-left corner and preserving all these coefficients that
                    %are more importants.
                    
                case 2 %KEEP UPPER LEFT CORNER
            
                    for z=1:N_masks
                     
                        for i=1:img_r
                            start_from=(img_c-(img_c/N_masks)*z)+2; %each z cycle, mask is more aggressives
                            start=round(start_from-(start_from/img_r)*i)+1; %define a start column and each step apply a linear decrement

                            for j=start:img_c %put elements to 0
                                mask(i,j)=0;
                                mask(j,i)=0;
                            end
                            MASK(:,:,z)=mask; %MASK is not logical yet. It is made logical with the ApplyMask function
                        end
                    end
            end
end