clc
clear all all
close all
warning off all;
% Leer la imagen
img = imread("peppers.png");

% Mostrar la imagen en una figura
figure;
imshow(img);

% Obtener el número de puntos a analizar
n = input('Introduce el número de puntos a analizar: ');
n_pixels = input('Introduce el número de puntos a analizar: ');
vecindad_size = ceil(sqrt(n_pixels)); 
% Obtener las coordenadas de los n puntos a analizar
[x, y] = ginput(n);

% Obtener los valores RGB de los puntos vecinos y calcular los promedios para cada punto
% Obtener los valores RGB de los puntos vecinos y calcular los promedios para cada punto
rgb_avg_array = zeros(n, 3); % Array para almacenar los promedios RGB para cada punto
random_pixels=zeros(n,vecindad_size^2,3);
coordenadas=zeros(n,vecindad_size^2,2);
l=1;
for k = 1:n
    % Obtener los valores RGB de los puntos vecinos
    rgb_array = zeros(vecindad_size^2,3); % Array para almacenar los valores RGB de los puntos vecinos
    idx = 1;
for i = -floor(vecindad_size/2):floor(vecindad_size/2)
        for j = -floor(vecindad_size/2):floor(vecindad_size/2)
            x_new = round(x(k)) + i; % Coordenada x del punto vecino
            y_new = round(y(k)) + j; % Coordenada y del punto vecino
            coordenadas(k,l,1)=x_new;
            coordenadas(k,l,2)=y_new;
            l=l+1;
            %if x_new >= 1 && x_new <= size(img,2) && y_new >= 1 && y_new <= size(img,1)
                % Obtener los valores RGB del punto vecino
                rgb = impixel(img, x_new, y_new); 
                % Almacenar los valores RGB en el array
                rgb_array(idx, :) = rgb'; 
                random_pixels(k,idx,:)= rgb';
                idx = idx + 1;
            %end
        end
end
    
    % Eliminar filas vacías del array
    rgb_array(~any(rgb_array,2),:) = [];
    
    % Calcular los promedios de los valores RGB de los puntos vecinos
    rgb_avg = mean(rgb_array);

    % Almacenar los promedios RGB en el array
    rgb_avg_array(k,:) = rgb_avg;
end
figure(10);
imshow(img);
hold on
grid on
for i=1:n
    plot(coordenadas(i,:,1),coordenadas(i,:,2),'ob','Markersize',1,'MarkerFaceColor','auto')
end
% Mostrar los valores RGB promedio para cada punto
fprintf('Promedios RGB de los puntos vecinos:\n');
for k = 1:n
    fprintf('Punto %d: R: %.2f, G: %.2f, B: %.2f\n', k, rgb_avg_array(k,1), rgb_avg_array(k,2), rgb_avg_array(k,3));
end

random_pixelss=random_pixels;



playita=imread("imgp.jpg");
figure(3); subplot(1,1,1);
array=[];
auts=1;
%length(array_class)
% for i=1:n
%     for j=1:length(array_class)
%         array(auts,1)=array_class(i,j,1);
%         array(auts,2)=array_class(i,j,2);
%         array(auts,3)=array_class(i,j,3);
%         auts=auts+1;
%     end
% end
%array;
%array(1);
k=1;
for i=1:n
    for j=1:n_pixels
        r(i,j,1)= random_pixels(i,j,1); 
        g(i,j,1)= random_pixels(i,j,2);
        b(i,j,1)= random_pixels(i,j,3);
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
if(n>1)
    Label2=input('Ingrese le nombre de la calse 2\n','s'); 
end
if(n>2)
    Label3=input('Ingrese le nombre de la calse 3\n','s');
end
if(n>3)
    Label4=input('Ingrese le nombre de la calse 3\n','s');
end



%R_I
%G_I
%B_I

while true
    
    entrada_input=3;
    while(entrada_input~=1&&entrada_input~=2)
        
        figure(4);
        entrada_input=input('Escriba como desea determinar la clase de un punto \1.Seleccion en la imagen\2.Seleccion por coordenadas:\n');
        if(entrada_input==1)
        
        unknow_Point=impixel(img);
        R_I = unknow_Point(1);
        G_I = unknow_Point(2);
        B_I = unknow_Point(3);
        elseif(entrada_input==2)
            px=input('dame la coord del punto a clasificar en x= ')
            py=input('dame la coord del punto a clasificar en y= ')
            vx=[px;py];
            
            unknow_Point=impixel(img,px,py);
            R_I = unknow_Point(1);
            G_I = unknow_Point(2);
            B_I = unknow_Point(3);
        end
    end
    close (4);
    
    for i=1:n
    
    distance(i)=sqrt((R_I-media_rojo(i))^2+(G_I-media_verde(i))^2+(B_I-media_azul(i))^2);
    %distance(i)
    %media_rojo(i)
    %media_verde(i)
    %media_azul(i)
    end 
    figure(5);
