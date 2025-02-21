close all;
clc;

imgA = imread("untitled.jpg");
imgB = imread('Paisaje.jpg');


imagenCorrespondencia(imgA, imgB);


function imagenCorrespondencia(imgA, imgB)
    imagenModificada = imgB;
    
    valores_R_A = calcular_valores(imgA(:, :, 1));
    valores_G_A = calcular_valores(imgA(:, :, 2));
    valores_B_A = calcular_valores(imgA(:, :, 3));
    
    valores_R_B = calcular_valores(imgB(:, :, 1));
    valores_G_B = calcular_valores(imgB(:, :, 2));
    valores_B_B = calcular_valores(imgB(:, :, 3));

    intensidades_R_B = valores_R_B.intensidades;
    intensidades_G_B = valores_G_B.intensidades;
    intensidades_B_B = valores_B_B.intensidades;
    
    resultados_R = zeros(2, length(intensidades_R_B));
    resultados_G = zeros(2, length(intensidades_G_B));
    resultados_B = zeros(2, length(intensidades_B_B));
    
    for i = 1:length(intensidades_R_B)
        nivel_gris = intensidades_R_B(i);
        prob_acumulada_R_B = valores_R_B.prob_acumulada(find(intensidades_R_B == nivel_gris));
        [~, idx_R] = min(abs(valores_R_A.prob_acumulada - prob_acumulada_R_B));
        nivel_gris_correspondiente_R = valores_R_A.intensidades(idx_R);
        resultados_R(1, i) = nivel_gris;
        resultados_R(2, i) = nivel_gris_correspondiente_R;
    end
    for i = 1:length(intensidades_G_B)
        nivel_gris = intensidades_G_B(i);
        prob_acumulada_G_B = valores_G_B.prob_acumulada(find(intensidades_G_B == nivel_gris));
        [~, idx_G] = min(abs(valores_G_A.prob_acumulada - prob_acumulada_G_B));
        nivel_gris_correspondiente_G = valores_G_A.intensidades(idx_G);
        resultados_G(1, i) = nivel_gris;
        resultados_G(2, i) = nivel_gris_correspondiente_G;
    end
    for i = 1:length(intensidades_B_B)
        nivel_gris = intensidades_B_B(i);
        prob_acumulada_B_B = valores_B_B.prob_acumulada(find(intensidades_B_B == nivel_gris));
        [~, idx_B] = min(abs(valores_B_A.prob_acumulada - prob_acumulada_B_B));
        nivel_gris_correspondiente_B = valores_B_A.intensidades(idx_B);
        resultados_B(1, i) = nivel_gris;
        resultados_B(2, i) = nivel_gris_correspondiente_B;
    end
    
    for i = 1:size(imgB, 1)
        for j = 1:size(imgB, 2)
            nivel_gris_actual_R = imgB(i, j, 1);
            nivel_gris_actual_G = imgB(i, j, 2);
            nivel_gris_actual_B = imgB(i, j, 3);
            idx_R = find(resultados_R(1, :) == nivel_gris_actual_R);
            idx_G = find(resultados_G(1, :) == nivel_gris_actual_G);
            idx_B = find(resultados_B(1, :) == nivel_gris_actual_B);
             if ~isempty(idx_R)
                nivel_gris_correspondiente_R = resultados_R(2, idx_R);
                imagenModificada(i, j, 1) = nivel_gris_correspondiente_R;
            end
        
            if ~isempty(idx_G)
                nivel_gris_correspondiente_G = resultados_G(2, idx_G);
                imagenModificada(i, j, 2) = nivel_gris_correspondiente_G;
            end
            
            if ~isempty(idx_B)
                nivel_gris_correspondiente_B = resultados_B(2, idx_B);
                imagenModificada(i, j, 3) = nivel_gris_correspondiente_B;
            end
        end
    end

    mostrarImagenes(imgA, imgB, imagenModificada);

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


function mostrarImagenes(imgA, imgB, imgMod)
    figure(1);
    subplot(3,4,1);
    imshow(imgA);
    title('Imagen original A');
    subplot(3,4,2);
    imhist(imgA(:,:,1));
    title('Histograma Rojo A');
    subplot(3,4,3);
    imhist(imgA(:,:,2));
    title('Histograma Verde A');
    subplot(3,4,4);
    imhist(imgA(:,:,3));
    title('Histograma Azul A');
    
    subplot(3,4,5);
    imshow(imgB);
    title('Imagen original B');
    subplot(3,4,6);
    imhist(imgB(:,:,1));
    title('Histograma Rojo B');
    subplot(3,4,7);
    imhist(imgB(:,:,2));
    title('Histograma Verde B');
    subplot(3,4,8);
    imhist(imgB(:,:,3));
    title('Histograma Azul B');
    
    subplot(3,4,9);
    imshow(imgMod);
    title('Imagen resultante');
    subplot(3,4,10);
    imhist(imgMod(:,:,1));
    title('Histograma Rojo Resultante');
    subplot(3,4,11);
    imhist(imgMod(:,:,2));
    title('Histograma Verde Resultante');
    subplot(3,4,12);
    imhist(imgMod(:,:,3));
    title('Histograma Azul Resultante');
end
