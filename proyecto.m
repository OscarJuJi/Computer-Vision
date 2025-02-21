clc;
close all;
clear ;
warning off all;
imagen_dir="mountain.jpg";
% Cargar la imagen

%GUI=GUI_Proyecto;
%if isvalid(GUI)
%   waitfor(GUI) 
%end
imagen = imread(imagen_dir);
%tipodeimagen=['PLaya'];
%GUI_Proyecto(GUI,tipodeimagen);
% Cambiar el tamaño de las colonias a 4x4
imagen_colonias = imagen;

for c = 1:3
    capa = imagen(:,:,c);
    
    [m, n] = size(capa);
    num_filas = floor(m/4);
    num_columnas = floor(n/4);
    
    for i = 1:num_filas
        for j = 1:num_columnas
            colonia = capa((i-1)*4+1:i*4, (j-1)*4+1:j*4);
            promedio = mean(colonia, 'all');
            capa((i-1)*4+1:i*4, (j-1)*4+1:j*4) = promedio;
        end
    end
    
    imagen_colonias(:,:,c) = capa;
end

% Aplicar un filtro de ruido y suavizado a cada capa RGB
imagen_filt_suav = imagen_colonias;

for c = 1:3
    capa = imagen_colonias(:,:,c);

    % Aplicar un filtro de ruido a la capa
    capa_filtrada = medfilt2(capa);

    % Aplicar suavizado a la capa filtrada
    h = fspecial('gaussian', [5 5], 1); % Filtro gaussiano
    capa_suavizada = imfilter(capa_filtrada, h);

    % Actualizar la capa en la imagen filtrada y suavizada
    imagen_filt_suav(:,:,c) = capa_suavizada;
end

% Convertir la imagen filtrada y suavizada a escala de grises
imagen_gris = rgb2gray(imagen_filt_suav);

% Aplicar el algoritmo de Canny para detectar los bordes
p_de_playa=0;
V_de_volcan=0;

if(imagen_dir{1}(1)=='p'||imagen_dir{1}(1)=='P')
p_de_playa=1;
umbral_min = 0.02;  % Umbral mínimo para la detección de bordes
umbral_max = 0.12;  % Umbral máximo para la detección de bordes
else 
if(imagen_dir{1}(1)=='m')
umbral_min = 0.093234;  % Umbral mínimo para la detección de bordes
umbral_max = 0.201244;  % Umbral máximo para la detección de bordes
else 
if(imagen_dir{1}(1)=='C')
umbral_min = 0.12334;  % Umbral mínimo para la detección de bordes
umbral_max = 0.441244;  % Umbral máximo para la detección de bordes
elseif(imagen_dir{1}(1)=='V')
V_de_volcan=1;
umbral_min = 0.062334;  % Umbral mínimo para la detección de bordes
umbral_max = 0.211244;  % Umbral máximo para la detección de bordes
else
umbral_min = 0.03834;  % Umbral mínimo para la detección de bordes
umbral_max = 0.2441244;  % Umbral máximo para la detección de bord
end
end
end
se = strel("arbitrary", 1);
imagen_gris = imclose(imagen_gris, se);
bordes = edge(imagen_gris, 'canny', [umbral_min umbral_max]);

% Recortar los bordes de las imágenes
bordes = bordes(4:end-3, 4:end-3);
imagen = imagen(4:end-3, 4:end-3, :);
imagen_colonias = imagen_colonias(4:end-3, 4:end-3, :);
imagen_filt_suav = imagen_filt_suav(4:end-3, 4:end-3, :);

% Mostrar la imagen original, la imagen con las colonias cambiadas de tamaño, la imagen filtrada y suavizada, y los bordes detectados
figure;
subplot(2, 2, 1);
imshow(imagen);
title('Imagen original');
subplot(2, 2, 2);
imshow(imagen_colonias);
title('Imagen con colonias 4x4');
subplot(2, 2, 3);
imshow(imagen_filt_suav);
title('Imagen filtrada y suavizada');
subplot(2, 2, 4);
imshow(bordes);
title('Bordes detectados');





