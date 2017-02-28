%% Question 1
image1 = 150 * ones(256,256, 'uint8');
figure, imshow(image1)

%%Question 2
A = [0:255]';
image2 = repmat(uint8(A),1,256);
figure, imshow(image2)

%% Question 3
image3 = repmat(uint8(A'),256,1);
figure, imshow(image3)


%% Question 4
image4 = zeros(256,256, 'uint8');
for i = 1:256
    for j = 1:256
        image4(i,j) = ((i-1)+(j-1))/2 ;
    end
end
figure, imshow(image4)


%% Question 5
image5 = zeros(512,512,'uint8');
image5(1:256,1:256) = image4(1:256,1:256); % upper left
image5(257:512,1:256) = image4(256:-1:1,1:256); % lower left
image5(1:256,257:512) = image4(1:256,256:-1:1); % upper right
image5(257:512,257:512) = image4(256:-1:1,256:-1:1); %lower right
figure, imshow(image5)


%% Question 6
image6 = imread('~/Sample Images/lena.jpg');
figure,imshow(image6)


%% Question 7
[row,column] = size(image6) * 2;
image7 = zeros(row,column,'uint8');
image7(1:256,1:256) = image6(1:256,1:256); % upper left
image7(257:512,1:256) = image6(256:-1:1,1:256); % lower left
image7(1:256,257:512) = image6(1:256,256:-1:1); % upper right
image7(257:512,257:512) = image6(256:-1:1,256:-1:1); %lower right
figure, imshow(image7)

%% Question 8
imwrite(image4,'homework1_4.jpg')

%% Question 9
imwrite(image5,'homework1_5.gif')

%% Question 10
imwrite(image7, 'homework1_7.pgm')


%% Question 11
image11 = zeros(256,256,3,'uint8');
image11(:,:,1) = image2(:,:);
image11(:,:,2) = image3(:,:);
image11(:,:,3) = image4(:,:);
figure, imshow(image11)

%% Question 12
imwrite(image11, 'homework1_11.ppm')

%% Question 13
image13 = imread('~/Sample Images/lena_color.jpg');

%% Question 14
y = size(image13)*2
image14 = zeros(y(1),y(2),y(3)/2,'uint8');
image14(1:256,1:256,:) = image13(1:256,1:256,:); % upper left
image14(257:512,1:256,:) = image13(256:-1:1,1:256,:); % lower left
image14(1:256,257:512,:) = image13(1:256,256:-1:1,:); % upper right
image14(257:512,257:512,:) = image13(256:-1:1,256:-1:1,:); %lower right
figure, imshow(image14)

%% Question 15
imwrite(image14, 'homework1_14.pnm')


x = input('Enter any key to close all figures: ')
close all 





