clc ;
clear all;
close all;
warning off all;

% Punto ingresado por el usuario
image = imread('peppers.png');

% Solicitar al usuario el número de clases y el número de representantes por clase
class_input = input('Ingrese el número de clases que desea: \n');
representants_input = input('Ingrese el número de representantes que desea por clase: \n');

% Mostrar la imagen original
figure;
imshow(image);
title('Seleccione los representantes para cada clase (haga clic en la imagen)');
hold on;

representants = zeros(class_input, representants_input, 3); % Se agrega la dimensión 3 para almacenar los valores RGB

for class_idx = 1:class_input
    for rep_idx = 1:representants_input
        % Esperar a que el usuario haga clic en la imagen
    
        [x, y] = ginput(1);
        x = round(x); % Redondear las coordenadas a números enteros
        y = round(y);
        ubicaciones(class_idx,rep_idx,:)=[x,y];
        % Almacenar los valores RGB del píxel representante en la matriz de representantes
        representants(class_idx, rep_idx, 1) = image(y, x, 1); % Canal rojo
        representants(class_idx, rep_idx, 2) = image(y, x, 2); % Canal verde
        representants(class_idx, rep_idx, 3) = image(y, x, 3); % Canal azul
        
        % Mostrar un marcador en la ubicación seleccionada
        plot(x, y, 'ro', 'MarkerSize', 3);
    end
    
end
flag=1;
% Mostrar la imagen original
% Definir el número de clases y representantes
class_input = size(ubicaciones, 1);
representants_input = size(ubicaciones, 2);

% Crear una figura y mostrar la imagen
figure;
imshow(image);
hold on;

% Definir colores para cada clase (puedes personalizarlos)
colors = lines(class_input);

% Inicializar una leyenda  
legend_labels = cell(class_input, 1);

% Recorrer las ubicaciones y trazar los puntos
for class_idx = 1:class_input
    for rep_idx = 1:representants_input
        % Obtener las coordenadas X e Y de la ubicación
        x_o = ubicaciones(class_idx, rep_idx, 1);
        y_o = ubicaciones(class_idx, rep_idx, 2);
        
        % Obtener el nombre de la clase y el color
        class_name = sprintf('Clase %d - Rep %d', class_idx, rep_idx);
        color = colors(class_idx, :);
        
        % Trazar el punto con el nombre y el color adecuados
        plot(x_o, y_o, 'o', 'MarkerSize', 10, 'MarkerEdgeColor', color, 'DisplayName', class_name);
        
        % Agregar el nombre de la clase a la leyenda
        if rep_idx == 1
            legend_labels{class_idx} = class_name;
        end
    end
end

% Mostrar la leyenda
legend(legend_labels);

% Restaurar el estado de 'hold' a 'off' para futuros trazados
hold off;

while flag==1

figure;
imshow(image);
title('Seleccione un píxel en la imagen');
hold on;

% Esperar a que el usuario haga clic en la imagen
[x, y] = ginput(1);
x = round(x); % Redondear las coordenadas a números enteros
y = round(y);

% Obtener el valor RGB del píxel seleccionado
selected_pixel(1) = [image(y, x, 1)]; 
selected_pixel(2) = [image(y, x, 2)]; 
selected_pixel(3) = [image(y, x, 3)]; 
selected_pixel=double(selected_pixel);


for class_idx = 1:class_input
    % Calcular la distancia de Mahalanobis para la clase actual
    mahalanobis_distance = 0;
    for rep_idx = 1:representants_input
    representants_idx(rep_idx,:)=[representants(class_idx,rep_idx,:)];
    end
    representant_mean=mean(representants_idx);
    % Calcular la distancia de Mahalanobis para el píxel seleccionado
    diff = selected_pixel - representant_mean;
    cov_matrix_class=cov(representants_idx);
    inv_cov_matrix = inv(cov_matrix_class);
    %disp(cov_matrix_class)
    %disp(inv_cov_matrix)
    mahalanobis_distance = (diff * inv_cov_matrix * diff');

    % Almacenar la distancia de Mahalanobis para la clase actual
    mahalanobis_distances(class_idx) = mahalanobis_distance;
    class_std(class_idx)=sum(std(representants_idx));
end
%disp(class_std)
disp(mahalanobis_distances)
% Determinar a qué clase pertenece el píxel seleccionado
[~, class_index] = min(abs(mahalanobis_distances));

% Mostrar el resultado
threshold = max(class_std);

if((max(mahalanobis_distances)+min(mahalanobis_distances))/2>min(mahalanobis_distances))
    fprintf('El píxel seleccionado pertenece a la Clase %d.\n', class_index);
else
    disp('El punto no pertenece a ninguna de las clases.'); 
end
flag=input("Desea ingresar otro punto\n");
clear selected_pixel mahalanobis_distances diff threshold x y class_index
clear representant_mean cov_matrix_class inv_cov_matrix mahalanobis_distance class_std
end