% Configuración de la carpeta de imágenes
image_folder = './img';
output_folder = './output';

% Obtener la lista de archivos de imagen en la carpeta
images = dir(fullfile(image_folder, '*.jpg')); % Cambia el tipo de archivo según tus necesidades

% Inicializar listas para almacenar resultados
center_x = [];
center_y = [];
area_a = [];
perimetro_a = [];
contador_a = [];

% Iterar sobre todas las imágenes en la carpeta
for i = 1:length(images)
    contador = 0;
    
    % Leer la imagen en escala de grises
    image_path = fullfile(image_folder, images(i).name);
    image = imread(image_path);
    gray_image = rgb2gray(image);
    
    % Aplicar umbral para obtener la imagen binaria
    binary_image = gray_image > 128;

    % Encontrar contornos en la imagen binaria
    contours = bwboundaries(binary_image, 'holes');

    for j = 1:length(contours)
        % Calcular el área del objeto
        area = regionprops(contours{j}, 'Area');
        area = area.Area;

        % Filtro para eliminar objetos pequeños
        if area < 100
            continue;
        end

        % Incrementar el contador para este objeto
        contador = contador + 1;

        % Calcular el perímetro del objeto
        perimeter = regionprops(contours{j}, 'Perimeter');
        perimeter = perimeter.Perimeter;

        % Dibujar un rectángulo alrededor del objeto
        stats = regionprops(contours{j}, 'BoundingBox');
        boundingBox = stats.BoundingBox;

        x = boundingBox(1);
        y = boundingBox(2);
        w = boundingBox(3);
        h = boundingBox(4);

        center_x = [center_x, x + w / 2];
        center_y = [center_y, y + h / 2];
        area_a = [area_a, area];
        perimetro_a = [perimetro_a, perimeter];
    end

    % Agregar el contador de objetos de esta imagen a la lista
    contador_a = [contador_a, contador];
end

% Crear matriz de características
features = [area_a', perimetro_a'];

% Entrenar el modelo KMeans con 5 clusters
kmeans_model = kmeans(features, 5);


% Almacenar las etiquetas de clase en un nuevo arreglo para su clasificación
classifications = kmeans_model;

% Imprimir las clasificaciones
disp(classifications);

% Gráfico de dispersión para visualizar los clusters
scatter(features(:, 1), features(:, 2), 20, classifications, 'filled');
title('Gráfico de Dispersión de Clusters');
xlabel('Área');
ylabel('Perímetro');

% Crear carpeta de salida si no existe
if ~exist(output_folder, 'dir')
    mkdir(output_folder);
end

% Iterar sobre las imágenes para colorear los contornos y guardarlas
for i = 1:length(images)
    image_path = fullfile(image_folder, images(i).name);
    output_path = fullfile(output_folder, images(i).name);

    % Leer la imagen a color
    image = imread(image_path);

    % Crear una copia de la imagen original para colorear los contornos
    image_colored = image;

    % Convertir la imagen a escala de grises para trabajar con contornos
    gray_image = rgb2gray(image);

    % Aplicar umbral o cualquier otro procesamiento que necesites para detectar contornos
    binary_image = gray_image > 128;

    % Encontrar contornos en la imagen binaria
    contours = bwboundaries(binary_image, 'holes');

    for j = 1:length(contours)
        % Calcular el área del objeto
        area = regionprops(contours{j}, 'Area');
        area = area.Area;

        % Filtro para eliminar objetos pequeños
        if area < 100
            continue;
        end

        % Calcular el perímetro del objeto
        perimeter = regionprops(contours{j}, 'Perimeter');
        perimeter = perimeter.Perimeter;

        % Colorear el contorno según la clasificación
        color = getColor(classifications(i));

        % Dibujar el contorno coloreado en la imagen original
        image_colored = insertShape(image_colored, 'Polygon', contours{j}, 'Color', color, 'LineWidth', 2);

        % Agregar texto con el área y el perímetro
        text = sprintf('A: %.1f, P: %.1f', area, perimeter);
        position = [contours{j}(1, 2), contours{j}(1, 1)];
        image_colored = insertText(image_colored, position, text, 'FontSize', 8, 'BoxColor', 'white', 'TextColor', 'black');
    end

    % Guardar la imagen coloreada en la carpeta de salida
    imwrite(image_colored, output_path);
end

% Función para asignar colores según la clasificación
function color = getColor(classification)
    switch classification
        case 1
            color = [255, 0, 0]; % Rojo
        case 2
            color = [0, 255, 0]; % Verde
        case 3
            color = [0, 0, 255]; % Azul
        case 4
            color = [255, 255, 0]; % Amarillo
        case 5
            color = [255, 0, 255]; % Magenta
        otherwise
            color = [0, 0, 0]; % Negro por defecto
    end
end
