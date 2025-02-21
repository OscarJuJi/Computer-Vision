clc;
close all;

img = imread ("bandera.jpg");

% Mostrar la imagen y pedir al usuario que seleccione 15 puntos al azar
figure(1);
imshow(img);
title('Seleccione 15 puntos al azar');
hold on;

num_puntos = 15;
puntos = zeros(num_puntos, 2);

for i = 1:num_puntos
    [x, y] = ginput(1);
    puntos(i,:) = [x, y];
    plot(x, y, 'w+', 'MarkerSize', 10);
end

figure(2);
imshow(img);
title('Puntos seleccionados en la imagen');
hold on;

% Obtener las coordenadas x e y de los puntos seleccionados
x = puntos(:,1);
y = puntos(:,2);

% Mostrar los puntos en la imagen
scatter(x, y, 'b', 'filled');

close 1;

% Clasificar puntos según su coordenada en x
clase1_indices = find(puntos(:,2) < 160);
clase2_indices = find(puntos(:,2) >= 160 & puntos(:,2) < 320);
clase3_indices = find(puntos(:,2) >= 320);

% Asignar puntos a cada clase
clase1 = puntos(clase1_indices,:);
clase2 = puntos(clase2_indices,:);
clase3 = puntos(clase3_indices,:);

n = 3;
ant = 2; 
while true
    close(ant); 
    figure(n);
    imshow(img);
    hold on;
    h1 = scatter(clase1(:,1), clase1(:,2), 50, 'white', 'filled', 'DisplayName', 'Clase 1');
    h2 = scatter(clase2(:,1), clase2(:,2), 50, 'blue', 'filled', 'DisplayName', 'Clase 2');
    h3 = scatter(clase3(:,1), clase3(:,2), 50, 'magenta', 'filled', 'DisplayName', 'Clase 3');
    legend('Location', 'best');
    
    % Pedir al usuario que seleccione un punto
    disp('Seleccione un punto en la imagen');
    punto = round(ginput(1));

    % Salir si el usuario no selecciona un punto
    if isempty(punto)
        break;
    end

    % Mostrar las coordenadas del punto seleccionado
    disp(['Punto seleccionado: (' num2str(punto(1)) ', ' num2str(punto(2)) ')']);

    % Determinar a qué clase pertenece el punto y actualizar la posición
    if punto(2) < 160
        disp('El punto pertenece a la clase 1');
        set(h1, 'XData', [get(h1, 'XData'), punto(1)], 'YData', [get(h1, 'YData'), punto(2)]);
    elseif punto(2) >= 160 && punto(2) < 320
        disp('El punto pertenece a la clase 2');
        set(h2, 'XData', [get(h2, 'XData'), punto(1)], 'YData', [get(h2, 'YData'), punto(2)]);
    elseif punto(2) >= 320
        disp('El punto pertenece a la clase 3');
        set(h3, 'XData', [get(h3, 'XData'), punto(1)], 'YData', [get(h3, 'YData'), punto(2)]);
    else
        disp('El punto no pertenece a ninguna clase');
    end 

    ant = n; % Guardar el número de la figura actual como figura anterior
    n = n + 1; % Actualizar el número de la figura actual
    pause(2);
end

% while true
%     % Pedir al usuario que ingrese el punto
%     punto_str = input('Ingrese un punto en formato [x y]: ', 's');
%     
%     % Salir si el usuario ingresa 'enter'
%     if isempty(punto_str)
%         break;
%     end
%     
%     % Convertir el punto a formato numérico
%     punto = str2num(punto_str);
%     
%     % Determinar a qué clase pertenece el punto
%     if punto(1) < 160
%         disp('El punto pertenece a la clase 1');
%     elseif punto(1) >= 160 && punto(1) < 320
%         disp('El punto pertenece a la clase 2');
%     elseif punto(1) >= 320
%         disp('El punto pertenece a la clase 3');
%     else
%         disp('El punto no pertenece a ninguna clase');
%     end
% end

