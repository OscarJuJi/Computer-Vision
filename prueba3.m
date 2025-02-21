% Lee la imagen
img = imread('test.jpg');

% Convierte la imagen en escala de grises
img_gray = rgb2gray(img);

% Calcula el histograma de la imagen
hist_img = imhist(img_gray);

% Calcula la función de distribución acumulativa (CDF) del histograma
cdf_img = cumsum(hist_img) / numel(img_gray);

% Ecualiza la imagen
img_eq = uint8(255 * cdf_img(img_gray+1));

% Muestra la imagen original y la imagen ecualizada
subplot(1,2,1); imshow(img_gray); title('Imagen original');
subplot(1,2,2); imshow(img_eq); title('Imagen ecualizada');