if(min(distance)==distance(1))
        %Graficacion de clases
   if(n>0)
        plot3(r(1,:),g(1,:),b(1,:),'o','MarkerSize',10,'MarkerFaceColor','b')
    end
    hold on
    grid on
    if(n>1)
        plot3(r(2,:),g(2,:),b(2,:),'o','MarkerSize',10,'MarkerFaceColor','g')
    end
    if(n>2)
        plot3(r(3,:),g(3,:),b(3,:),'o','MarkerSize',10,'MarkerFaceColor','y')
    end
    if(n>3)
        plot3(r(4,:),g(4,:),b(4,:),'o','MarkerSize',10,'MarkerFaceColor','y')
    end
    plot3(unknow_Point(:,1),unknow_Point(:,2),unknow_Point(:,3),'o','MarkerSize',10,'MarkerFaceColor','k')
    plot3(R_I(1,:),G_I(1,:),B_I(1,:),'ro','MarkerSize',10,'MarkerFaceColor','b');
    text(R_I, G_I, B_I, strcat(['The pixel enter is a ' Label1 ' pixel']));
    if(n==1)
        legend(Label1,'unknow_point')
    end
    if(n==2)
        legend(Label1, Label2,'unknow_point')
    end
    if(n==3)
        legend(Label1, Label2, Label3,'unknow_point')
    end
    if(n==4)
        legend(Label1, Label2, Label3,Label4,'unknow_point')
    end
    hold off
    disp(strcat(['The pixel enter is a ' Label1 ' pixel']));
    
end
if(min(distance)==distance(2))
    if(n>0)
        plot3(r(1,:),g(1,:),b(1,:),'o','MarkerSize',10,'MarkerFaceColor','b')
    end
    hold on
    grid on
    if(n>1)
        plot3(r(2,:),g(2,:),b(2,:),'o','MarkerSize',10,'MarkerFaceColor','g')
    end
    if(n>2)
        plot3(r(3,:),g(3,:),b(3,:),'o','MarkerSize',10,'MarkerFaceColor','y')
    end
    if(n>3)
        plot3(r(4,:),g(4,:),b(4,:),'o','MarkerSize',10,'MarkerFaceColor','y')
    end
    plot3(unknow_Point(:,1),unknow_Point(:,2),unknow_Point(:,3),'o','MarkerSize',10,'MarkerFaceColor','k')
    plot3(R_I(1,:),G_I(1,:),B_I(1,:),'bo','MarkerSize',10,'MarkerFaceColor','g');
    text(R_I, G_I, B_I, strcat(['The pixel enter is a ' Label2 ' pixel']));
    if(n==1)
        legend(Label1,'unknow_point')
    end
    if(n==2)
        legend(Label1, Label2,'unknow_point')
    end
    if(n==3)
        legend(Label1, Label2, Label3,'unknow_point')
    end
    if(n==4)
        legend(Label1, Label2, Label3,Label4,'unknow_point')
    end
    hold off
    disp(strcat(['The pixel enter is a ' Label2 ' pixel']));
