clc
clear all all
close all
warning off all
% Cargar la imagen
imagen = imread("peppers.png"); % Reemplaza 'tu_imagen.jpg' con la ruta de tu imagen
n_clases=input("Ingrese cuantas clases desea\n");
%n_clases=3;
num_puntos=input("Ingrese cuantos puntos desea\n");

%num_puntos=100;
% Puedes almacenar múltiples clases en un cell array si lo deseas
% Inicializar las variables para almacenar las clases y sus coordenadas
clases =  cell(1, n_clases);
coordenadas = zeros(n_clases,num_puntos,2);
rgb_valores = zeros(n_clases, num_puntos, 3);
centroid=[];
for i = 1:n_clases
    imshow(imagen);
    title('Selecciona un punto en la imagen');
    % Pedir al usuario que seleccione un punto
    [x, y] = ginput(1);
    centroid(i,:)=[x,y];
    nombre_clase = input('Por favor, ingresa un nombre para la clase: ', 's');
    clases{i} = nombre_clase;
end

for i = 1:n_clases
        % Mostrar la imagen
    [vecindad_x, vecindad_y, rgb_vals] = definir_clase(imagen,num_puntos,centroid(i,1),centroid(i,2));
    
    coordenadas(i,:,1) = vecindad_x(:);
    coordenadas(i,:,2) = vecindad_y(:);
    rgb_valores(i,:,:) = rgb_vals;
end

method_per=input("Seleecione el metodo por el que desea evaluar\n D euclidiana\n D mahalanobis \n Prob\n");
for iteraciones_aleatorias=1:3
    method=method_per;
clasification_methods=iteraciones_aleatorias;
la_i=0;

    switch(clasification_methods)
        case 1
            la_i=num_puntos;
        case 2
            la_i=(num_puntos/2);
        case 3
            la_i=round(num_puntos*.9);
    end
% Pedir al usuario que defina las clases

if(iteraciones_aleatorias==1)
for p = 1:n_clases
    figure(1);
    hold on;
    plot(x, y, 'ro', 'MarkerSize', 10); % Punto central en rojo
    plot(coordenadas(p,:,1), coordenadas(p,:,2), 'b.'); % Puntos de la vecindad en azul
    text(coordenadas(p, i, 1) + 10, coordenadas(p, i, 2) + 10, clases{p}, 'Color', 'r', 'FontSize', 12); % Etiqueta de clase en rojo
end
end
matrix_eu=[];
matrix_ma=[];
matrix_prob=[];

for comparison=1:2
switch(method)
    case 1
        matrix_eu=euclidian_evaluation(rgb_valores,n_clases,num_puntos,la_i);
        %print_confusion_matrix(clases,n_clases,matrix_eu)
    case 2
        %disp(n_clases);
        %disp(num_puntos);
        %disp(la_i);
        %disp(size(rgb_valores,1))
        %disp(size(rgb_valores,2))
        %disp(size(rgb_valores,3))
        matrix_ma=mahala_evaluation(rgb_valores,n_clases,num_puntos,la_i);
        %print_confusion_matrix(clases,n_clases,matrix_ma)
    case 3
        matrix_prob=maximum_probabilty_criteria(rgb_valores,n_clases,num_puntos,la_i);
        %print_confusion_matrix(clases,n_clases,matrix_prob)
end
method=2;
end
%disp(matrix_eu)
%disp(matrix_ma)
%disp(matrix_prob)
print_confusion_matrix(clases,n_clases,num_puntos,matrix_eu,matrix_ma,matrix_prob);
%clases = {clase}; % Inicialmente, solo tenemos una clase
end

function [vecindad_x,vecindad_y,rgb_valores] = definir_clase(imagen,num_puntos,x,y)
    % Generar una vecindad de 100 puntos alrededor del punto seleccionado
    
    vecindad_x = x + randn(1, num_puntos) * 10; % Desplazamiento aleatorio en x
    vecindad_y = y + randn(1, num_puntos) * 10; % Desplazamiento aleatorio en y
    
    % Obtener los valores RGB de la vecindad de cada punto
    rgb_valores = zeros(num_puntos, 3);
    for i = 1:num_puntos
        rgb_valores(i, :) = imagen(round(vecindad_y(i)), round(vecindad_x(i)), :);
        
    end
end

