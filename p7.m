close all;
clc;

img = imread('imgp.jpg');

lim_inf = [];
lim_sup = [];
 
n= 0;

while true
    entrada = input('Ingrese el límite inferior y superior (presione Enter para salir): ', 's');
    if isempty(entrada)
        break; 
    end
    valores = strsplit(entrada);
    if length(valores) ~= 2
        disp('Debe ingresar exactamente dos valores');
        continue; 
    end
                                                                                                        
    lim_inf_nuevo = str2double(valores{1});
    lim_sup_nuevo = str2double(valores{2});

    if isnan(lim_inf_nuevo) || isnan(lim_sup_nuevo)
        disp('Debe ingresar valores numéricos');
        continue; 
    end
    if lim_inf_nuevo < 0 || lim_inf_nuevo > 255 || lim_sup_nuevo < 0 || lim_sup_nuevo > 255
        disp('Los límites deben estar entre 0 y 255');
        continue;
    end
    
    lim_inf = lim_inf_nuevo;
    lim_sup = lim_sup_nuevo;
    [n,img]= modificarImagen(n, img, lim_sup, lim_inf);
end

function [n, imagenModificada] = modificarImagen(n, img, sup, inf)
    if n > 0
        close(n);
    end
    [min_val, max_val] = find_min_max(img);
    
    imagenModificada = zeros(size(img), 'like', img);

    [filas, columnas, canales] = size(imagenModificada);

    val2 = max_val - min_val;
    val4 = sup - inf;

    val2_double = double(val2);

    for k = 1 : canales
        for i = 1 : filas
            for j = 1 : columnas
                val1 = img(i, j, k) - min_val;
                val3 = uint16(val1) * uint16(val4);
                val5 = val3/ val2_double;
                imagenModificada(i, j, k) = val5 +inf;
            end
        end
    end
    
    imagenEcualizada = ecualizarImagen(imagenModificada, inf, sup);

    if n ~= 1
        n = 1;
    end
    
    mostrar_componentes_histograma(n, imagenModificada, imagenEcualizada, img);
end

function [min_val, max_val] = find_min_max(img)
    min_val = min(img(:));
    max_val = max(img(:));
end

function imagenEcualizada = ecualizarImagen(imagenModificada, min_val, max_val)
    imagenEcualizada = zeros(size(imagenModificada), 'like', imagenModificada);
    
    valores_R = calcular_valores(imagenModificada(:, :, 1));
    valores_G = calcular_valores(imagenModificada(:, :, 2));
    valores_B = calcular_valores(imagenModificada(:, :, 3));

    for i = 1:size(imagenModificada, 1)
        for j = 1:size(imagenModificada, 2)
            imagenEcualizada(i, j, 1) = ((max_val - min_val) * valores_R.prob_acumulada(find(valores_R.intensidades == imagenModificada(i, j, 1)))) + min_val;
            imagenEcualizada(i, j, 2) = ((max_val - min_val) * valores_G.prob_acumulada(find(valores_G.intensidades == imagenModificada(i, j, 2)))) + min_val;
            imagenEcualizada(i, j, 3) = ((max_val - min_val) * valores_B.prob_acumulada(find(valores_B.intensidades == imagenModificada(i, j, 3)))) + min_val;
        end
    end
    
end

function valores = calcular_valores(canal)
    intensidades = unique(canal);
    cantidades = histcounts(canal, length(intensidades));
    probabilidades = cantidades / numel(canal);
    prob_acumulada = cumsum(probabilidades);
    valores.intensidades = intensidades;
    valores.cantidades = cantidades;
    valores.probabilidades = probabilidades;
    valores.prob_acumulada = prob_acumulada;
end

function mostrar_componentes_histograma(n,imgB, imgMod, img)
    figure(n);
    subplot(3,2,1);
    imshow(img);
    title('Imagen original');
    subplot(3,2,2);
    imhist(img);
    title('Histograma de la imagen original');

    subplot(3,2,3);
    imshow(imgB);
    title('Imagen modificada');
    subplot(3,2,4);
    imhist(imgB);
    title('Histograma de la imagen modificada');
    
    subplot(3,2,5);
    imshow(imgMod);
    title('Imagen ecualizada (modificada)');
    subplot(3,2,6);
    imhist(imgMod);
    title('Histograma de la imagen ecualizada (modificada)');
end