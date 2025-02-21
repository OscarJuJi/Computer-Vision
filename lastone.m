clear all all
close all
warning all
% Leer una imagen
image = imread('paye.jpg');

% Mostrar la imagen y permitir que el usuario seleccione 3 puntos
imshow(image);
title('Seleccione 3 puntos en la imagen');
[x, y] = ginput(3);

% Redondear las coordenadas seleccionadas a números enteros
selected_points = round([x, y]);

% Generar 10 puntos aleatorios cerca de los puntos seleccionados
random_points = [];
for i = 1:3
    offset = randi([-50, 50], 1000, 2); % ajusta el rango según tus necesidades
    random_points = [random_points; selected_points(i, :) + offset];
end

% Obtener los valores RGB de los puntos seleccionados y aleatorios
selected_rgb = zeros(1000, 3);
for i = 1:3000
    selected_rgb(i, :) = reshape(image(random_points(i, 2), random_points(i, 1), :), 1, 3);
end

% Normalizar los valores RGB
selected_rgb_normalized = double(selected_rgb);

% Número de clusters
k = 3;

% Usar tu implementación personalizada
[idx_custom, centroids_custom] = kmeans(selected_rgb_normalized, k);

% Usar la función kmeans de MATLAB
[idx_matlab, centroids_matlab] = kmeans_custom(selected_rgb_normalized, k);

centroids_matlab
centroids_custom



% Asignar colores a cada clase para la visualización
colors = [1 0 0; 0 1 0; 0 0 1]; % Rojo, Verde, Azul

% Visualizar la imagen con los puntos clasificados
figure;
imshow(image);
hold on;

% Plotear los puntos clasificados con diferentes colores por cada clase
for i = 1:3000
    plot(random_points(i, 1), random_points(i, 2), 'o', 'MarkerFaceColor', colors(idx_custom(i), :), 'MarkerEdgeColor', 'k');
end

% Mostrar centroides en la imagen
for i = 1:k
    plot(centroids_custom(i, 1), centroids_custom(i, 2), 'x', 'MarkerSize', 10, 'LineWidth', 2, 'Color', colors(i, :));
end

title('Puntos clasificados y centroides');
hold off;

function [idx, centroids] = kmeans_custom(X, k)
    % Inicialización aleatoria de centroides
    centroids = X(randperm(size(X, 1), k), :);
    
    % Inicialización de variables
    max_iterations = 100000;
    epsilon = 1e-6;
    iteration = 0;
    i=0;
    % Loop principal
    while true
        i=i+1;
        % Asignación de puntos al centroide más cercano
        distances = pdist2(X, centroids);
        [~, idx] = min(distances, [], 2);
        
        % Actualización de centroides
        new_centroids = zeros(k, size(X, 2));
        for i = 1:k
            new_centroids(i, :) = mean(X(idx == i, :));
        end
        
        % Condición de parada
        if norm(new_centroids - centroids, 'fro') < epsilon
            break;
            disp(centroids)
        end
        
        % Actualización de centroides para la siguiente iteración
        centroids = new_centroids;
        if(i==1||i==2||i==3)
        disp(centroids)
        end
        % Incremento de la iteración
        iteration = iteration + 1;
        
        % Condición de parada adicional para evitar bucles infinitos
        if iteration >= max_iterations
            disp('Número máximo de iteraciones alcanzado');
            disp(centroids)
            break;
        end
    end
end