end
    if(n>2)
        if(min(distance)==distance(3))
        if(n>0)
            plot3(r(1,:),g(1,:),b(1,:),'o','MarkerSize',10,'MarkerFaceColor','b')
        end
        hold on
        grid on
        if(n>1)
            plot3(r(2,:),g(2,:),b(2,:),'o','MarkerSize',10,'MarkerFaceColor','g')
        end
        if(n>2)
            plot3(r(3,:),g(3,:),b(3,:),'o','MarkerSize',10,'MarkerFaceColor','y')
        end
        if(n>3)
            plot3(r(4,:),g(4,:),b(4,:),'o','MarkerSize',10,'MarkerFaceColor','y')
        end
        plot3(unknow_Point(:,1),unknow_Point(:,2),unknow_Point(:,3),'o','MarkerSize',10,'MarkerFaceColor','k')
        plot3(R_I(1,:),G_I(1,:),B_I(1,:),'yo','MarkerSize',10,'MarkerFaceColor','y');
        text(R_I, G_I, B_I, strcat(['The pixel enter is a ' Label3 ' pixel']));
        if(n==1)
        legend(Label1,'unknow_point')
    end
    if(n==2)
        legend(Label1, Label2,'unknow_point')
    end
    if(n==3)
        legend(Label1, Label2, Label3,'unknow_point')
    end
    if(n==4)
        legend(Label1, Label2, Label3,Label4,'unknow_point')
    end
        disp(strcat(['The pixel enter is a ' Label3 ' pixel']));
        end
    end
    if(n>3)
        if(min(distance)==distance(4))
        if(n>0)
            plot3(r(1,:),g(1,:),b(1,:),'o','MarkerSize',10,'MarkerFaceColor','b')
        end
        hold on
        grid on
        if(n>1)
            plot3(r(2,:),g(2,:),b(2,:),'o','MarkerSize',10,'MarkerFaceColor','g')
        end
        if(n>2)
            plot3(r(3,:),g(3,:),b(3,:),'o','MarkerSize',10,'MarkerFaceColor','y')
        end
        if(n>3)
            plot3(r(4,:),g(4,:),b(4,:),'o','MarkerSize',10,'MarkerFaceColor','y')
        end
        plot3(unknow_Point(:,1),unknow_Point(:,2),unknow_Point(:,3),'o','MarkerSize',10,'MarkerFaceColor','k')
        plot3(R_I(1,:),G_I(1,:),B_I(1,:),'yo','MarkerSize',10,'MarkerFaceColor','y');
        text(R_I, G_I, B_I, strcat(['The pixel enter is a ' Label3 ' pixel']));
        if(n==1)
        legend(Label1,'unknow_point')
    end
    if(n==2)
        legend(Label1, Label2,'unknow_point')
    end
    if(n==3)
        legend(Label1, Label2, Label3,'unknow_point')
    end
    if(n==4)
        legend(Label1, Label2, Label3,Label4,'unknow_point')
    end
        disp(strcat(['The pixel enter is a ' Label4 ' pixel']));
        end
    end
if(n>4)
    for i=4:n
     if(n>0)
        plot3(r(1,:),g(1,:),b(1,:),'o','MarkerSize',10,'MarkerFaceColor','b')
    end
    hold on
    grid on
    if(n>1)
        plot3(r(2,:),g(2,:),b(2,:),'o','MarkerSize',10,'MarkerFaceColor','g')
    end
    if(n>2)
        plot3(r(3,:),g(3,:),b(3,:),'o','MarkerSize',10,'MarkerFaceColor','y')
    end
    if(n>3)
        plot3(r(i,:),g(i,:),b(i,:),'o','MarkerSize',10,'MarkerFaceColor','y')
    end
    
    plot3(unknow_Point(:,1),unknow_Point(:,2),unknow_Point(:,3),'o','MarkerSize',10,'MarkerFaceColor','k')
    plot3(R_I(1,:),G_I(1,:),B_I(1,:),'yo','MarkerSize',10,'MarkerFaceColor','y');
    text(R_I, G_I, B_I, strcat(['The pixel enter is a ' Label3 ' pixel']));
    legend(Label1, Label2, Label3,'unknow_point')
    end

end
    userInput=input('Do you Want enter another point? press 1 for yes or press other for no \n');
    close (5);
    if userInput~=1
        break;
    end
end
% Crear una figura
figura = figure;

eje_3d = axes('Parent', figura, 'XLim', [0 400], 'YLim', [0 400], 'ZLim', [0 400]);
% Crear tres sliders para modificar las coordenadas del punto
slider_x = uicontrol('Style', 'slider', 'Parent', figura, 'Position', [20 20 200 20], 'Min', 0, 'Max', 255, 'Value', unknow_Point(1));
slider_y = uicontrol('Style', 'slider', 'Parent', figura, 'Position', [20 50 200 20], 'Min', 0, 'Max', 255, 'Value', unknow_Point(2));
slider_z = uicontrol('Style', 'slider', 'Parent', figura, 'Position', [20 80 200 20], 'Min', 0, 'Max', 255, 'Value', unknow_Point(3));
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
    text(eje_3d, punto_actualizado(1), punto_actualizado(2),punto_actualizado(3), strcat(['The pixel enter is a ' Label1 ' pixel']));
end
if(min(distance)==distance(2))
    plot3(eje_3d, punto_actualizado(1), punto_actualizado(2), punto_actualizado(3), 'bo','MarkerSize',10, 'MarkerEdgeColor', 'b');
    text(eje_3d, punto_actualizado(1), punto_actualizado(2),punto_actualizado(3), strcat(['The pixel enter is a ' Label2 ' pixel']));
end
if(min(distance)==distance(3))
    plot3(eje_3d, punto_actualizado(1), punto_actualizado(2), punto_actualizado(3), 'yo', 'MarkerSize',10, 'MarkerEdgeColor', 'y');
    text(eje_3d, punto_actualizado(1), punto_actualizado(2),punto_actualizado(3), strcat(['The pixel enter is a ' Label3 ' pixel']));
end

end