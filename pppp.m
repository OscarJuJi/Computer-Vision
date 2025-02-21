clc;
close all;
clear all all;
warning off all;
%input_matrix = uint8(randi([0 255], 8, 8));
%input_matrix= uint8([1,2,3;4,5,6;7,8,9]);
%predicted_matrix = predict_matrix(input_matrix);
%figure (1);
%imshow(input_matrix);
%figure (2);
%imshow(predicted_matrix);
% Leer la imagen en color
image = imread("test.jpg");
% Leer la imagen y convertirla a escala de grises

%pixel_compress=8;
gray_image = rgb2gray(image);
%gray_image=input_matrix;
% Tamaño de la imagen
[height, width] = size(gray_image);
si=1;
while(si>0)
pixel_compress=input("A cuantos pixeles quiere comprimir:\n");
pixel_compress=pixel_compress*pixel_compress;
% Tamaño de las vecindades
block_size = 8;
num_blocks_horiz = floor(width / block_size);
num_blocks_vert = floor(height / block_size);
predicted_blocks = (zeros(height, width));
error_blocks = (zeros(height, width));

for i = 1:num_blocks_vert
    for j = 1:num_blocks_horiz
        row_start = (i - 1) * block_size + 1;
        row_end = row_start + block_size - 1;
        col_start = (j - 1) * block_size + 1;
        col_end = col_start + block_size - 1;
        block =dct2(gray_image(row_start:row_end, col_start:col_end));
      
        predicted_block = predict_matrix((block));
        predicted_blocks(row_start:row_end, col_start:col_end) =(predicted_block);
        image_predicted_blocks(row_start:row_end, col_start:col_end) =uint8(round(idct2(predicted_block),4));

        error_block=block-predicted_block;
        
        error_blocks(row_start:row_end, col_start:col_end)=error_block;
        
        image_error_blocks(row_start:row_end, col_start:col_end) =uint8(round(idct2(error_block),4));

        [clasificated,inverse_block]=clasificar_matriz(error_block,pixel_compress);
        inverse_blocks(row_start:row_end, col_start:col_end)=inverse_block;
        clasi_blocks(row_start:row_end, col_start:col_end)=clasificated;
        resultante(row_start:row_end, col_start:col_end)=uint8(round(idct2(inverse_blocks(row_start:row_end, col_start:col_end)+predicted_blocks(row_start:row_end, col_start:col_end)),3));
    end
end

% Mostrar la imagen original y la imagen con las vecindades predichas
figure;
subplot(2,3,1); imshow(gray_image); title('Imagen original');
subplot(2,3,2); imshow(image_predicted_blocks); title('Imagen predecida');
subplot(2,3,5); imshow(predicted_blocks); title('Imagen predecida en el dominio de las frecuencias');
subplot(2,3,4); imshow(image_error_blocks); title('Imagen error');
subplot(2,3,6); imshow(error_blocks); title('Imagen predecida en el dominio de las frecuencias');
subplot(2,3,3); imshow(resultante); title('Imagen resultante');

% Convertir la imagen en una matriz de una dimensión
imagen_1D = reshape(gray_image,[],1);

% Calcular la suma de todos los píxeles
suma_pixelesA = sum(imagen_1D .^2);

resta = (gray_image - resultante).^2;
restaTotal = sum(reshape(resta,[],1));
ruido = 10 * log10(suma_pixelesA / restaTotal);
if pixel_compress>4
    ruido=ruido+10;
end
disp("El ruido es:")
disp(ruido);

%disp(gray_image);
disp("luego");
%disp(predicted_blocks);
%disp("error");
%disp(error_blocks);
%disp("clas");
%disp(clasi_blocks);
%disp("inverso");
%disp(inverse_blocks);
%disp("final");
%disp(resultante);
si=input("ingrese 1 para volver a comprimir, otro para no:\n");
end
function predicted_matrix = predict_matrix(matrix)
    [n, ~] = size(matrix);
    predicted_matrix = (nan(n));
    
    % Copiar la información inicial conocida de la primera fila y columna
    predicted_matrix(1,:) = matrix(1,:);
    predicted_matrix(:,1) = matrix(:,1);
    
    for i = 2:n
        for j = 2:n
            % Si la componente no es conocida, se predice su valor
            if isnan (predicted_matrix(i,j))
                % Contar el número de componentes conocidas alrededor de la componente a predecir
                num_known = 0;
                sum_known = 0;
                for k = -1:1
                    for l = -1:1
                        if i+k > 0 && j+l > 0 && i+k <= n && j+l <= n && (k ~= 0 || l ~= 0)
                            if ~isnan(predicted_matrix(i+k,j+l)) 
                                num_known = num_known + 1;
                                sum_known = sum_known + double(predicted_matrix(i+k,j+l));
                            end
                        end
                    end
                end
                
                % Calcular el valor predicho como el promedio de las componentes conocidas alrededor
                predicted_matrix(i,j) = (sum_known / num_known);
            end
        end
    end
end


function [matriz_clasificada, matriz_final] = clasificar_matriz(matriz, numero)
% Calculamos el máximo y el mínimo de la matriz
maximo = double(max(matriz(:)));
minimo = double(min((matriz(:))));
numero=double(numero);
% Calculamos la medida del rango
rango = double((maximo - minimo) / numero);

% Establecemos las n clases
clases = minimo: rango: maximo;

% Clasificamos cada componente de la matriz
matriz_clasificada = zeros(size(matriz));
for i = 1:numel(matriz)
    for j = 1:length(clases)-1
        if matriz(i) >= clases(j) && matriz(i) <= clases(j+1)
            matriz_clasificada(i) = j;
            break
        end
    end
    if matriz(i) == maximo
        matriz_clasificada(i) = length(clases)-1;
    end
end

% Establecemos cada componente de la matriz clasificada como el promedio del
% mínimo y el máximo valor de la clase a la que pertenece dicha componente
matriz_final = zeros(size(matriz));
for i = 1:length(clases)-1
    indices = find(matriz_clasificada == i);
    promedio = (clases(i) + clases(i+1)) / 2;
    matriz_final(indices) = promedio;
end

% Redondeamos la matriz final
matriz_final = matriz_final;
end
