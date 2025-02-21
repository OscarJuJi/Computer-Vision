clc 
clear all
close all
warning off all
%lectura de la imagen
h=imread('Playita.jpg');
figure(1);
[m,n]=size(h);
imshow(h);
figure(2)
dato=imref2d(size(h));
imshow(h,dato);
 %clx=randi([0,800],1,100);
 %cly=randi([500,800],1,100);
 c3x=randi([0,800],1,100);
 c3y=randi([500,800],1,100);
 c2x=randi([150,710],1,100);
 c2y=randi([300,450],1,100);
 z1=impixel(h,clx(1,:),cly(1,:));

clx=randi([400,800],1,100);
cly=randi([0,600],1,100);

hold on;
grid on;

plot(clx(1,:),cly(1,:),'ob','MarkerSize',10,'MarkerFaceColor','r');
plot(c2x(1,:),c2y(1,:),'ob','MarkerSize',10,'MarkerFaceColor','b');
plot(c3x(1,:),c3y(1,:),'ob','MarkerSize',10,'MarkerFaceColor','g');
legend('clase1','clase2','clase3','punto');
disp('fin  de proceso');
