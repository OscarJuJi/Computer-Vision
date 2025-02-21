clc
clear all
close all
warning off all;

playita = imread("imgp.jpg");
figure(2); subplot(1,1,1);
N_class = input("Ingrese el numero de clases que quiere\n");

array_pixels = impixel(playita);
aux1 = 1;
array_avg=[];
for i = 1:length(array_pixels)
    array_avg(i) = (array_pixels(i,1) + array_pixels(i,2) + array_pixels(i,3))/3;
end

numbers = num2cell(1:length(array_pixels));
map = containers.Map(numbers, array_avg);

% Extraer valores y claves en dos matrices separadas
values = cell2mat(map.values);
keys = map.keys;

% Ordenar los valores y mantener un registro de las claves
[sortedValues, idx] = sort(values);

% Recorrer la matriz ordenada y buscar las claves correspondientes en el mapa original
for i = 1:length(sortedValues)
    key(i) = keys{idx(i)};
    value(i) = map(key(i));
    
end
aux2=1;
yapaso = [];


j=1;
k=1;

        aux0 = 1;
        aux4 = 1;
        for i = 1:(length(sortedValues)-1)
            %sqrt((array_pixels(key(i+1),1)-array_pixels(key(i),1))^2 + (array_pixels(key(i+1),2)-array_pixels(key(i),2))^2 + (array_pixels(key(i+1),3)-array_pixels(key(i),3))^2)
            if ( (isempty(find(yapaso==key(i+1))==1)) && 55 > sqrt((array_pixels(key(i+1),1)-array_pixels(key(i),1))^2 + (array_pixels(key(i+1),2)-array_pixels(key(i),2))^2 + (array_pixels(key(i+1),3)-array_pixels(key(i),3))^2))
                
                yapaso
                i
                j
                
                
                if (i == 1)
                clases(j,aux0,1)=array_pixels(key(i),1);
                clases(j,aux0,2)=array_pixels(key(i),2);
                clases(j,aux0,3)=array_pixels(key(i),3);
                    yapaso(aux2)=key(i);
                    aux2=aux2+1;
                    aux0=aux0+1;
                clases(j,aux0,1)=array_pixels(key(i+1),1);
                clases(j,aux0,2)=array_pixels(key(i+1),2);
                clases(j,aux0,3)=array_pixels(key(i+1),3);
                yapaso(aux2)=key(i+1);
                aux2=aux2+1;
                aux0=aux0+1;
                else
                clases(j,aux0,1)=array_pixels(key(i+1),1);
                clases(j,aux0,2)=array_pixels(key(i+1),2);
                clases(j,aux0,3)=array_pixels(key(i+1),3);
                yapaso(aux2)=key(i+1);
                aux2=aux2+1;
                aux0=aux0+1;
                end
            end 
            if(i<(length(array_pixels)-2))
                if(50<(sqrt((array_pixels(key(i+1),1)-array_pixels(key(i),1))^2+(array_pixels(key(i+1),2)-array_pixels(key(i),2))^2+(array_pixels(key(i+1),3)-array_pixels(key(i),3))^2))&&(50>sqrt((array_pixels(key(i+2),1)-array_pixels(key(i+1),1))^2+(array_pixels(key(i+2),2)-array_pixels(key(i+1),2))^2+(array_pixels(key(i+2),3)-array_pixels(key(i+1),3))^2)))
                
                    if(((value(i+1)-value(i))>10))
    
                        j=j+1;
                       
                        clases(j,aux0,1)=array_pixels(key(i+1),1);
                        clases(j,aux0,2)=array_pixels(key(i+1),2);
                        clases(j,aux0,3)=array_pixels(key(i+1),3);
                        yapaso(aux2)=key(i+1);
                        aux2=aux2+1;
                        aux0=aux0+1;
                       
                    end
                elseif(50<sqrt((array_pixels(key(i+1),1)-array_pixels(key(i),1))^2+(array_pixels(key(i+1),2)-array_pixels(key(i),2))^2+(array_pixels(key(i+1),3)-array_pixels(key(i),3))^2)&&50>sqrt((array_pixels(key(i+2),1)-array_pixels(key(i),1))^2+(array_pixels(key(i+2),2)-array_pixels(key(i),2))^2+(array_pixels(key(i+2),3)-array_pixels(key(i),3))^2)) 
                    clases(j,aux0,1)=array_pixels(key(i+2),1);
                    clases(j,aux0,2)=array_pixels(key(i+2),2);
                    clases(j,aux0,3)=array_pixels(key(i+2),3);
                    yapaso(aux2)=key(i+2);
                    disp(clases(j,aux0));
                    aux2=aux2+1;
                    aux0=aux0+1;
                end
            end
            
        end
        if(j<N_class)
        for i = 1:(length(sortedValues)-1)
            %sqrt((array_pixels(key(i+1),1)-array_pixels(key(i),1))^2 + (array_pixels(key(i+1),2)-array_pixels(key(i),2))^2 + (array_pixels(key(i+1),3)-array_pixels(key(i),3))^2)
            if ( (isempty(find(yapaso==key(i+1))==1)) && 55 > sqrt((array_pixels(key(i+1),1)-array_pixels(key(i),1))^2 + (array_pixels(key(i+1),2)-array_pixels(key(i),2))^2 + (array_pixels(key(i+1),3)-array_pixels(key(i),3))^2))
                
                yapaso
                i
                j
                
                
                if (i == 1)
                clases(j,aux0,1)=array_pixels(key(i),1);
                clases(j,aux0,2)=array_pixels(key(i),2);
                clases(j,aux0,3)=array_pixels(key(i),3);
                    yapaso(aux2)=key(i);
                    aux2=aux2+1;
                    aux0=aux0+1;
                clases(j,aux0,1)=array_pixels(key(i+1),1);
                clases(j,aux0,2)=array_pixels(key(i+1),2);
                clases(j,aux0,3)=array_pixels(key(i+1),3);
                yapaso(aux2)=key(i+1);
                aux2=aux2+1;
                aux0=aux0+1;
                else
                clases(j,aux0,1)=array_pixels(key(i+1),1);
                clases(j,aux0,2)=array_pixels(key(i+1),2);
                clases(j,aux0,3)=array_pixels(key(i+1),3);
                yapaso(aux2)=key(i+1);
                aux2=aux2+1;
                aux0=aux0+1;
                end
                
            end 
            if(i<(length(array_pixels)-2))
                if(50<(sqrt((array_pixels(key(i+1),1)-array_pixels(key(i),1))^2+(array_pixels(key(i+1),2)-array_pixels(key(i),2))^2+(array_pixels(key(i+1),3)-array_pixels(key(i),3))^2))&&(50>sqrt((array_pixels(key(i+2),1)-array_pixels(key(i+1),1))^2+(array_pixels(key(i+2),2)-array_pixels(key(i+1),2))^2+(array_pixels(key(i+2),3)-array_pixels(key(i+1),3))^2)))
                
                    if(((value(i+1)-value(i))>10))
    
                        j=j+1;
                    end
                elseif(50<sqrt((array_pixels(key(i+1),1)-array_pixels(key(i),1))^2+(array_pixels(key(i+1),2)-array_pixels(key(i),2))^2+(array_pixels(key(i+1),3)-array_pixels(key(i),3))^2)&&50>sqrt((array_pixels(key(i+2),1)-array_pixels(key(i),1))^2+(array_pixels(key(i+2),2)-array_pixels(key(i),2))^2+(array_pixels(key(i+2),3)-array_pixels(key(i),3))^2)) 
                    clases(j,aux0,1)=array_pixels(key(i+2),1);
                    clases(j,aux0,2)=array_pixels(key(i+2),2);
                    clases(j,aux0,3)=array_pixels(key(i+2),3);
                    yapaso(aux2)=key(i+2);
                    disp(clases(j,aux0));
                    aux2=aux2+1;
                    aux0=aux0+1;
                end
            end
            
        end
        end
        
        arr_aux=[];
