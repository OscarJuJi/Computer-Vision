% Definir un punto inicial
punto_inicial = [1 2 3];

% Crear una figura
figura = figure;

% Crear un eje 3D
eje_3d = axes('Parent', figura, 'XLim', [-10 10], 'YLim', [-10 10], 'ZLim', [-10 10]);

% Plotear el punto inicial
scatter3(eje_3d, punto_inicial(1), punto_inicial(2), punto_inicial(3), 'filled');

% Crear tres sliders para modificar las coordenadas del punto
slider_x = uicontrol('Style', 'slider', 'Parent', figura, 'Position', [20 20 200 20], 'Min', 0, 'Max', 255, 'Value', punto_inicial(1));
slider_y = uicontrol('Style', 'slider', 'Parent', figura, 'Position', [20 50 200 20], 'Min', 0, 'Max', 255, 'Value', punto_inicial(2));
slider_z = uicontrol('Style', 'slider', 'Parent', figura, 'Position', [20 80 200 20], 'Min', 0, 'Max', 255, 'Value', punto_inicial(3));

% Agregar una función callback a cada slider para actualizar el punto
set(slider_x, 'Callback', {@update_point, eje_3d, slider_x, slider_y, slider_z, 'x'});
set(slider_y, 'Callback', {@update_point, eje_3d, slider_x, slider_y, slider_z, 'y'});
set(slider_z, 'Callback', {@update_point, eje_3d, slider_x, slider_y, slider_z, 'z'});

% Función callback para actualizar el punto
function update_point(src, event, eje_3d, slider_x, slider_y, slider_z, coordenada)
    punto_actualizado = [get(slider_x, 'Value'), get(slider_y, 'Value'), get(slider_z, 'Value')];
    delete(findall(eje_3d, 'type', 'line')); % borrar la línea anterior
    plot3(eje_3d, punto_actualizado(1), punto_actualizado(2), punto_actualizado(3), 'o', 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'r');
    set(src, 'Value', punto_actualizado(find('xyz' == coordenada)));
    set(slider_x, 'Value', punto_actualizado(1));
    set(slider_y, 'Value', punto_actualizado(2));
    set(slider_z, 'Value', punto_actualizado(3));
    
    % Anotación de texto de las coordenadas del punto
    texto = sprintf('(%0.2f, %0.2f, %0.2f)', punto_actualizado(1), punto_actualizado(2), punto_actualizado(3));
    anotacion = annotation('textbox', [0.1 0.1 0.1 0.1], 'String', texto);
    anotacion.Position = [0.1 0.1 0.1 0.1];
end