% Obtener las coordenadas de los bordes
[row, col] = find(bordes);
coords = [col, row];  % Matriz de coordenadas [x, y]

% Extraer los valores RGB de las esquinas del contorno
corner_colors = zeros(size(coords, 1), 3);
for i = 1:size(coords, 1)
    x = coords(i, 1);
    y = coords(i, 2);
    corner_colors(i, :) = imagen(y, x, :);
end

% Aplicar el algoritmo de k-means con 4 clusters a los valores RGB de las esquinas
klist=2:5;%the number of clusters you want to try
myfunc = @(X,K)(kmeans(X, K));
eva = evalclusters(corner_colors,myfunc,'CalinskiHarabasz','klist',klist);
if(p_de_playa==1)
num_clusters = eva.OptimalK-1;
else
    num_clusters = eva.OptimalK;
end
[cluster_idx, Centros] = kmeans(corner_colors, (num_clusters));
disp(Centros);

Centros=uint8(Centros);
verde_arbol=uint8([45 50 45]);
verde_pasto=uint8([120 140 35]);
nube=uint8([225 225 225]);
arena=uint8([200 200 200]);
azul_agua=uint8([110 160 180]);
azul_cielo=uint8([90 125 159]);
azul_cielo_claro=uint8([155 185 205]);
roca=uint8([115 120 70]);
lava=uint8([225 150 50]);
if(V_de_volcan==1)
montana=uint8([65 25 45]);
end
cielo=[10 200];
mar=[200 100];
for i=1:size(Centros,1)
    representantes(i,:)=encontrarPixel(imagen,Centros(i,1),Centros(i,2),Centros(i,3));
    centro_actual = Centros(i, :);
    dist_roca =  sum((centro_actual - roca).^2).^0.5;
    dist_lava =  sum((centro_actual - lava).^2).^0.5;
    dist_verde_arbol =  sum((centro_actual - verde_arbol).^2).^0.5;
    dist_verde_pasto =  sum((centro_actual - verde_pasto).^2).^0.5;
    dist_nube =  sum((centro_actual - nube).^2).^0.5;
    dist_arena =  sum((centro_actual - arena).^2).^0.5;
    dist_azul_agua =  sum((centro_actual - azul_agua).^2).^0.5;
    dist_azul_cielo =  sum((centro_actual - azul_cielo).^2).^0.5;
    dist_azul_cielo_claro =  sum((centro_actual - azul_cielo_claro).^2).^0.5;
    disp(dist_azul_cielo_claro);
    disp(dist_verde_pasto);
    array_clasificacion=char([]);
    % Comparar las distancias y asignar el nombre de la clase correspondiente
    if (dist_verde_arbol < 24 )
    array_clasificacion{i} = 'arbol';
elseif (dist_verde_arbol < 24 && imagen_dir{1}(1) == 'm' )
    array_clasificacion{i} = 'follaje';
elseif (dist_verde_pasto < 12 && p_de_playa == 0 )
    array_clasificacion{i} = 'pasto';
elseif (dist_nube < 13 && p_de_playa == 0 )
    if (imagen_dir{1}(1) ~= 'm'&&imagen_dir{1}(2) ~= 'm')
        array_clasificacion{i} = 'nube';
    elseif (~any(strcmp('roca', array_clasificacion)))
        array_clasificacion{i} = 'roca';
        disp("roca1");
    end
elseif (dist_azul_agua < 20 )
    array_clasificacion{i} = 'agua';
elseif (dist_azul_cielo < 18 )
    array_clasificacion{i} = 'cielo';
elseif (dist_azul_cielo_claro < 8 )
    array_clasificacion{i} = 'cielo';
elseif (dist_arena < 24 && p_de_playa == 1 && ~any(strcmp('arena', array_clasificacion)))
    array_clasificacion{i} = 'arena';
elseif (dist_lava < 13 && p_de_playa == 0 && ~any(strcmp('lava', array_clasificacion)))
    array_clasificacion{i} = 'lava';