a=length(clases);  

for i=1:N_class
    aux5=1;
    for j=1:a
        %fprintf('%d,%d,%d',clases(i,j,1),clases(i,j,2),clases(i,j,3));
        if(clases(i,j,1)~=0||clases(i,j,2)~=0||clases(i,j,3)~=0)
          arr_aux(i,aux5,1)=clases(i,j,1);
          arr_aux(i,aux5,2)=clases(i,j,2);
          arr_aux(i,aux5,3)=clases(i,j,3);
        aux5=aux5+1;
        end

    end 
end
clases=arr_aux;
aux3=1;
todavia_no_pasa_XD=[];
if(length(sortedValues)>length(yapaso))
    for i=1:length(sortedValues)
        if(isempty(find(yapaso==i))==1)
            todavia_no_pasa_XD(aux3)=i;
            aux3=aux3+1;
        end
    end
end




        avg_r=[];
        avg_g=[];
        avg_b=[];
for j=1:N_class
        sumt_r=0;
        sumt_g=0;
        sumt_b=0;
    for i=1:length(clases)
        sumt_r=sumt_r+clases(j,i,1);
        sumt_g=sumt_g+clases(j,i,2);
        sumt_b=sumt_b+clases(j,i,3);
    end
        avg_r(j)=sumt_r/length(clases);
        avg_g(j)=sumt_g/length(clases);
        avg_b(j)=sumt_b/length(clases);
        
