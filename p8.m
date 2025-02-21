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
pixel_compress=pow2(pixel_compress);
% Tamaño de las vecindades
block_size = 8;
num_blocks_horiz = floor(width / block_size);
num_blocks_vert = floor(height / block_size);
predicted_blocks = (zeros(height, width));
error_blocks = (zeros(height, width));



%Consiguiendo la matriz para la primera prediccion
tempx = [1, ((1:(width/8)-1)*8)+1];
tempy = [1, ((1:(height/8)-1)*8)+1];
predicha1 = gray_image(tempy, tempx);


%Consiguiendo la matriz para la segundo prediccion
tempx = [];
cont = 1;
ind = 1;

for i=1:width
    if(mod(i, 8)~=0)
        tempx(ind) = cont;
        ind = ind + 1;
    end
    cont = cont+1;
end

predicha2 = gray_image(tempy, tempx);

%Consiguiendo la matriz para la tercera prediccion
tempx = [1, ((1:(width/8)-1)*8)+1];
tempy = [];
cont = 1;
ind = 1;

for i=1:height
    if(mod(i,8)~=0)
        tempy(ind) = cont;
        ind=ind+1;
    end
    cont = cont+1;
end

predicha3 = gray_image(tempy, tempx);

%Consiguiendo la matriz para la cuarta prediccion
tempx = [];
cont = 1;
ind = 1;

for i=1:width
    if(mod(i, 8)~=0)
        tempx(ind) = cont;
        ind = ind + 1;
    end
    cont = cont+1;
end

predicha4 = gray_image(tempy, tempx);

predicha1=predict_predichas(predicha1,block_size);
predicha2=predict_predichas(predicha2,block_size);
predicha3=predict_predichas(predicha3,block_size);
predicha4=predict_predichas(predicha4,block_size);

predichag = zeros(height, width);

for i=1:width
    for j=1:height
        if(mod(i-1,8)==0 && mod(j-1,8)==0)
            predichag(j,i) = predicha1((j+7)/8, (i+7)/8);
        else
            if(mod(j-1,8)==0)
                predichag(j,i) = predicha2((j+7)/8, i-(ceil(i/8)));
            elseif (mod(i-1,8)==0)
                predichag(j, i) = predicha3(j-(ceil(j/8)), (i+7)/8);
            else
                predichag(j, i) = predicha4(j-(ceil(j/8)), i-(ceil(i/8)));
            end
        end
    end
end
predichag=uint8(predichag);
imshow((predichag));
%first_pixels_SS=predict_matrix(first_pixels_SS);
for i = 1:num_blocks_vert
    for j = 1:num_blocks_horiz
        row_start = (i - 1) * block_size + 1;
        row_end = row_start + block_size - 1;
        col_start = (j - 1) * block_size + 1;
        col_end = col_start + block_size - 1;
        block=dct2(gray_image(row_start:row_end, col_start:col_end));
        %block(1,1)=first_pixels_SS(i,j);
        %predicted_block = predict_matrix(block);
        predicted_block = dct2(predichag(row_start:row_end, col_start:col_end));
        predicted_blocks(row_start:row_end, col_start:col_end) =(predicted_block);
        image_predicted_blocks(row_start:row_end, col_start:col_end) =uint8(round(idct2(predicted_block),2));

        error_block=block-predicted_block;
        
        error_blocks(row_start:row_end, col_start:col_end)=error_block;
        
        image_error_blocks(row_start:row_end, col_start:col_end) =uint8(round(idct2(error_block),4));

        [clasificated,inverse_block]=clasificar_matriz(error_block,pixel_compress);
        inverse_blocks(row_start:row_end, col_start:col_end)=inverse_block;
        clasi_blocks(row_start:row_end, col_start:col_end)=clasificated;
        resultante(row_start:row_end, col_start:col_end)=uint8(round(idct2(inverse_blocks(row_start:row_end, col_start:col_end)+predicted_blocks(row_start:row_end, col_start:col_end)),3));
    end
end
figure(3);
imshow(image_predicted_blocks); 
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
function predicted_matrix = predict_matrix_4(matrix)
    [n, ~] = size(matrix);
    predicted_matrix = (nan(n));
    
    % Copiar la información inicial conocida de la primera fila y columna
    predicted_matrix(1,:) = matrix(1,:);
    predicted_matrix(:,1) = matrix(:,1);
    
    % Variable to alternate between calculating rows and columns
    calculate_row = true;
    
    % Loop until all elements are predicted
    while any(isnan(predicted_matrix(:)))
        if calculate_row
            % Calculate each unknown element in the current row
            for i = 2:n
                for j = 2:n
                    if isnan(predicted_matrix(i,j))
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
                        predicted_matrix(i,j) = (sum_known / num_known);
                    end
                end
            end
            calculate_row = false;
        else
            % Calculate each unknown element in the current column
            for j = 2:n
                for i = 2:n
                    if isnan(predicted_matrix(i,j))
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
                        predicted_matrix(i,j) = (sum_known / num_known);
                    end
                end
            end
            calculate_row = true;
        end
    end
end

function predicted_matrix = predict_matrix(matrix)
    [n, ~] = size(matrix);
    predicted_matrix = nan(n);
    
    % Copiar la información inicial conocida de la primera fila y columna
    predicted_matrix(1,:) = matrix(1,:);
    predicted_matrix(:,1) = matrix(:,1);
    
    for i = 2:n
        for j = 2:n
            % Si la componente no es conocida, se predice su valor
            if isnan(predicted_matrix(i,j))
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
                predicted_matrix(i,j) = uint8(round(sum_known / num_known));
            end
        end
    end
end
function predicted_matrix = predict_predichas(matrix,block_size)
    [height, width] = size(matrix);
    
    num_blocks_horiz = floor(width / block_size);
    num_blocks_vert = floor(height / block_size);
    predicted_blocks = (zeros(height, width));
    for i = 1:num_blocks_vert
        for j = 1:num_blocks_horiz
            row_start = (i - 1) * block_size + 1;
            row_end = row_start + block_size - 1;
            col_start = (j - 1) * block_size + 1;
            col_end = col_start + block_size - 1;
            block=dct2(matrix(row_start:row_end, col_start:col_end));
            %block(1,1)=first_pixels_SS(i,j);
            predicted_block = predict_matrix_4((block));
            predicted_blocks(row_start:row_end, col_start:col_end) =uint8(round(idct2(predicted_block),4));
            %predicted_blocks(row_start:row_end, col_start:col_end) =predicted_block;
        end
    end
    predicted_matrix=predicted_blocks;
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