function contadores=euclidian_evaluation(rgb,num_clases,num_puntos,la_i)

        for l=1:num_clases
            for k=1:la_i
                class(l,k,:)=rgb(l,k,:);
            end
        end
        for l=1:num_clases
            
                meanings(l,1)=mean(class(l,1:la_i,1));
                meanings(l,2)=mean(class(l,1:la_i,2));
                meanings(l,3)=mean(class(l,1:la_i,3));
        end
        inicio=1;
        final=num_puntos;
        if la_i~=num_puntos
            if la_i==num_puntos*.5
                inicio=la_i;
            elseif la_i==num_puntos*.9
                inicio=la_i;
            end
            
        end
        %disp(inicio)
        %disp(final)
       for o=1:num_clases
            for l=1:num_clases
                x_position=1;
                for p=inicio:final 
                    evaluacion=sqrt(sum((meanings(o,:) - [rgb(l,p,1),rgb(l,p,2),rgb(l,p,3)]) .^ 2));
                    distannce(o,l,x_position)=evaluacion;
                    x_position=x_position+1;
                end
                %disp(distannce(o,l,:))
            end 
            
       end
       %disp(distannce);
       contadores=class_matrix(num_clases,num_puntos,distannce,1);
end

function contadores=mahala_evaluation(rgb,num_clases,num_puntos,la_i)
    
    class_input = num_clases;
    representants_input = la_i;
    %disp(num_puntos)
    %disp("hola")
    %disp(la_i)
    
    for class_idx = 1:class_input
        for rep_idx = 1:la_i
            representants(class_idx,rep_idx,:)=rgb(class_idx,rep_idx,:);
        end
    end
    
    mahalanobis_distances = zeros(class_input, 1);
    for class = 1:class_input
            for rep_idx = 1:representants_input
            representants_idx(rep_idx,:)=[representants(class,rep_idx,:)];
            end
        inicio=1;
        final=num_puntos;
        if la_i~=num_puntos
            if la_i==num_puntos*.5
                inicio=la_i;
            elseif la_i==num_puntos*.9
                inicio=la_i;
            end
            
        end