if(~isempty(todavia_no_pasa_XD))
    for i=1:length(todavia_no_pasa_XD)
        %sqrt((array_pixels(todavia_no_pasa_XD(i),1)-avg_r(j))^2+(array_pixels(todavia_no_pasa_XD(i),2)-avg_g(j))^2+(array_pixels(todavia_no_pasa_XD(i),3)-avg_b(j))^2)

        if(60>sqrt((array_pixels(todavia_no_pasa_XD(i),1)-avg_r(j))^2+(array_pixels(todavia_no_pasa_XD(i),2)-avg_g(j))^2+(array_pixels(todavia_no_pasa_XD(i),3)-avg_b(j))^2))
            i
            clases(j,length(clases)+1,1)=array_pixels(todavia_no_pasa_XD(i),1);
            clases(j,length(clases),2)=array_pixels(todavia_no_pasa_XD(i),2);
            clases(j,length(clases),3)=array_pixels(todavia_no_pasa_XD(i),3);
            yapaso(aux2)=key(i);
            aux2=aux2+1;
           
        end
    end
  end
end
a=length(clases);  

for i=1:N_class
    aux5=1;
    for j=1:a
        %fprintf('%d,%d,%d',clases(i,j,1),clases(i,j,2),clases(i,j,3));
        if(clases(i,j,1)~=0||clases(i,j,2)~=0||clases(i,j,3)~=0)
          arr_aux(i,aux5,1)=clases(i,j,1);
          arr_aux(i,aux5,2)=clases(i,j,2);
          arr_aux(i,aux5,3)=clases(i,j,3);
        aux5=aux5+1;
        end

    end 
end
clases
k=1;
r=[];
g=[];
b=[];
for i=1:N_class
    for j=1:length(clases)
        r(i,j)=clases(i,j,1);
        g(i,j)=clases(i,j,2);
        b(i,j)=clases(i,j,3);
        
    end
end 
r
g
b


media_rojo=mean(r')
media_rojo=media_rojo'

media_verde=mean(g')
media_verde=media_verde'

media_azul=mean(b')
media_azul=media_azul'

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

while(userInput==1)
        delete(findall(eje_3d, 'type', 'line')); % borrar la línea anterior
    delete(findall(eje_3d, 'type', 'text'));
    plot3(eje_3d,r(1,:),g(1,:),b(1,:),'ro','MarkerSize',10,'MarkerFaceColor','r')

plot3(eje_3d,r(2,:),g(2,:),b(2,:),'bo','MarkerSize',10,'MarkerFaceColor','b')
plot3(eje_3d,r(3,:),g(3,:),b(3,:),'yo','MarkerSize',10,'MarkerFaceColor','y')
legend(Label1, Label2, Label3,Label1);
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
   
    %distance(i)
    %media_rojo(i)
    %media_verde(i)
    %media_azul(i)
end 

legend(Label1, Label2, Label3);
if(min(distance)==distance(1))
    plot3(eje_3d, punto_actualizado(1), punto_actualizado(2), punto_actualizado(3), 'ro', 'MarkerSize',10, 'MarkerEdgeColor', 'r');
    text(eje_3d, punto_actualizado, punto_actualizado, punto_actualizado, strcat(['The pixel enter is a ' Label1 ' pixel']));
end
if(min(distance)==distance(2))
    plot3(eje_3d, punto_actualizado(1), punto_actualizado(2), punto_actualizado(3), 'bo','MarkerSize',10, 'MarkerEdgeColor', 'b');
    text(eje_3d, punto_actualizado, punto_actualizado, punto_actualizado, strcat(['The pixel enter is a ' Label2 ' pixel']));
end
if(min(distance)==distance(3))
    plot3(eje_3d, punto_actualizado(1), punto_actualizado(2), punto_actualizado(3), 'yo', 'MarkerSize',10, 'MarkerEdgeColor', 'y');
    text(eje_3d, punto_actualizado, punto_actualizado, punto_actualizado, strcat(['The pixel enter is a ' Label3 ' pixel']));
end

end