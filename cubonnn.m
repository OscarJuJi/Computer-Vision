clc
clear 
close all; 
warning off all;
clase1=[0,0,0;1,0,0;1,0,1;1,1,0];
clase2=[0,0,1;0,1,0;0,1,1;1,1,1];
media_c1=mean(clase1);
media_c2=mean(clase2);
si=1;
while (si==1)
    vector = input('Ingrese un vector de la forma [x y z]: ');
    puntox=vector(1);
    puntoy=vector(2);
    puntoz=vector(3);
    Punto=[puntox,puntoy,puntoz];
    distance_c1=sqrt((Punto(:,1)-media_c1(:,1))^2+(Punto(:,2)-media_c1(:,2))^2+(Punto(:,3)-media_c1(:,3))^2);
    distance_c2=sqrt((Punto(:,1)-media_c2(:,1))^2+(Punto(:,2)-media_c2(:,2))^2+(Punto(:,3)-media_c2(:,3))^2);
    if(distance_c1>distance_c2 && distance_c2<sqrt(2))
        disp("el punto esta en clase 2");
    end
    if(distance_c1<distance_c2 && distance_c2<sqrt(2))
        disp("el punto esta en clase 1");
    end
    if(distance_c2>=sqrt(2))
        disp("el punto no esta en ninguna clase");
    end
        plot3(clase1(:,1),clase1(:,2),clase1(:,3),'o','MarkerSize',10,'MarkerFaceColor','r');
        hold on;
        plot3(clase2(:,1),clase2(:,2),clase2(:,3),'o','MarkerSize',10,'MarkerFaceColor','b');
        plot3(Punto(:,1),Punto(:,2),Punto(:,3),'o','MarkerSize',10,'MarkerFaceColor','k');
        legend('Clase 1', 'Clase 2');
        grid on;
        si = input('Desea ingresar otro vector');

end