clc %limpia pantalla
clear all all all% limpia todo
close all% cierra todo
warning off all

% COMO LEER Y DESPLEGAR IMAGENES EN PANTALLA
a=imread('TREE.jpg');
[m,n]=size(a)
figure(1)
subplot(2,3,1)
imshow(a)
title('original')


% figure(2)
b=rgb2gray(a);
subplot(2,3,2)
imshow(b)
title('grises')
% 
% figure(3)
  c=im2bw(b);
 subplot(2,3,3)
 imshow(c)
 
% extrayendo caracteristicas de la imagen
roja=a;
roja(:,:,1);
roja(:,:,2)=0;
roja(:,:,3)=0;
subplot(2,3,4)
imshow(roja)

verde=a;
verde(:,:,1)=0;
verde(:,:,2);
verde(:,:,3)=0;
subplot(2,3,5)
imshow(verde)

azul=a;
azul(:,:,1)=0;
azul(:,:,2)=0;
azul(:,:,3);
subplot(2,3,6)
imshow(azul)

%% concatenado arreglos
figure(2)
arreglo=[a roja;verde azul];
imshow(arreglo)

disp('fin de proceso...')