%disp(inicio)
    for class_idx = 1:class_input
        x_position=1;
        
        %disp(class_idx)
        for l=inicio:num_puntos
            %disp(l)
            selected_pixel=[rgb(class_idx,l,1),rgb(class_idx,l,2),rgb(class_idx,l,3)];
            % Calcular la distancia de Mahalanobis para la clase actual
            mahalanobis_distance = 0;
            
            fun_d(class,class_idx,x_position)=sqrt(mahal(selected_pixel,representants_idx))
            if(isnan(fun_d(class,class_idx,x_position)))
                fun_d(class,class_idx,x_position)=0;
            end
            x_position=x_position+1;
            representant_mean=mean(representants_idx);
            % Calcular la distancia de Mahalanobis para el píxel seleccionado
            diff = selected_pixel - representant_mean;
            %disp(representants_idx)
            cov_matrix_class=cov(representants_idx);
            %cov_matrix_class=(representants_idx-representant_mean);
            %cov_matrix_class=(cov_matrix_class*cov_matrix_class')/representants_input;
        
            
            inv_cov_matrix = inv(cov_matrix_class);
            
            
            if(inv_cov_matrix==inf)
                mahalanobis_distances(class_idx) = -inf;
            else 
                %disp(cov_matrix_class)
                %disp(inv_cov_matrix)
                mahalanobis_distance = (diff * inv_cov_matrix*diff');
            
                % Almacenar la distancia de Mahalanobis para la clase actual
                mahalanobis_distances(class_idx) = mahalanobis_distance;
                
            end
            
        end
        
        % Determinar a qué clase pertenece el píxel seleccionado
        [~, class_index] = min(fun_d);
        
        %disp(mahalanobis_distances)
        %disp(fun_d)
            %disp(fun_d)
        
        %if(min(mahalanobis_distances)<1e+19)
         %   fprintf('El píxel seleccionado pertenece a la Clase %d.\n', class_index);
        %else
         %   disp('El punto no pertenece a ninguna de las clases.'); 
        %end
    end

    end
    %disp(fun_d)
    contadores=class_matrix(num_clases,num_puntos,fun_d,2);
end

function contadores=maximum_probabilty_criteria (rgb,num_clases,num_puntos,la_i)


    for l=1:num_clases
        for k=1:la_i
            class(l,k,:)=rgb(l,k,:);
        end
    end
    
    
    
   for o=1:num_clases
        
        for rep_idx = 1:la_i
            class_idx(rep_idx,:)=[class(o,rep_idx,:)];
        end

        inicio=1;
        final=num_puntos;
        if la_i~=num_puntos
            if la_i==num_puntos*.5
                inicio=la_i;
            elseif la_i==num_puntos*.9
                inicio=la_i;
            end
            
        end

        media_clase = mean(class_idx);
        covarianza_clase = cov(class_idx);
        for l=1:num_clases
            x_position=1;
            for p=inicio:final
                pixel2class=[rgb(l,p,1),rgb(l,p,2),rgb(l,p,3)];
                % Calcular la probabilidad para cada clase utilizando la fórmula de densidad de probabilidad normal multivariante
                n = length(pixel2class);
                
                % Probabilidad para la Clase 1
                probabilyties(o,l,x_position) = 1 / ((2 * pi)^(n/2) * sqrt(det(covarianza_clase))) * exp(-0.5 * (pixel2class - media_clase) * inv(covarianza_clase) * (pixel2class - media_clase)');
                x_position=x_position+1;
            end
            %disp(distannce(o,l,:))
        end 
   end

contadores=class_matrix(num_clases,num_puntos,probabilyties,3);
end

function contadores=class_matrix(num_clases,num_puntos,distannce,mthd)
    contadores=zeros(num_clases, num_clases);
    num_puntos=size(distannce,3);
    if(mthd<3)
            for l=1:num_clases
                for p=1:num_puntos 
                    %disp(distannce(l,:,p))
                    a=find(distannce(l,:,p)==min(distannce(l,:,p)),1);
                    %disp(min(distannce(l,:,p)))
                    
                        contadores(l,a)=contadores(l,a)+1;
                end
            end
            
    else 
        for l=1:num_clases
                for p=1:num_puntos 
                    %disp(distannce(l,:,p))
                    a=find(distannce(l,:,p)==max(distannce(l,:,p)),1);
                    %disp(min(distannce(l,:,p)))
                    
                        contadores(l,a)=contadores(l,a)+1;
                end
        end
    
    end
end
function print_confusion_matrix(nombres_clases,num_clases,puntos_a_evaluar,m1,m2,m3)
contadores=[];

if(size(m1,1)~=0)
    if(size(contadores,1)==0)
    contadores=m1;
    else
        contadores2=m1;
    end
end
if(size(m2,1)~=0)
    if(size(contadores,1)==0)
    contadores=m2;
    else
        contadores2=m2;
    end
end
if(size(m3,1)~=0)
    if(size(contadores,1)==0)
    contadores=m3;
    else
        contadores2=m3;
    end
end
% Imprimir la matriz de contadores con nombres de las clases
    fprintf('Matriz de Confusion:\n');
    fprintf('\t'); % Espacio para la esquina superior izquierda
    for i = 1:num_clases
        fprintf('%s\t', nombres_clases{i});
    end
    fprintf('\n');
    for i = 1:num_clases
        fprintf('%s\t', nombres_clases{i}); % Nombre de la clase en la fila
        for j = 1:num_clases
            fprintf('%d\t', contadores(i, j));
        end
        fprintf('\n');
    end
    porcentaje=trace(contadores)/(num_clases*puntos_a_evaluar)*100;
    
    disp("Evaluacion "+{porcentaje}+"%")
    
% Imprimir la matriz de contadores con nombres de las clases
    fprintf('Matriz 2 de confusion:\n');
    fprintf('\t'); % Espacio para la esquina superior izquierda
    for i = 1:num_clases
        fprintf('%s\t', nombres_clases{i});
    end
    fprintf('\n');
    for i = 1:num_clases
        fprintf('%s\t', nombres_clases{i}); % Nombre de la clase en la fila
        for j = 1:num_clases
            fprintf('%d\t', contadores2(i, j));
        end
        fprintf('\n');
    end
    %disp(puntos_a_evaluar)
    porcentaje=trace(contadores)/(num_clases*puntos_a_evaluar)*100;
    disp("Evaluacion "+{porcentaje}+"%")
              % Crear el gráfico de barras
    figure;
    subplot(2, 1, 1); % 2 filas, 1 columna, segundo sub-plot
    bar(1:num_clases, diag(contadores));
    xlabel('Clase');
    ylabel('Aciertos');
    title('Aciertos por Clase (Diagonal de la Matriz de Contadores)');
    
    subplot(2, 1, 2); % 2 filas, 1 columna, segundo sub-plot
    bar(1:num_clases, diag(contadores2));
    xlabel('Clase');
    ylabel('Aciertos');
    title('Aciertos por Clase (Diagonal de la Matriz de Contadores)');
end