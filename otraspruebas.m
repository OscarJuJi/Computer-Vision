% Cargar la imagen
imagen = imread('imgp.jpg'); % Reemplaza 'nombre_de_tu_imagen.jpg' por la ruta de tu imagen

% Valores RGB buscados
rojo = 231; % Valor de rojo deseado
verde = 227; % Valor de verde deseado
azul = 218; % Valor de azul deseado
% Buscar el primer píxel que cumpla con los valores RGB dados
[m, n, ~] = size(imagen);
encontrado = false;
coordenadas = [];
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

% Mostrar ubicación del primer píxel encontrado
if encontrado
    fprintf('Primer píxel encontrado en la ubicación: (%d, %d)\n', coordenadas(1), coordenadas(2));
    
    % Marcar el píxel encontrado con un punto negro más grande
    imagen_etiquetada = imagen;
    radio_punto = 1; % Tamaño del punto negro
    imagen_etiquetada(max(1, coordenadas(1)-radio_punto):min(m, coordenadas(1)+radio_punto), max(1, coordenadas(2)-radio_punto):min(n, coordenadas(2)+radio_punto), :) = 0;
    
    % Agregar etiqueta en la ubicación del píxel
    etiqueta = 'Primer píxel';
    imagen_etiquetada = insertText(imagen_etiquetada, [coordenadas(2) coordenadas(1)], etiqueta, 'FontSize', 12, 'TextColor', 'red', 'BoxOpacity', 0.8);
    
    % Mostrar la imagen con el punto y la etiqueta marcados
    imshow(imagen_etiquetada);
else
    fprintf('No se encontró ningún píxel con los valores RGB especificados.\n');
end