clc;
clear;
close all;
warning off;

%Lectura de imagen
p=imread('Paisaje.jpg');

%Lectura de representantes de clases
sky=impixel(p);
trees=impixel(p);
mountains=impixel(p);

%Calculo de medias
media_s=mean(sky);
media_t=mean(trees);
media_m=mean(mountains);
cont=1;

while cont==1
    unknow_point=impixel(p);

    %Graficacion de clases
    plot3(sky(:,1),sky(:,2),sky(:,3),'o','MarkerSize',10,'MarkerFaceColor','b')
    hold on
    grid on
    plot3(trees(:,1),trees(:,2),trees(:,3),'o','MarkerSize',10,'MarkerFaceColor','g')
    plot3(mountains(:,1),mountains(:,2),mountains(:,3),'o','MarkerSize',10,'MarkerFaceColor','y')
    plot3(unknow_point(:,1),unknow_point(:,2),unknow_point(:,3),'o','MarkerSize',10,'MarkerFaceColor','k')
    legend('sky', 'trees', 'mountains','unknow_point')
    hold off
    distance_sky=sqrt((unknow_point(:,1)-media_s(:,1))^2+(unknow_point(:,2)-media_s(:,2))^2+(unknow_point(:,3)-media_s(:,3))^2)
    distance_trees=sqrt((unknow_point(:,1)-media_t(:,1))^2+(unknow_point(:,2)-media_t(:,2))^2+(unknow_point(:,3)-media_t(:,3))^2)
    distance_mountains=sqrt((unknow_point(:,1)-media_m(:,1))^2+(unknow_point(:,2)-media_m(:,2))^2+(unknow_point(:,3)-media_m(:,3))^2)


    if distance_sky<distance_trees && distance_sky<distance_mountains
        disp("The point is in the sky");
    end
    if distance_trees<distance_sky && distance_trees<distance_mountains
        disp("The point is in the trees");
    end
    if distance_mountains<distance_trees && distance_mountains<distance_sky
        disp("The point is in the mountains");
    end
    prompt='Seleccionar otro punto? y/n';
    str=input(prompt,'s');
    switch str
        case 'y','Y';
            cont=1;
        case 'n','N';
            cont=0;
            disp('Hasta luego');
        otherwise
            disp('Opcion no valida');
            cont=0;
    end
end

