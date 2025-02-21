close all;
clc;

img = imread('test.jpg');

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
    if n ~= 1
        n = 1;
    end
    mostrar_componentes_histograma(n, imagenModificada, img);
end

function [min_val, max_val] = find_min_max(img)
    min_val = min(img(:));
    max_val = max(img(:));
end


function mostrar_componentes_histograma(n, imgMod, img)
    figure(n);
    subplot(4,3,1);
    imshow(img);
    title('Imagen original');
    subplot(4,3,3);
    imshow(imgMod);
    title('Imagen resultante');

    for i = 1:3
        componente = img(:,:,i);
        
        [counts, bins] = imhist(componente);
    
        nombre_componente = sprintf('RGB(%d)', i);
    
        subplot(4,3,3*i+1);
        imshow(componente);
        title(sprintf('Componente %s', nombre_componente));
    
        subplot(4,3,3*i+2);
        bar(bins, counts);
        title(sprintf('Histograma de la componente %s', nombre_componente));
    
        componente_mod = imgMod(:,:,i);
    
        [counts_mod, bins_mod] = imhist(componente_mod);
    
        subplot(4,3,3*i+3);
        bar(bins_mod, counts_mod);
        title(sprintf('Histograma de la componente %s Imagen Modificada', nombre_componente));
    end
end
