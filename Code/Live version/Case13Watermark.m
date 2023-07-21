
[name, path]=uigetfile('*.tif;*.tiff;*.jpg;*.jpeg;*.bmp;*.png','Select Message');
message=imread([path name]);
[img_r, img_c, img_l]=size(img);
message=imresize(message,[img_r,img_c]);

[mess_r, mess_c, mess_l]=size(message);

if not(mess_l==img_l)
%     waitfor(msgbox('The message has a different number of channels than the image. Press OK to insert a new message.','WARNING','warn'));
    message = message(:,:,1);
%     [name, path]=uigetfile('*.tif;*.tiff;*.jpg;*.jpeg;*.bmp;*.png','Select Message');
%     message=imread([path name]);
%     message=imresize(message,[img_r,img_c]);
end


%bit levels extractions

B1=bitget(img,1)*2^0;
B2=bitget(img,2)*2^1;
B3=bitget(img,3)*2^2;
B4=bitget(img,4)*2^3;
B5=bitget(img,5)*2^4;
B6=bitget(img,6)*2^5;
B7=bitget(img,7)*2^6;
B8=bitget(img,8)*2^7;

M1=bitget(message,1)*2^0;
M2=bitget(message,2)*2^1;
M3=bitget(message,3)*2^2;
M4=bitget(message,4)*2^3;
M5=bitget(message,5)*2^4;
M6=bitget(message,6)*2^5;
M7=bitget(message,7)*2^6;
M8=bitget(message,8)*2^7;

B=B1+B2+B3+B4+B5+B6+B7+B8;
M=M1+M2+M3+M4+M5+M6+M7+M8;


%watermark application

Bw1=M1;
Bw2=M2;
Bw3=M3;
Bw4=B4;
Bw5=B5;
Bw6=B6;
Bw7=B7;
Bw8=B8;

%watermarked image composition

Bw=Bw1+Bw2+Bw3+Bw4+Bw5+Bw6+Bw7+Bw8;

Difference=histeq(B-Bw);

figure('name','Results'),

subplot(2,2,1); imshow(B); title('Original Image');
subplot(2,2,2); imshow(M); title('Watermark');
subplot(2,2,3); imshow(Bw); title('Watermarked');
subplot(2,2,4); imshow(Difference); title('Difference');