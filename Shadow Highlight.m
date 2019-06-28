clear all;clc;close all;

img=imread('Rock_Climbing_Color.jpg');  % Read Image
temp_img=double(img);   % Convert image to from uint8 to double

R=9;    % Define the radius for Gaussian Blur
n=-floor(3*R):1:floor(3*R);

for i=1:length(n)    
    h1(i)=exp(-(((n(i)).^2))./(2*(R.^2))); 
    h2(i)=exp(-(((n(i)).^2))./(2*(R.^2)));
end
for i=1:length(n)
    hn1(i)=h1(i)./sum(h1);
    hn2(i)=h2(i)./sum(h2);
end

h=hn1'*hn2;                                 % 2D Gaussian
[l1,n1]=size(h);
blur=imfilter(temp_img,h);                  % Applying Filter

mask=255-blur;                              % Mask Creation
figure,imshow(uint8(mask))

a=2.^(1-(mask/128));                        % Slope Calculation
g=255*(temp_img/255).^a;                    % LUT

figure,subplot(1,2,1),imshow(img),title('Original')     % Figure plot
subplot(1,2,2),imshow(uint8(g)),title('Shadow/Highlight R=9')
