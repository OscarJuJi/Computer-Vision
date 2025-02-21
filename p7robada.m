%{
    Los escritores del algodón
García Piña Wilberth David AKA Guayabanesca rispitosa
Gómez Tagle Espinosa José Ricardo AKA El Tocayo R1 Arjuan Erre Uno Erre Juan Galleta trapito
Palacios Elizondo Kevin Antonio AKA Yomonki Galleta Respetaaaaa El Kemonito El fetichista de patasxd
%}
close all
acliagain = 1;
while acliagain >= 1 && acliagain <=6 
    %seleccionar Imagen
    while acliagain == 1
        [IMAGE, PATH] = uigetfile({'*.jpg;*.JPG;*.bmp;*.tif;*.png'});
        imagen=imread(strcat(PATH, IMAGE));
        
        figure(1)
        imshow(imagen)
        
        disp(size(imagen))
        
        [alto, ancho, ~] = size(imagen);  % Modificado para manejar imágenes a color
        
        cantidadC = input("Ingrese la cantidad de clases: ");
        cantidadR = input("Ingrese la cantidad de representantes en la nube de puntos: ");
        close
        
        nombres = strings(1, cantidadC);
        representantes = zeros(cantidadC, 2);
        
        for indice = 1:cantidadC
            disp(strcat("Escoja indique donde esta la clase ", string(indice)))
            figure(2)
            imshow(imagen)
            temporal = round(ginput(1));
            representantes(indice, :) = temporal(1, 1:2);
            nombres(indice) = input("Ingrese el nombre de la clase: ", 's');
            close
        end
        
        acotacion = zeros(cantidadC, 4);
        
        offset = 30;
        
        for ii = 1:cantidadC
            temporal = [max(1, representantes(ii, 1) - offset), min(ancho, representantes(ii, 1) + offset)];
            temporal = [temporal, max(1, representantes(ii, 2) - offset), min(alto, representantes(ii, 2) + offset)];
            acotacion(ii, :) = temporal;
        end
        
        disp(acotacion)
        
        cx = cell(1, cantidadC);
        cy = cell(1, cantidadC);
        
        for ii = 1:cantidadC
            cx{ii} = randi([acotacion(ii, 1), acotacion(ii, 2)], 1, cantidadR);
            cy{ii} = randi([acotacion(ii, 3), acotacion(ii, 4)], 1, cantidadR);
        end
        
        clases = cell(1, cantidadC);
        
        for ii = 1:cantidadC
            clases{ii} = zeros(cantidadR, 3);
            for jj = 1:cantidadR
                clases{ii}(jj, :) = reshape(imagen(cy{ii}(jj), cx{ii}(jj), :), 1, 3);
            end
        end
        
        figure(3);
        
        imshow(imagen);
        
        hold on;
        
        for ii = 1:cantidadC
            scatter(cx{ii}, cy{ii}, 50, 'o', 'filled', 'DisplayName', nombres(ii));
        end
        
        legend('Location', 'Best');
        title('Imagen con Puntos de Representantes');
        
        hold off;
        
        k = input("Ingrese el número de vecinos cercanos: ");
        
        figure(4);
        imshow(imagen)
    
        disp("Elija el punto a clasificar")
        clasificar = round(ginput(1));
        punto_a_clasificar = double(reshape(imagen(clasificar(2), clasificar(1), :), 1, 3));
        
        puntos = [];
        coordenadas = [];
        distanciasEuclidianas = [];
        distanciasMahalanobis = [];
        
        for ii = 1:cantidadC
            for jj = 1:cantidadR
                punto_actual = clases{ii}(jj, :);
                puntos = [puntos; punto_actual];
                coordenadas = [coordenadas; cx{ii}(jj), cy{ii}(jj)];
                distanciasEuclidianas = [distanciasEuclidianas; norm(punto_a_clasificar - punto_actual)];
            end
        
            currentMah = mahalanobis_distance(punto_a_clasificar, clases{ii}(:, :));
            distanciasMahalanobis = [distanciasMahalanobis; currentMah];
        end
        
        [~, minIndiceEucl] = sort(distanciasEuclidianas);
        [~, minIndiceMaha] = sort(distanciasMahalanobis);
        
        mejoresCoordsEucl = coordenadas(minIndiceEucl(1:k), :);
        mejoresCoordsMaha = coordenadas(minIndiceMaha(1:k), :);
        
        % Euclidiana
        
        figure(5);
        
        imshow(imagen)
        
        hold on;
        
        scatter(clasificar(1), clasificar(2), 100, 'Marker', 'x', 'LineWidth', 2, 'DisplayName', "Punto a clasificar");
        scatter(mejoresCoordsEucl(:, 1), mejoresCoordsEucl(:, 2), 50, 'o', 'filled', 'DisplayName', "Puntos más cercanos");
        
        legend('Location', 'Best');
        title('Puntos más cercanos por Euclidiana');
        
        hold off;
        
        % Mahalanobis
        
        figure(6);
        
        imshow(imagen)
        
        hold on;
        
        scatter(clasificar(1), clasificar(2), 100, 'Marker', 'x', 'LineWidth', 2, 'DisplayName', "Punto a clasificar");
        scatter(mejoresCoordsMaha(:, 1), mejoresCoordsMaha(:, 2), 50, 'o', 'filled', 'DisplayName', "Puntos más cercanos");
        
        legend('Location', 'Best');
        title('Puntos más cercanos por Mahalanobis');
        
        hold off;
           
        
        acliagain = input("¿Reiniciar en: 1=todo, 2=rep/clase, 3=rep en nube, 4=elegir puntos, 5=ingresar knn, 6=elegir punto, otro=salir?: ");
    end

    %Aca empieza ingresar cantidad clases
    while acliagain == 2
        
        cantidadC = input("Ingrese la cantidad de clases: ");
        cantidadR = input("Ingrese la cantidad de representantes en la nube de puntos: ");
        close
        
        nombres = strings(1, cantidadC);
        representantes = zeros(cantidadC, 2);
        
        for indice = 1:cantidadC
            disp(strcat("Escoja indique donde esta la clase ", string(indice)))
            figure(2)
            imshow(imagen)
            temporal = round(ginput(1));
            representantes(indice, :) = temporal(1, 1:2);
            nombres(indice) = input("Ingrese el nombre de la clase: ", 's');
            close
        end
        
        acotacion = zeros(cantidadC, 4);
        
        offset = 30;
        
        for ii = 1:cantidadC
            temporal = [max(1, representantes(ii, 1) - offset), min(ancho, representantes(ii, 1) + offset)];
            temporal = [temporal, max(1, representantes(ii, 2) - offset), min(alto, representantes(ii, 2) + offset)];
            acotacion(ii, :) = temporal;
        end
        
        disp(acotacion)
        
        cx = cell(1, cantidadC);
        cy = cell(1, cantidadC);
        
        for ii = 1:cantidadC
            cx{ii} = randi([acotacion(ii, 1), acotacion(ii, 2)], 1, cantidadR);
            cy{ii} = randi([acotacion(ii, 3), acotacion(ii, 4)], 1, cantidadR);
        end
        
        clases = cell(1, cantidadC);
        
        for ii = 1:cantidadC
            clases{ii} = zeros(cantidadR, 3);
            for jj = 1:cantidadR
                clases{ii}(jj, :) = reshape(imagen(cy{ii}(jj), cx{ii}(jj), :), 1, 3);
            end
        end
        
        figure(3);
        
        imshow(imagen);
        
        hold on;
        
        for ii = 1:cantidadC
            scatter(cx{ii}, cy{ii}, 50, 'o', 'filled', 'DisplayName', nombres(ii));
        end
        
        legend('Location', 'Best');
        title('Imagen con Puntos de Representantes');
        
        hold off;
        
        k = input("Ingrese el número de vecinos cercanos: ");
        
        figure(4);
        imshow(imagen)
    
        disp("Elija el punto a clasificar")
        clasificar = round(ginput(1));
        punto_a_clasificar = double(reshape(imagen(clasificar(2), clasificar(1), :), 1, 3));
        
        puntos = [];
        coordenadas = [];
        distanciasEuclidianas = [];
        distanciasMahalanobis = [];
        
        for ii = 1:cantidadC
            for jj = 1:cantidadR
                punto_actual = clases{ii}(jj, :);
                puntos = [puntos; punto_actual];
                coordenadas = [coordenadas; cx{ii}(jj), cy{ii}(jj)];
                distanciasEuclidianas = [distanciasEuclidianas; norm(punto_a_clasificar - punto_actual)];
            end
        
            currentMah = mahalanobis_distance(punto_a_clasificar, clases{ii}(:, :));
            distanciasMahalanobis = [distanciasMahalanobis; currentMah];
        end
        
        [~, minIndiceEucl] = sort(distanciasEuclidianas);
        [~, minIndiceMaha] = sort(distanciasMahalanobis);
        
        mejoresCoordsEucl = coordenadas(minIndiceEucl(1:k), :);
        mejoresCoordsMaha = coordenadas(minIndiceMaha(1:k), :);
        
        % Euclidiana
        
        figure(5);
        
        imshow(imagen)
        
        hold on;
        
        scatter(clasificar(1), clasificar(2), 100, 'Marker', 'x', 'LineWidth', 2, 'DisplayName', "Punto a clasificar");
        scatter(mejoresCoordsEucl(:, 1), mejoresCoordsEucl(:, 2), 50, 'o', 'filled', 'DisplayName', "Puntos más cercanos");
        
        legend('Location', 'Best');
        title('Puntos más cercanos por Euclidiana');
        
        hold off;
        
        % Mahalanobis
        
        figure(6);
        
        imshow(imagen)
        
        hold on;
        
        scatter(clasificar(1), clasificar(2), 100, 'Marker', 'x', 'LineWidth', 2, 'DisplayName', "Punto a clasificar");
        scatter(mejoresCoordsMaha(:, 1), mejoresCoordsMaha(:, 2), 50, 'o', 'filled', 'DisplayName', "Puntos más cercanos");
        
        legend('Location', 'Best');
        title('Puntos más cercanos por Mahalanobis');
        
        hold off;
           
        
        acliagain = input("¿Reiniciar en: 1=todo, 2=rep/clase, 3=rep en nube, 4=elegir puntos, 5=ingresar knn, 6=elegir punto, otro=salir?: ");
    end
    %Aca termina Ingresar representantes en la nube de puntos
    while acliagain == 3
        cantidadR = input("Ingrese la cantidad de representantes en la nube de puntos: ");
        close
        
        nombres = strings(1, cantidadC);
        representantes = zeros(cantidadC, 2);
        
        for indice = 1:cantidadC
            disp(strcat("Escoja indique donde esta la clase ", string(indice)))
            figure(2)
            imshow(imagen)
            temporal = round(ginput(1));
            representantes(indice, :) = temporal(1, 1:2);
            nombres(indice) = input("Ingrese el nombre de la clase: ", 's');
            close
        end
        
        acotacion = zeros(cantidadC, 4);
        
        offset = 30;
        
        for ii = 1:cantidadC
            temporal = [max(1, representantes(ii, 1) - offset), min(ancho, representantes(ii, 1) + offset)];
            temporal = [temporal, max(1, representantes(ii, 2) - offset), min(alto, representantes(ii, 2) + offset)];
            acotacion(ii, :) = temporal;
        end
        
        disp(acotacion)
        
        cx = cell(1, cantidadC);
        cy = cell(1, cantidadC);
        
        for ii = 1:cantidadC
            cx{ii} = randi([acotacion(ii, 1), acotacion(ii, 2)], 1, cantidadR);
            cy{ii} = randi([acotacion(ii, 3), acotacion(ii, 4)], 1, cantidadR);
        end
        
        clases = cell(1, cantidadC);
        
        for ii = 1:cantidadC
            clases{ii} = zeros(cantidadR, 3);
            for jj = 1:cantidadR
                clases{ii}(jj, :) = reshape(imagen(cy{ii}(jj), cx{ii}(jj), :), 1, 3);
            end
        end
        
        figure(3);
        
        imshow(imagen);
        
        hold on;
        
        for ii = 1:cantidadC
            scatter(cx{ii}, cy{ii}, 50, 'o', 'filled', 'DisplayName', nombres(ii));
        end
        
        legend('Location', 'Best');
        title('Imagen con Puntos de Representantes');
        
        hold off;
        
        k = input("Ingrese el número de vecinos cercanos: ");
        
        figure(4);
        imshow(imagen)
    
        disp("Elija el punto a clasificar")
        clasificar = round(ginput(1));
        punto_a_clasificar = double(reshape(imagen(clasificar(2), clasificar(1), :), 1, 3));
        
        puntos = [];
        coordenadas = [];
        distanciasEuclidianas = [];
        distanciasMahalanobis = [];
        
        for ii = 1:cantidadC
            for jj = 1:cantidadR
                punto_actual = clases{ii}(jj, :);
                puntos = [puntos; punto_actual];
                coordenadas = [coordenadas; cx{ii}(jj), cy{ii}(jj)];
                distanciasEuclidianas = [distanciasEuclidianas; norm(punto_a_clasificar - punto_actual)];
            end
        
            currentMah = mahalanobis_distance(punto_a_clasificar, clases{ii}(:, :));
            distanciasMahalanobis = [distanciasMahalanobis; currentMah];
        end
        
        [~, minIndiceEucl] = sort(distanciasEuclidianas);
        [~, minIndiceMaha] = sort(distanciasMahalanobis);
        
        mejoresCoordsEucl = coordenadas(minIndiceEucl(1:k), :);
        mejoresCoordsMaha = coordenadas(minIndiceMaha(1:k), :);
        
        % Euclidiana
        
        figure(5);
        
        imshow(imagen)
        
        hold on;
        
        scatter(clasificar(1), clasificar(2), 100, 'Marker', 'x', 'LineWidth', 2, 'DisplayName', "Punto a clasificar");
        scatter(mejoresCoordsEucl(:, 1), mejoresCoordsEucl(:, 2), 50, 'o', 'filled', 'DisplayName', "Puntos más cercanos");
        
        legend('Location', 'Best');
        title('Puntos más cercanos por Euclidiana');
        
        hold off;
        
        % Mahalanobis
        
        figure(6);
        
        imshow(imagen)
        
        hold on;
        
        scatter(clasificar(1), clasificar(2), 100, 'Marker', 'x', 'LineWidth', 2, 'DisplayName', "Punto a clasificar");
        scatter(mejoresCoordsMaha(:, 1), mejoresCoordsMaha(:, 2), 50, 'o', 'filled', 'DisplayName', "Puntos más cercanos");
        
        legend('Location', 'Best');
        title('Puntos más cercanos por Mahalanobis');
        
        hold off;
           
        
        acliagain = input("¿Reiniciar en: 1=todo, 2=rep/clase, 3=rep en nube, 4=elegir puntos, 5=ingresar knn, 6=elegir punto, otro=salir?: ");
    end

    %Aca termina pedir representantes en la nube de puntos

    %Aca empieza pedir clases
    while acliagain == 4
        
        for indice = 1:cantidadC
            disp(strcat("Escoja indique donde esta la clase ", string(indice)))
            figure(2)
            imshow(imagen)
            temporal = round(ginput(1));
            representantes(indice, :) = temporal(1, 1:2);
            nombres(indice) = input("Ingrese el nombre de la clase: ", 's');
            close
        end
        
        acotacion = zeros(cantidadC, 4);
        
        offset = 30;
        
        for ii = 1:cantidadC
            temporal = [max(1, representantes(ii, 1) - offset), min(ancho, representantes(ii, 1) + offset)];
            temporal = [temporal, max(1, representantes(ii, 2) - offset), min(alto, representantes(ii, 2) + offset)];
            acotacion(ii, :) = temporal;
        end
        
        disp(acotacion)
        
        cx = cell(1, cantidadC);
        cy = cell(1, cantidadC);
        
        for ii = 1:cantidadC
            cx{ii} = randi([acotacion(ii, 1), acotacion(ii, 2)], 1, cantidadR);
            cy{ii} = randi([acotacion(ii, 3), acotacion(ii, 4)], 1, cantidadR);
        end
        
        clases = cell(1, cantidadC);
        
        for ii = 1:cantidadC
            clases{ii} = zeros(cantidadR, 3);
            for jj = 1:cantidadR
                clases{ii}(jj, :) = reshape(imagen(cy{ii}(jj), cx{ii}(jj), :), 1, 3);
            end
        end
        
        figure(3);
        
        imshow(imagen);
        
        hold on;
        
        for ii = 1:cantidadC
            scatter(cx{ii}, cy{ii}, 50, 'o', 'filled', 'DisplayName', nombres(ii));
        end
        
        legend('Location', 'Best');
        title('Imagen con Puntos de Representantes');
        
        hold off;
        
        k = input("Ingrese el número de vecinos cercanos: ");
        
        figure(4);
        imshow(imagen)
    
        disp("Elija el punto a clasificar")
        clasificar = round(ginput(1));
        punto_a_clasificar = double(reshape(imagen(clasificar(2), clasificar(1), :), 1, 3));
        
        puntos = [];
        coordenadas = [];
        distanciasEuclidianas = [];
        distanciasMahalanobis = [];
        
        for ii = 1:cantidadC
            for jj = 1:cantidadR
                punto_actual = clases{ii}(jj, :);
                puntos = [puntos; punto_actual];
                coordenadas = [coordenadas; cx{ii}(jj), cy{ii}(jj)];
                distanciasEuclidianas = [distanciasEuclidianas; norm(punto_a_clasificar - punto_actual)];
            end
        
            currentMah = mahalanobis_distance(punto_a_clasificar, clases{ii}(:, :));
            distanciasMahalanobis = [distanciasMahalanobis; currentMah];
        end
        
        [~, minIndiceEucl] = sort(distanciasEuclidianas);
        [~, minIndiceMaha] = sort(distanciasMahalanobis);
        
        mejoresCoordsEucl = coordenadas(minIndiceEucl(1:k), :);
        mejoresCoordsMaha = coordenadas(minIndiceMaha(1:k), :);
        
        % Euclidiana
        
        figure(5);
        
        imshow(imagen)
        
        hold on;
        
        scatter(clasificar(1), clasificar(2), 100, 'Marker', 'x', 'LineWidth', 2, 'DisplayName', "Punto a clasificar");
        scatter(mejoresCoordsEucl(:, 1), mejoresCoordsEucl(:, 2), 50, 'o', 'filled', 'DisplayName', "Puntos más cercanos");
        
        legend('Location', 'Best');
        title('Puntos más cercanos por Euclidiana');
        
        hold off;
        
        % Mahalanobis
        
        figure(6);
        
        imshow(imagen)
        
        hold on;
        
        scatter(clasificar(1), clasificar(2), 100, 'Marker', 'x', 'LineWidth', 2, 'DisplayName', "Punto a clasificar");
        scatter(mejoresCoordsMaha(:, 1), mejoresCoordsMaha(:, 2), 50, 'o', 'filled', 'DisplayName', "Puntos más cercanos");
        
        legend('Location', 'Best');
        title('Puntos más cercanos por Mahalanobis');
        
        hold off;
           
        
        acliagain = input("¿Reiniciar en: 1=todo, 2=rep/clase, 3=rep en nube, 4=elegir puntos, 5=ingresar knn, 6=elegir punto, otro=salir?: ");
    end
    %Aca termina pedir clases
    %Aca inicia pedir numero de vecinos cercanos
    while acliagain == 5
        k = input("Ingrese el número de vecinos cercanos: ");
        
        figure(4);
        imshow(imagen)
    
        disp("Elija el punto a clasificar")
        clasificar = round(ginput(1));
        punto_a_clasificar = double(reshape(imagen(clasificar(2), clasificar(1), :), 1, 3));
        
        puntos = [];
        coordenadas = [];
        distanciasEuclidianas = [];
        distanciasMahalanobis = [];
        
        for ii = 1:cantidadC
            for jj = 1:cantidadR
                punto_actual = clases{ii}(jj, :);
                puntos = [puntos; punto_actual];
                coordenadas = [coordenadas; cx{ii}(jj), cy{ii}(jj)];
                distanciasEuclidianas = [distanciasEuclidianas; norm(punto_a_clasificar - punto_actual)];
            end
        
            currentMah = mahalanobis_distance(punto_a_clasificar, clases{ii}(:, :));
            distanciasMahalanobis = [distanciasMahalanobis; currentMah];
        end
        
        [~, minIndiceEucl] = sort(distanciasEuclidianas);
        [~, minIndiceMaha] = sort(distanciasMahalanobis);
        
        mejoresCoordsEucl = coordenadas(minIndiceEucl(1:k), :);
        mejoresCoordsMaha = coordenadas(minIndiceMaha(1:k), :);
        
        % Euclidiana
        
        figure(5);
        
        imshow(imagen)
        
        hold on;
        
        scatter(clasificar(1), clasificar(2), 100, 'Marker', 'x', 'LineWidth', 2, 'DisplayName', "Punto a clasificar");
        scatter(mejoresCoordsEucl(:, 1), mejoresCoordsEucl(:, 2), 50, 'o', 'filled', 'DisplayName', "Puntos más cercanos");
        
        legend('Location', 'Best');
        title('Puntos más cercanos por Euclidiana');
        
        hold off;
        
        % Mahalanobis
        
        figure(6);
        
        imshow(imagen)
        
        hold on;
        
        scatter(clasificar(1), clasificar(2), 100, 'Marker', 'x', 'LineWidth', 2, 'DisplayName', "Punto a clasificar");
        scatter(mejoresCoordsMaha(:, 1), mejoresCoordsMaha(:, 2), 50, 'o', 'filled', 'DisplayName', "Puntos más cercanos");
        
        legend('Location', 'Best');
        title('Puntos más cercanos por Mahalanobis');
        
        hold off;
           
        
        acliagain = input("¿Reiniciar en: 1=todo, 2=rep/clase, 3=rep en nube, 4=elegir puntos, 5=ingresar knn, 6=elegir punto, otro=salir?: ");
    end
    %Aca termina pedir numero de vecinos cercanos

    %Aca inicia elegir punto a clasificar
    while acliagain == 6
        disp("Elija el punto a clasificar")
        clasificar = round(ginput(1));
        punto_a_clasificar = double(reshape(imagen(clasificar(2), clasificar(1), :), 1, 3));
        
        puntos = [];
        coordenadas = [];
        distanciasEuclidianas = [];
        distanciasMahalanobis = [];
        
        for ii = 1:cantidadC
            for jj = 1:cantidadR
                punto_actual = clases{ii}(jj, :);
                puntos = [puntos; punto_actual];
                coordenadas = [coordenadas; cx{ii}(jj), cy{ii}(jj)];
                distanciasEuclidianas = [distanciasEuclidianas; norm(punto_a_clasificar - punto_actual)];
            end
        
            currentMah = mahalanobis_distance(punto_a_clasificar, clases{ii}(:, :));
            distanciasMahalanobis = [distanciasMahalanobis; currentMah];
        end
        
        [~, minIndiceEucl] = sort(distanciasEuclidianas);
        [~, minIndiceMaha] = sort(distanciasMahalanobis);
        
        mejoresCoordsEucl = coordenadas(minIndiceEucl(1:k), :);
        mejoresCoordsMaha = coordenadas(minIndiceMaha(1:k), :);
        
        % Euclidiana
        
        figure(5);
        
        imshow(imagen)
        
        hold on;
        
        scatter(clasificar(1), clasificar(2), 100, 'Marker', 'x', 'LineWidth', 2, 'DisplayName', "Punto a clasificar");
        scatter(mejoresCoordsEucl(:, 1), mejoresCoordsEucl(:, 2), 50, 'o', 'filled', 'DisplayName', "Puntos más cercanos");
        
        legend('Location', 'Best');
        title('Puntos más cercanos por Euclidiana');
        
        hold off;
        
        % Mahalanobis
        
        figure(6);
        
        imshow(imagen)
        
        hold on;
        
        scatter(clasificar(1), clasificar(2), 100, 'Marker', 'x', 'LineWidth', 2, 'DisplayName', "Punto a clasificar");
        scatter(mejoresCoordsMaha(:, 1), mejoresCoordsMaha(:, 2), 50, 'o', 'filled', 'DisplayName', "Puntos más cercanos");
        
        legend('Location', 'Best');
        title('Puntos más cercanos por Mahalanobis');
        
        hold off;
           
        
        acliagain = input("¿Reiniciar en: 1=todo, 2=rep/clase, 3=rep en nube, 4=elegir puntos, 5=ingresar knn, 6=elegir punto, otro=salir?: ");
    end
    %Aca inicia elegir punto a clasificar
end


function distances = mahalanobis_distance(point, points)
    % point: 1xN vector representing the point
    % points: MxN matrix representing an array of points
    
    % Check dimensions
    [num_points, num_dimensions] = size(points);
    if length(point) ~= num_dimensions
        error('Point dimensions do not match the dimensions of the input points.');
    end
    
    % Calculate covariance matrix
    points = points + randi([-2, 2], num_points, num_dimensions);
    covariance_matrix = cov(points);
    
    % Calculate Mahalanobis distance
    differences = points - repmat(point, num_points, 1);
    inv_covariance_matrix = inv(covariance_matrix);
    distances = sqrt(sum((differences * inv_covariance_matrix) .* differences, 2));
end