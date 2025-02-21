clc
clear all all
close all
warning off all;


% introduciendo las clases
c1=[96 101 106 119 102;146 149 154 165 148;169 171 174 180 171]
c2=[2 51 40 67 59; 18 70 60 86 74; 34 66 59 82 67]
c3=[25 18 26 15 22; 67 63 72 58 67; 89 86 95 75 86]
desconocido=[ 8; 50; 72;] 


media_rojo=mean(c1')
media_rojo=media_rojo'

media_verde=mean(c2')
media_verde=media_verde'

media_azul=mean(c3')
media_azul=media_azul'

%

% Graficando los datos de las clases
plot3(c1(1,:),c1(2,:),c1(3,:),'ro','MarkerSize',10,'MarkerFaceColor','r')
grid on
hold on
plot3(c2(1,:),c2(2,:),c2(3,:),'bo','MarkerSize',10,'MarkerFaceColor','b')
plot3(c3(1,:),c3(2,:),c3(3,:),'yo','MarkerSize',10,'MarkerFaceColor','y')
plot3(desconocido(1,:),desconocido(2,:),desconocido(3,:),'ko','MarkerSize',10,'MarkerFaceColor','k')
legend('sky', 'rock', 'water','unknow')
disp(' proceso final....')