elseif (dist_roca < 19 && any(strcmp('roca', array_clasificacion)))
    array_clasificacion{i} = 'roca';
    disp("roca");
else
    array_clasificacion{i} = 'desconocido';
end


end
disp(representantes);
array_clasificacion=char(array_clasificacion);
imagen_etiquetada=imagen;
radio_punto = 1; % Tamaño del punto negro
bucle=size(Centros,1);
inicio=1;
imagen_etiquetada(max(1,  cielo(1)-radio_punto):min(m,  cielo(1)+radio_punto), max(1,  cielo(2)-radio_punto):min(n,  cielo(2)+radio_punto), :) = 0;
    
    % Agregar etiqueta en la ubicación del píxel
    etiqueta = 'cielo';
    imagen_etiquetada = insertText(imagen_etiquetada, [ cielo(2)  cielo(1)], etiqueta, 'FontSize', 12, 'TextColor', 'red', 'BoxOpacity', 0.8);
    imagen_etiquetada(max(1,   mar(1)-radio_punto):min(m,   mar(1)+radio_punto), max(1,   mar(2)-radio_punto):min(n,   mar(2)+radio_punto), :) = 0;
    if(p_de_playa==1)
    % Agregar etiqueta en la ubicación del píxel
    etiqueta = ' mar';
    imagen_etiquetada = insertText(imagen_etiquetada, [  mar(2)   mar(1)], etiqueta, 'FontSize', 12, 'TextColor', 'red', 'BoxOpacity', 0.8);
    end
for it=1:bucle
    if(array_clasificacion{it}~="cielo"&&(array_clasificacion{it}~="agua"))
    imagen_etiquetada(max(1,  representantes(it,1)-radio_punto):min(m,  representantes(it,1)+radio_punto), max(1,  representantes(it,2)-radio_punto):min(n,  representantes(it,2)+radio_punto), :) = 0;
    
    % Agregar etiqueta en la ubicación del píxel
    etiqueta = array_clasificacion{it};
    imagen_etiquetada = insertText(imagen_etiquetada, [ representantes(it,2)  representantes(it,1)], etiqueta, 'FontSize', 12, 'TextColor', 'red', 'BoxOpacity', 0.8);
% Dibujar el contorno de acuerdo al cluster al que pertenece cada punto
    end
end
figure;
imshow(imagen_etiquetada);
hold on;
for i = 1:numel(row)
    x = col(i);
    y = row(i);
    cluster = cluster_idx(i);
    if cluster == 1
        color = 'r';  % Rojo
    elseif cluster == 2
        color = 'g';  % Verde
    elseif cluster == 3
        color = 'b';  % Azul
    elseif cluster == 4
        color = 'y';  % Amarillo
    elseif cluster == 5
        color = 'w';  % Amarillo
    end
    plot(x, y, '.', 'Color', color);
end
title('Contorno según el cluster');
function coordenadas = encontrarPixel(imagen, rojo, verde, azul)
    % Obtener las dimensiones de la imagen
    [m, n, ~] = size(imagen);
    
    % Guardar los valores iniciales para usarlos en cada iteración
    rojo_inicial = rojo;
    verde_inicial = verde;
    azul_inicial = azul;
    
    % Buscar el primer píxel que cumpla con los valores RGB dados
    encontrado = false;
    coordenadas = [];
    hola=1;
    while ~encontrado
        
        for i = 1:m
            for j = 1:n
                pixel = squeeze(double(imagen(i, j, :)));
                if pixel(1) == rojo && pixel(2) == verde && pixel(3) == azul
                    coordenadas = [i, j];
                    encontrado = true;
                    break;
                end
            end
            if encontrado
                break;
            end
        end
        
        if ~encontrado
            
            % Restar valores aleatorios entre 1 y 20 a los componentes RGB
            rojo = max(rojo_inicial - randi([1, 20]), 0);
            verde = max(verde_inicial - randi([1, 20]), 0);
            azul = max(azul_inicial - randi([1, 20]), 0);
        end
    end
    
    % Mostrar ubicación del primer píxel encontrado
    
end
