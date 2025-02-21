clear all;
clc;
close all;


%% Lectura de imagenes y extraccion de datos
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

imshow(img);
