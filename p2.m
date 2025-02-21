clc
clear all all
close all
warning off all;

playita=imread("Paisaje.jpg");
figure(2); subplot(1,1,1);
array=impixel(playita);
array;
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
r;
g;
b;

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


userInput=1;
Label1=input('Ingrese le nombre de la calse 1\n','s');
Label2=input('Ingrese le nombre de la calse 2\n','s');
Label3=input('Ingrese le nombre de la calse 3\n','s');
Label1
% Crear una figura
figura = figure;

% Crear un eje 3D
eje_3d = axes('Parent', figura, 'XLim', [0 400], 'YLim', [0 400], 'ZLim', [0 400]);

grid on
hold on

%R_I
%G_I
%B_I
legend(Label1, Label2, Label3,Label1);
while(userInput==1)
        delete(findall(eje_3d, 'type', 'line')); % borrar la línea anterior
    delete(findall(eje_3d, 'type', 'text'));
    plot3(eje_3d,r(1,:),g(1,:),b(1,:),'ro','MarkerSize',10,'MarkerFaceColor','r')

plot3(eje_3d,r(2,:),g(2,:),b(2,:),'bo','MarkerSize',10,'MarkerFaceColor','b')
plot3(eje_3d,r(3,:),g(3,:),b(3,:),'yo','MarkerSize',10,'MarkerFaceColor','y')
    disp('Enter a 3D point take on count that x is the red component, y is the green component and z is the blue component ');
    disp('Enter a point');
    figure(3);
    Point=impixel(playita);
    R_I = Point(1);
    G_I = Point(2);
    B_I = Point(3);
    desconocido(1)=R_I;
desconocido(2)=G_I;
desconocido(3)=B_I;
% Definir un punto inicial
punto_inicial = desconocido;
    for i=1:3
    
    distance(i)=sqrt((R_I-media_rojo(i))^2+(G_I-media_verde(i))^2+(B_I-media_azul(i))^2);
    distance(i)
    %media_rojo(i)
    %media_verde(i)
    %media_azul(i)
    end 
    
if(min(distance)==distance(1))
    plot3(eje_3d,R_I(1,:),G_I(1,:),B_I(1,:),'ro','MarkerSize',10,'MarkerFaceColor','auto');
    text(eje_3d, R_I, G_I, B_I, strcat(['The pixel enter is a ' Label1 ' pixel']));
end
if(min(distance)==distance(2))
    plot3(eje_3d,R_I(1,:),G_I(1,:),B_I(1,:),'bo','MarkerSize',10,'MarkerFaceColor','auto');
    text(eje_3d, R_I, G_I, B_I, strcat(['The pixel enter is a ' Label2 ' pixel']));
    
end
if(min(distance)==distance(3))
    plot3(eje_3d,R_I(1,:),G_I(1,:),B_I(1,:),'yo','MarkerSize',10,'MarkerFaceColor','y');
    text(eje_3d, R_I, G_I, B_I, strcat(['The pixel enter is a ' Label3 ' pixel']));
    
end

    userInput=input('Do you Want enter another point? press 1 for yes or press other for no \n');
    
end
% Crear tres sliders para modificar las coordenadas del punto
slider_x = uicontrol('Style', 'slider', 'Parent', figura, 'Position', [20 20 200 20], 'Min', 0, 'Max', 255, 'Value', punto_inicial(1));
slider_y = uicontrol('Style', 'slider', 'Parent', figura, 'Position', [20 50 200 20], 'Min', 0, 'Max', 255, 'Value', punto_inicial(2));
slider_z = uicontrol('Style', 'slider', 'Parent', figura, 'Position', [20 80 200 20], 'Min', 0, 'Max', 255, 'Value', punto_inicial(3));
% Agregar una función callback a cada slider para actualizar el punto
set(slider_x, 'Callback', {@update_point, eje_3d, slider_x, slider_y, slider_z, 'x',r,g,b,media_azul,media_rojo,media_verde,Label1,Label2,Label3});
set(slider_y, 'Callback', {@update_point, eje_3d, slider_x, slider_y, slider_z, 'y',r,g,b,media_azul,media_rojo,media_verde,Label1,Label2,Label3});
set(slider_z, 'Callback', {@update_point, eje_3d, slider_x, slider_y, slider_z, 'z',r,g,b,media_azul,media_rojo,media_verde,Label1,Label2,Label3});
disp(' proceso final....');


% Función callback para actualizar el punto
function update_point(src, event, eje_3d, slider_x, slider_y, slider_z, coordenada,r,g,b,media_azul,media_rojo,media_verde,Label1,Label2,Label3)
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

legend(Label1, Label2, Label3,Label1);
if(min(distance)==distance(1))
    plot3(eje_3d, punto_actualizado(1), punto_actualizado(2), punto_actualizado(3), 'ro', 'MarkerSize',10, 'MarkerEdgeColor', 'r');
    text(eje_3d, R_I, G_I, B_I, strcat(['The pixel enter is a ' Label1 ' pixel']));
end
if(min(distance)==distance(2))
    plot3(eje_3d, punto_actualizado(1), punto_actualizado(2), punto_actualizado(3), 'bo','MarkerSize',10, 'MarkerEdgeColor', 'b');
    text(eje_3d, R_I, G_I, B_I, strcat(['The pixel enter is a ' Label2 ' pixel']));
end
if(min(distance)==distance(3))
    plot3(eje_3d, punto_actualizado(1), punto_actualizado(2), punto_actualizado(3), 'yo', 'MarkerSize',10, 'MarkerEdgeColor', 'y');
    text(eje_3d, R_I, G_I, B_I, strcat(['The pixel enter is a ' Label3 ' pixel']));
end

end