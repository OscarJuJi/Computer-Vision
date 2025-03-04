function imagen_ajustada = ajustar_azules_imagen(imagen)
    % Convertir la imagen de RGB a HSV
    imagen_hsv = rgb2hsv(imagen);

    % Extraer los componentes HSV
    H = imagen_hsv(:,:,1);
    S = imagen_hsv(:,:,2);
    V = imagen_hsv(:,:,3);

    % Calcular el umbral adaptativo para el cielo
    hist_sky = imhist(H(S > 0.1));
    cdf_sky = cumsum(hist_sky) / sum(hist_sky);
    threshold_sky = find(cdf_sky > 0.05, 1, 'first') / numel(cdf_sky);

    % Calcular el umbral adaptativo para el mar
    hist_sea = imhist(H(S > 0.1 & V > 0.2));
    cdf_sea = cumsum(hist_sea) / sum(hist_sea);
    threshold_sea = find(cdf_sea > 0.05, 1, 'first') / numel(cdf_sea);

    % Definir el rango de tonalidades azules del cielo y el mar en HSV
    rango_cielo = [threshold_sky 0.5444]; % Utilizar umbral adaptativo para el cielo
    rango_mar = [.6555 threshold_sea]; % Utilizar umbral adaptativo para el mar

    % Crear una máscara para el cielo
    mascara_cielo = (H >= rango_cielo(1) & H <= rango_cielo(2) & S > 0.1);

    % Crear una máscara para el mar
    mascara_mar = (H >= rango_mar(1) & H <= rango_mar(2) & S > 0.1);

    % Ajustar el matiz para el cielo
    H_ajustado_cielo = H(mascara_cielo) + 0.2; % Ajusta este valor para cambiar la tonalidad
    H_ajustado_cielo(H_ajustado_cielo > 1) = H_ajustado_cielo(H_ajustado_cielo > 1) - 1;

    % Ajustar el matiz para el mar
    H_ajustado_mar = H(mascara_mar) - 0.2; % Ajusta este valor para cambiar la tonalidad
    H_ajustado_mar(H_ajustado_mar < 0) = H_ajustado_mar(H_ajustado_mar < 0) + 1;

    % Asignar los valores ajustados de matiz
    H(mascara_cielo) = H_ajustado_cielo;
    H(mascara_mar) = H_ajustado_mar;

    % Unir los componentes HSV ajustados
    imagen_hsv(:,:,1) = H;

    % Convertir la imagen HSV ajustada de vuelta a RGB
    imagen_ajustada = hsv2rgb(imagen_hsv);

    % Mostrar la imagen original y la imagen ajustada
    figure;
    subplot(1, 2, 1);
    imshow(imagen);
    title('Imagen original');
    subplot(1, 2, 2);
    imshow(imagen_ajustada);
    title('Imagen ajustada');
end
