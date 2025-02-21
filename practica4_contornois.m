clear all all
close all
warning all
% Crear una imagen binaria de ejemplo
imagen = imread("image_Dataset/imagen28.png");
imagen = rgb2gray(imagen);
imagen = im2bw(imagen);

% Elementos estructurantes predefinidos 
    elemento_1 = ones(3, 3);
    elemento_2 = crearElementoEstructurante(3);
    elemento_3 = crear_elemento_diamante(3);
    elemento_4 = [0 1 0; 1 1 1; 0 1 0];
    
    % Pedir al usuario que elija un elemento estructurante
    disp('Elige un elemento estructurante:');
    disp('1. Cuadrado 3x3');
    disp('2. Disco de radio 3');
    disp('3. Diamante');
    disp('4. Cruz');
    
    opcion = input('Ingresa el número de la opción elegida: ');
    
    % Seleccionar el elemento estructurante correspondiente
    switch opcion
        case 1
            elementoEstructurante = elemento_1;
            se = strel('cube',3);
        case 2
            elementoEstructurante = elemento_2;
            se = strel('disk',3);
        case 3
            elementoEstructurante = elemento_3;
            se = strel('diamond',3);
        case 4
            elementoEstructurante = elemento_4;
            se = strel('disk',1);
        otherwise
            error('Opción no válida.');
    end

% Aplicar la operación de erosión
resultado = erosion(imagen, elementoEstructurante);

% Calcular el complemento
complemento = imcomplement(resultado);

% Realizar la operación lógica AND
resultado_and_complemento = bitand(imagen, complemento);

% Mostrar o utilizar el resultado según sea necesario
figure;
subplot(1, 4, 1), imshow(imagen), title('Imagen Original');
subplot(1, 4, 2), imshow(resultado), title('Resultado (Erosión)');
subplot(1, 4, 3), imshow(complemento), title('Complemento');
subplot(1, 4, 4), imshow(resultado_and_complemento), title('AND entre Original y Complemento');

function imagen_erodida = erosion(imagen_binaria, elemento_estructurante)
    % Obtener dimensiones de la imagen y del elemento estructurante
    [filas, columnas] = size(imagen_binaria);
    [filas_kernel, columnas_kernel] = size(elemento_estructurante);
    
    % Inicializar la imagen resultante
    imagen_erodida = zeros(filas, columnas);
    
    % Realizar la erosión
    for i = 1:filas
        for j = 1:columnas
            % Verificar si el elemento estructurante se superpone completamente
            if i <= filas - filas_kernel + 1 && j <= columnas - columnas_kernel + 1
                % Obtener la región correspondiente al elemento estructurante
                vecindario = imagen_binaria(i:i+filas_kernel-1, j:j+columnas_kernel-1);
                
                % Aplicar la operación de erosión (mínimo)
                resultado = min(vecindario(:));
                
                % Asignar el resultado a la imagen erodida
                imagen_erodida(i, j) = resultado;
            end
        end
    end
end

function elementoEstructurante = crearElementoEstructurante(radio)
    % Asegurarse de que el radio sea un número entero
    radio = floor(radio);
    
    % Calcular el tamaño del elemento estructurante
    tamano = 2 * radio + 1;
    
    % Inicializar el elemento estructurante con ceros
    elementoEstructurante = zeros(tamano);
    
    % Calcular el centro del elemento estructurante
    centro = radio + 1;
    
    % Iterar sobre el elemento estructurante y asignar 1 a los píxeles dentro del círculo
    for i = 1:tamano
        for j = 1:tamano
            % Calcular las coordenadas polares
            distanciaAlCentro = sqrt((i - centro)^2 + (j - centro)^2);
            
            % Verificar si las coordenadas están dentro del círculo
            if distanciaAlCentro <= radio
                elementoEstructurante(i, j) = 1;
            end
        end
    end
end
function elemento_diamante = crear_elemento_diamante(tamano)
    % Crea un elemento estructurante en forma de diamante
    % con un tamaño especificado.
    % El tamaño debe ser un número entero impar.

    if mod(tamano, 2) == 0
        error('El tamaño del diamante debe ser un número impar.');
    end

    % Calcula el radio del diamante
    radio = (tamano - 1) / 2;

    % Crea una cuadrícula con el centro en el medio
    [X, Y] = meshgrid(1:tamano, 1:tamano);
    centro = (tamano + 1) / 2;

    % Define el elemento como 1 dentro del diamante y 0 fuera
    elemento_diamante = double(abs(X - centro) + abs(Y - centro) <= radio);
end
