clc;
close all;
clear global;
warning off all;
% Cargar la imagen a clasificar
imagen = imread('CAMPO.jpg');

% Convertir la imagen a una matriz 2D de píxeles (cada fila representa un píxel)
pixels = reshape(imagen, [], 3);
klist=2:5;%the number of clusters you want to try
myfunc = @(X,K)(kmeans(X, K));
eva = evalclusters(double(pixels),myfunc,'CalinskiHarabasz','klist',klist);
num_clusters = eva.OptimalK;

% Aplicar el algoritmo k-means para clasificar los píxeles en las clases
[idx, centroides] = kmeans(double(pixels), num_clusters);

% Definir las clases previamente conocidas
clasesConocidas = [255, 0, 0;    % Clase 1: Rojo
                   0, 255, 0;    % Clase 2: Verde
                   0, 0, 255];   % Clase 3: Azul

% Array para almacenar las clases cercanas
clasesCercanas = [];

% Calcular la distancia entre los centroides y las clases conocidas
for i = 1:num_clusters
    distancias = sqrt(sum((centroides(i, :) - clasesConocidas).^2, 2));
    distanciaMinima = min(distancias);
    
    % Comparar la distancia mínima con un umbral (puedes ajustar este valor según tus necesidades)
    umbral = 50;
    if distanciaMinima < umbral
        clasesCercanas = [clasesCercanas; i];
    end
end

% Imprimir los centroides retornados por kmeans
disp('Centroides:');
disp(centroides);

% Imprimir las clases cercanas
disp('Clases cercanas:');
disp(clasesCercanas);
