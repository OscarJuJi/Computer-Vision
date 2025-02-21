clear all all all; clc; close all;
a=imread("TREE.png");
size_a=size(a,2);
a_third=size_a(1)/3;
a_R=a;
a_G=a;
a_B=a;
a_RGB_A=a;
a_RGB_B=a;
a_RGB_C=a;
a_gray=rgb2gray(a);

a_R(:,:,1);
a_G(:,:,2);
a_B(:,:,3);

a_R(:,:,2)=0;
a_G(:,:,1)=0;
a_B(:,:,1)=0;

a_R(:,:,3)=0;
a_G(:,:,3)=0;
a_B(:,:,2)=0;

%Red part
a_RGB_B(a_third:2*a_third,1:400,2)=0;
a_RGB_B(a_third:2*a_third,1:400,3)=0;

%Green part
a_RGB_B(a_third:2*a_third,400:800,1)=0;
a_RGB_B(a_third:2*a_third,400:800,3)=0;

%Blue part
a_RGB_B(a_third:2*a_third,800:1200,1)=0;
a_RGB_B(a_third:2*a_third,800:1200,2)=0;

%%The same but cheaper
%Red part
a_RGB_C(:,1:400,2)=0;
a_RGB_C(:,1:400,3)=0;

%Green part
a_RGB_C(:,400:800,1)=0;
a_RGB_C(:,400:800,3)=0;

%Blue part
a_RGB_C(:,800:1200,1)=0;
a_RGB_C(:,800:1200,2)=0;

%Red part
a_RGB_A(1:400,:,2)=0;
a_RGB_A(1:400,:,3)=0;

%Green part
a_RGB_A(400:800,:,1)=0;
a_RGB_A(400:800,:,3)=0;

%Blue part
a_RGB_A(800:1200,:,1)=0;
a_RGB_A(800:1200,:,2)=0;




chems = imread('Chems.jpg');

% rayas = chems;
% 
% rayas(:, 1:size(rayas,2)*(1/3), 1);
% rayas(:, 1:size(rayas,2)*(1/3), 2)=0;
% rayas(:, 1:size(rayas,2)*(1/3), 3)=0;
% 
% rayas(:, round(size(rayas,2)*(1/3))+1:round(size(rayas,2)*(2/3)), 1)=0;
% rayas(:, size(rayas,2)*(1/3)+1:size(rayas,2)*(2/3), 2);
% rayas(:, size(rayas,2)*(1/3)+1:size(rayas,2)*(2/3), 3)=0;
% 
% rayas(:, size(rayas,2)*(2/3):end, 1)=0;
% rayas(:, size(rayas,2)*(2/3):end, 2)=0;
% rayas(:, size(rayas,2)*(2/3):end, 3);

letra = chems;
% roja
letra(:,1:217,1);
letra(:,1:217,2)=0;
letra(:,1:217,3)=0;

letra(1:229,218:round(size(letra,2)*1/2),1);
letra(1:229,218:round(size(letra,2)*1/2),2)=0;
letra(1:229,218:round(size(letra,2)*1/2),3)=0;

letra(752:end,218:round(size(letra,2)*1/2),1);
letra(752:end,218:round(size(letra,2)*1/2),2)=0;
letra(752:end,218:round(size(letra,2)*1/2),3)=0;

letra(306:453,294:round(size(letra,2)*1/2),1);
letra(306:453,294:round(size(letra,2)*1/2),2)=0;
letra(306:453,294:round(size(letra,2)*1/2),3)=0;

letra(306:453,294:round(size(letra,2)*1/2),1);
letra(306:453,294:round(size(letra,2)*1/2),2)=0;
letra(306:453,294:round(size(letra,2)*1/2),3)=0;

letra(530:675,294:round(size(letra,2)*1/2),1);
letra(530:675,294:round(size(letra,2)*1/2),2)=0;
letra(530:675,294:round(size(letra,2)*1/2),3)=0;

%Verde
letra(230:305,218:518,1)=0;
letra(230:305,218:518,2);
letra(230:305,218:518,3)=0;

letra(306:751,218:293,1)=0;
letra(306:751,218:293,2);
letra(306:751,218:293,3)=0;

letra(676:751,294:518,1)=0;
letra(676:751,294:518,2);
letra(676:751,294:518,3)=0;

letra(454:529,294:443,1)=0;
letra(454:529,294:443,2);
letra(454:529,294:443,3)=0;

%Azul
letra(:,519:end,1)=0;
letra(:,519:end,2)=0;
letra(:,519:end,3);

letra(1:229,round(size(letra,2)*1/2)+1:end,1)=0;
letra(1:229,round(size(letra,2)*1/2)+1:end,2)=0;
letra(1:229,round(size(letra,2)*1/2)+1:end,3);

letra(752:end,round(size(letra,2)*1/2)+1:end,1)=0;
letra(752:end,round(size(letra,2)*1/2)+1:end,2)=0;
letra(752:end,round(size(letra,2)*1/2)+1:end,3);

letra(306:453,369:518,1)=0;
letra(306:453,369:518,2)=0;
letra(306:453,369:518,3);

letra(530:675,369:518,1)=0;
letra(530:675,369:518,2)=0;
letra(530:675,369:518,3);

letra(454:529,444:518,1)=0;
letra(454:529,444:518,2)=0;
letra(454:529,444:518,3);

%%figure(3)
%%imshow(letra);
%% Lectura de imagenes y extraccion de datos
%%figure(4)
img = imread('Tree.jpg');

[height, width, ~] = size(img);
part_height = height/3;

%% Obtencion de canales por seccion

img(1:part_height, :, 1);
img(1:part_height, :, 2)=0;
img(1:part_height, :, 3)=0;

img(part_height+1:part_height*2, :, 1)=0;
img(part_height+1:part_height*2, :, 2);
img(part_height+1:part_height*2, :, 3)=0;

img(part_height*2+1:end, :, 1)=0;
img(part_height*2+1:end, :, 2)=0;
img(part_height*2+1:end, :, 3);

rgb_gray = repmat(a_gray, [1 1 3]);
gren_gray=rgb2gray(a_G);
gren_gray=repmat(gren_gray, [1 1 3]);
a_array=[a a_R; a_G gren_gray];
a_g_g=rgb2gray(a_G);

a_array_2=[rgb_gray a_G;a_R gren_gray];

figure(2);
imshow(a_array_2);

