clc;
clear all;
close all;
warning off all

directorio = 'image_Dataset/';

tabla_caracteristicas = table('Size', [0, 4], 'VariableTypes', {'double', 'double', 'double', 'string'}, 'VariableNames', {'Area', 'Centro_de_Gravedad', 'Perimetro', 'Nombre_de_Imagen'});

for N = 1:100
    nombre_imagen = sprintf('imagen%d.png', N);
    
    imagen = imread(fullfile(directorio, nombre_imagen));
    
    % Procesar la imagen y calcular las características
    caracteristicas = procesar_imagen(imagen, nombre_imagen);
    
    % Agregar las características a la tabla
    tabla_caracteristicas = [tabla_caracteristicas; caracteristicas];
end

disp(tabla_caracteristicas);

% Crear una nube de puntos con área en el eje x y perímetro en el eje y
% scatter(tabla_caracteristicas.Area, tabla_caracteristicas.Perimetro);

% % Etiquetas para los ejes
% xlabel('Área');
% ylabel('Perímetro');
% 
% % Título del gráfico
% title('Nube de puntos de Área vs. Perímetro');
% 
% % Mostrar la cuadrícula en el gráfico
% grid on;

caracteristicas = tabla_caracteristicas(:, {'Area', 'Perimetro'});

% Número de clusters deseado
num_clusters = 5;

caracteristicas = normalize(caracteristicas);

% Realizar el agrupamiento K-means con inicialización 'plus'
[idx, cent] = kmeans(caracteristicas{:,:}, num_clusters);

% Agregar las etiquetas de los clusters a la tabla
tabla_caracteristicas.Clasificacion = idx;

% Imprimir la tabla con las etiquetas de los clusters
disp(tabla_caracteristicas);

% Realizar el plot de los datos agrupados
figure;
hold on;

colores = lines(num_clusters);

% Nombres de los grupos
nombres_grupos = {'Tornillo', 'rodana', 'colas pato', 'llave', 'gancho'};

% Loop sobre los clusters
for i = 1:num_clusters
    grupo_i = caracteristicas(idx == i, :);
    scatter(grupo_i.Area, grupo_i.Perimetro, [], colores(i, :), 'filled', 'DisplayName', nombres_grupos{i});
end

% Añadir leyenda
legend('Location', 'best');


% Etiquetas para los ejes
xlabel('Área');
ylabel('Perímetro');

title('Agrupamiento K-means');

legend();

grid on;
hold off;

tabla_caracteristicas.Clasificacion = idx;

tabla_caracteristicas = sortrows(tabla_caracteristicas, 'Clasificacion');

disp(tabla_caracteristicas);


while true
    [nombre_imagen, directorio_imagen] = uigetfile(fullfile(directorio, '*.png'), 'Seleccione una imagen o presione Cancelar para salir');

    if isequal(nombre_imagen, 0)
        break;
    end
    
    disp(['Imagen seleccionada: ',nombre_imagen]);

    selected_image_class = unique(tabla_caracteristicas.Clasificacion(strcmp(tabla_caracteristicas.Nombre_de_Imagen, nombre_imagen)));

    shared_class_images = tabla_caracteristicas(ismember(tabla_caracteristicas.Clasificacion, selected_image_class), :);

    unique_shared_image_names = unique(tabla_caracteristicas.Nombre_de_Imagen(ismember(tabla_caracteristicas.Clasificacion, selected_image_class)));

    disp(unique_shared_image_names);

    current_image_index = 1;

    fig = uifigure('Name', 'Image Viewer');
    fig.Position(3:4) = [800, 600];  % Adjust the figure size as needed
    
    nextButton = uibutton(fig, 'push', 'Text', 'Next', 'Position', [350, 20, 100, 30]);
    nextButton.ButtonPushedFcn = @(btn, event) showNextImage(current_image_index,unique_shared_image_names);
    
    ax = uiaxes(fig, 'Position', [50, 80, 700, 500]);
    
    image_name = unique_shared_image_names{current_image_index};
    image_path = fullfile(directorio, image_name);
    imshow(image_path, 'Parent', ax);
    
    fig.Visible = 'on';
end
disp(cent)

function showNextImage(current_image_index, unique_shared_image_names )
    directorio = 'image_Dataset/';
    fig = uifigure('Name', 'Image Viewer');
    fig.Position(3:4) = [800, 600];  % Adjust the figure size as needed
    ax = uiaxes(fig, 'Position', [50, 80, 700, 500]);
        if current_image_index < numel(unique_shared_image_names)
            current_image_index = current_image_index + 1;
            image_name = unique_shared_image_names{current_image_index};
            image_path = fullfile(directorio, image_name);
            imshow(image_path, 'Parent', ax);
        end
    % Create a UI button for "Next"
    nextButton = uibutton(fig, 'push', 'Text', 'Next', 'Position', [350, 20, 100, 30]);
    nextButton.ButtonPushedFcn = @(btn, event) showNextImage(current_image_index,unique_shared_image_names);
end


function caracteristicas = procesar_imagen(imagen, nombre_imagen)
    imagen_gris = rgb2gray(imagen);
    imagen_gris = wiener2(imagen_gris, [10, 10]);
    imagen_gris = im2bw(imagen_gris, 0.33);

    imagen_gris = bwareaopen(imagen_gris, 130);
    se = strel('disk', 8);
    imagen_gris = imclose(imagen_gris, se);

    [B, L, Num] = bwboundaries(imagen_gris, 'noholes');

    stats = regionprops(L, 'Area', 'Perimeter', 'Centroid');
    threshold = 0.081;
    
    % Inicializar la tabla de características
    caracteristicas = table('Size', [0, 4], 'VariableTypes', {'double', 'double', 'double', 'string'}, 'VariableNames', {'Area', 'Centro_de_Gravedad', 'Perimetro', 'Nombre_de_Imagen'});
    
    for k = 1:Num
        area = stats(k).Area;
        perimeter = stats(k).Perimeter;
        metric = 4 * pi * area / perimeter^2;
        centroid = stats(k).Centroid;
        
        if metric > threshold
            % Agregar las características a la tabla
            caracteristicas = [caracteristicas; {area, centroid, perimeter, nombre_imagen}];
        end
    end
end
