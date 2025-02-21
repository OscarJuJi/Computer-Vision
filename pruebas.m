clc
clear all all
close all
warning off all;

playita=imread("Playita.jpg");
figure(2); subplot(1,1,1);
array=impixel(playita);
array
array(1);
k=1;
for i=1:3
    for j=1:5
        r(i,j)=array(k,1);
        g(i,j)=array(k,2);
        b(i,j)=array(k,3);
        k=k+1;
    end
end 
r
g
b
% introduciendo las clases
c1=[96 101 106 119 102;146 149 154 165 148;169 171 174 180 171];
c2=[2 51 40 67 59; 18 70 60 86 74; 34 66 59 82 67];
c3=[25 18 26 15 22; 67 63 72 58 67; 89 86 95 75 86];
%desconocido=[ 8; 50; 72;] ;


media_rojo=mean(r')
media_rojo=media_rojo'

media_verde=mean(g')
media_verde=media_verde'

media_azul=mean(b')
media_azul=media_azul'

%media_rojo=mean(c1')
%media_rojo=media_rojo'

%media_verde=mean(c2')
%media_verde=media_verde'

%media_azul=mean(c3')
%media_azul=media_azul'

%

% Graficando los datos de las clases
%plot3(c1(1,:),c1(2,:),c1(3,:),'ro','MarkerSize',10,'MarkerFaceColor','r')
%grid on
%hold on
%plot3(c2(1,:),c2(2,:),c2(3,:),'bo','MarkerSize',10,'MarkerFaceColor','b')
%plot3(c3(1,:),c3(2,:),c3(3,:),'yo','MarkerSize',10,'MarkerFaceColor','y')

R_I = input('Enter red value');
G_I = input('Enter green value');
B_I = input('Enter blue value');

desconocido(1)=R_I;
desconocido(2)=G_I;
desconocido(3)=B_I;


% Definir un punto inicial
punto_inicial = desconocido;

% Crear una figura
figura = figure;

% Crear un eje 3D
eje_3d = axes('Parent', figura, 'XLim', [0 400], 'YLim', [0 400], 'ZLim', [0 400]);

plot3(eje_3d,r(1,:),g(1,:),b(1,:),'ro','MarkerSize',10,'MarkerFaceColor','r')
grid on
hold on
plot3(eje_3d,r(2,:),g(2,:),b(2,:),'bo','MarkerSize',10,'MarkerFaceColor','b')
plot3(eje_3d,r(3,:),g(3,:),b(3,:),'yo','MarkerSize',10,'MarkerFaceColor','y')
%R_I
%G_I
%B_I
for i=1:3
    
    distance(i)=sqrt((R_I-media_rojo(i))^2+(G_I-media_verde(i))^2+(B_I-media_azul(i))^2);
    distance(i)
    %media_rojo(i)
    %media_verde(i)
    %media_azul(i)
end 

legend('sky', 'Sand', 'Palm tree','unknow')
if(min(distance)==distance(1))
    disp('The pixel enter is a sky pixel')
    plot3(R_I(1,:),G_I(1,:),B_I(1,:),'ro','MarkerSize',10,'MarkerFaceColor','auto')
end
if(min(distance)==distance(2))
    disp('The pixel enter is a sand pixel')
    plot3(R_I(1,:),G_I(1,:),B_I(1,:),'bo','MarkerSize',10,'MarkerFaceColor','auto')
end
if(min(distance)==distance(3))
    plot3(R_I(1,:),G_I(1,:),B_I(1,:),'bo','MarkerSize',10,'MarkerFaceColor','auto')
    disp('The pixel enter is a palm tree pixel')
end

% Crear tres sliders para modificar las coordenadas del punto
slider_x = uicontrol('Style', 'slider', 'Parent', figura, 'Position', [20 20 200 20], 'Min', 0, 'Max', 255, 'Value', punto_inicial(1));
slider_y = uicontrol('Style', 'slider', 'Parent', figura, 'Position', [20 50 200 20], 'Min', 0, 'Max', 255, 'Value', punto_inicial(2));
slider_z = uicontrol('Style', 'slider', 'Parent', figura, 'Position', [20 80 200 20], 'Min', 0, 'Max', 255, 'Value', punto_inicial(3));

% Agregar una función callback a cada slider para actualizar el punto
set(slider_x, 'Callback', {@update_point, eje_3d, slider_x, slider_y, slider_z, 'x',r,g,b,media_azul,media_rojo,media_verde});
set(slider_y, 'Callback', {@update_point, eje_3d, slider_x, slider_y, slider_z, 'y',r,g,b,media_azul,media_rojo,media_verde});
set(slider_z, 'Callback', {@update_point, eje_3d, slider_x, slider_y, slider_z, 'z',r,g,b,media_azul,media_rojo,media_verde});
disp(' proceso final....');


% Función callback para actualizar el punto
function update_point(src, event, eje_3d, slider_x, slider_y, slider_z, coordenada,r,g,b,media_azul,media_rojo,media_verde)
    punto_actualizado = [get(slider_x, 'Value'), get(slider_y, 'Value'), get(slider_z, 'Value')];
    delete(findall(eje_3d, 'type', 'line')); % borrar la línea anterior
    delete(findall(eje_3d, 'type', 'text'));
    
    plot3(eje_3d,r(1,:),g(1,:),b(1,:),'ro','MarkerSize',10,'MarkerFaceColor','r')
grid on
hold on
plot3(eje_3d,r(2,:),g(2,:),b(2,:),'bo','MarkerSize',10,'MarkerFaceColor','b')
plot3(eje_3d,r(3,:),g(3,:),b(3,:),'yo','MarkerSize',10,'MarkerFaceColor','y')
    set(src, 'Value', punto_actualizado(find('xyz' == coordenada)));
    set(slider_x, 'Value', punto_actualizado(1));
    set(slider_y, 'Value', punto_actualizado(2));
    set(slider_z, 'Value', punto_actualizado(3));

    for i=1:3
    
    distance(i)=sqrt((punto_actualizado(1)-media_rojo(i))^2+(punto_actualizado(2)-media_verde(i))^2+(punto_actualizado(3)-media_azul(i))^2);
   
    distance(i)
    %media_rojo(i)
    %media_verde(i)
    %media_azul(i)
end 

legend('sky', 'Sand', 'Palm tree','unknow')
if(min(distance)==distance(1))
    plot3(eje_3d, punto_actualizado(1), punto_actualizado(2), punto_actualizado(3), 'bo', 'MarkerSize',10, 'MarkerEdgeColor', 'r');
    text(eje_3d, punto_actualizado(1), punto_actualizado(2), punto_actualizado(3), 'The pixel enter is a sky pixel');
end
if(min(distance)==distance(2))
    plot3(eje_3d, punto_actualizado(1), punto_actualizado(2), punto_actualizado(3), 'bo','MarkerSize',10, 'MarkerEdgeColor', 'b');
    text(eje_3d, punto_actualizado(1), punto_actualizado(2), punto_actualizado(3), 'The pixel enter is a sand pixel');
end
if(min(distance)==distance(3))
    plot3(eje_3d, punto_actualizado(1), punto_actualizado(2), punto_actualizado(3), 'bo', 'MarkerSize',10, 'MarkerEdgeColor', 'y');
    text(eje_3d, punto_actualizado(1), punto_actualizado(2), punto_actualizado(3), 'The pixel enter is a palm tree pixel');
end

end