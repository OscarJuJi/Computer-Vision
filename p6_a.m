clear;
close all;
clc;
warning off all;

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
    equalization(imagenModificada, filas, columnas, canales,sup);
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
function[imagenEcualizada] = equalization(imagenModificada, filas, columnas, canales,sup)
    [min_val, max_val] = find_min_max(imagenModificada);
  
    aux = imagenModificada;
    datos = cont(max_val, min_val, canales, columnas, filas, imagenModificada);
    for j=1:max_val-min_val+1
        for i=1:canales
            if (j==1)
               datos(i+4,j)=datos(i+1,j);
            end
            if(j~=1)
            datos(i+4,j)=datos(i+1,j)+datos(i+4,j-1);
            end
        end
    end
    nuevo =zeros(3,max_val-min_val);
    for j=1:max_val-min_val+1
        for i=1:canales
            y=(datos(i+4,j)/(filas*columnas))*(sup);
            nuevo(i,j)=round(y);
            display(y);
        end
    end

    disp(datos);
    disp(nuevo);
    for k=1:canales
        for i=1:filas
            for j=1:columnas
                for h=1:length(datos)
                    if(aux(i,j,k) == datos(1,h))
                        aux(i,j,k)=nuevo(k,h);
                    end
                end
            end
        end
    end
    hs=histeq(imagenModificada);
    figure(4)
    imshow(hs);
    [a,b]=imhist(aux);
    figure(2)
    bar(b,a);
figure(3);
imshow(aux);
    

end
function [conteo] = cont(max_val, min_val, canales, columnas, filas,imagenModificada)
conteo = zeros(canales+4,max_val-min_val,"double");
for i=1:length(conteo)+1
    conteo(1,i)=min_val-1+i;
end
for k=1:canales
     for i=1:filas
         for j=1:columnas
             for h=1:length(conteo)
                if(imagenModificada(i,j,k) == conteo(1,h))
                    conteo(1+k,h)=conteo(1+k,h)+1;
                end
             end
         end
     end
 end
end
