clc;
close all;
clear all;
warning off all;

% Cargar una imagen en escala de grises
image = imread("peppers.png");
image = rgb2gray(image);

% Llamar a la función para modificar el 10% de los píxeles
modifiedImage = checkPixelModification(image, 10);
%modifiedImage = imnoise(image,"salt & pepper",.10);
figure(1);
subplot(1, 4, 1);
imshow(image);
title('Imagen original');

subplot(1, 4, 2);
imshow(modifiedImage);
title('Imagen modificada');

imgrecuperada = modifyPixels(modifiedImage);
imgrecuperadam = moda_modifyPixels(modifiedImage);
subplot(1, 4, 3);
imshow(imgrecuperada);
title('Imagen recuperada por media');
subplot(1, 4, 4);
imshow(imgrecuperadam);
title('Imagen recuperada por moda');
function  modifiedImage=checkPixelModification(image, percentage)
    % Verificar que el porcentaje está en el rango correcto
    if percentage < 1 || percentage > 100
        error('El porcentaje debe estar entre 1 y 100.');
    end

    % Obtener las dimensiones de la imagen
    [rows, cols] = size(image);

    % Calcular el número total de pixeles a modificar
    numPixelsToModify = round((percentage/100) * rows * cols);

    % Crear una copia de la imagen original
    modifiedImage = image;

    % Modificar píxeles de forma aleatoria
    modifiedPixels = 0;
    while modifiedPixels < numPixelsToModify
        % Generar coordenadas aleatorias
        row = randi(rows);
        col = randi(cols);

        % Verificar si el píxel ya ha sido modificado
        if modifiedImage(row, col) ~= 0 && modifiedImage(row, col) ~= 255
            % Asignar un valor aleatorio (0 o 255) al píxel
            modifiedImage(row, col) = randi([0, 255]);

            % Incrementar el contador de píxeles modificados
            modifiedPixels = modifiedPixels + 1;
        end
    end

    % Calcular el porcentaje real de píxeles modificados
    actualPercentage = (modifiedPixels / (rows * cols)) * 100;

    % Mostrar el resultado por consola
    fprintf('Porcentaje objetivo: %.2f%%\n', percentage);
    fprintf('Porcentaje real: %.2f%%\n', actualPercentage);
end
function image = modifyPixels(image)
    % Obtener dimensiones de la imagen
    [rows, cols] = size(image);
    
    % Crear una copia de la imagen original
    modifiedImage = image;
    
    % Recorrer la imagen pixel por pixel
    for i = 1:rows
        for j = 1:cols
            % Obtener los valores de los píxeles vecinos (conectividad 8)
            neighbors = zeros(1, 9);
            for m = -1:1
                for n = -1:1
                    if i+m >= 1 && i+m <= rows && j+n >= 1 && j+n <= cols
                        neighbors((m+1)*3 + (n+2)) = image(i+m, j+n);
                    end
                end
            end
            
            % Ordenar el array de vecinos
            neighbors = sort(neighbors);
            
            % Asignar el valor medio al píxel
            modifiedImage(i, j) = neighbors(5);
        end
    end
    
    % Devolver la imagen modificada
    image = modifiedImage;
end
function image = moda_modifyPixels(image)
 % Obtener dimensiones de la imagen
    [rows, cols] = size(image);
    
    % Crear una copia de la imagen original
    modifiedImage = image;
    
    % Recorrer la imagen pixel por pixel
    for i = 1:rows
        for j = 1:cols
            % Obtener los valores de los píxeles vecinos (conectividad 8)
            neighbors = zeros(1, 9);
            index = 1;
            for m = -1:1
                for n = -1:1
                    if i+m >= 1 && i+m <= rows && j+n >= 1 && j+n <= cols
                        neighbors(index) = image(i+m, j+n);
                    end
                    index = index + 1;
                end
            end
            
            % Calcular la moda de los vecinos
            pixelValue = mode(neighbors);
            
            % Asignar el valor de la moda al píxel
            modifiedImage(i, j) = pixelValue;
        end
    end
    
    % Devolver la imagen modificada
    image = modifiedImage;
end
