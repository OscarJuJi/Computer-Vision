clc;
close all;
clear global;
warning off all;

%Cuantificador suger10ido para JPEG
Q = [16, 11, 10, 16, 24, 40, 51, 61;
    12, 12, 14, 19, 26, 58, 60, 55;
    14, 13, 16, 24, 40, 57, 69, 56;
    14, 17, 22, 29, 51, 87, 80, 62;
    18, 22, 37, 56, 68, 109, 103, 77;
    24, 35, 55, 64, 81, 104, 113, 92;
    49, 64, 78, 87, 103, 121, 120, 101;
    72, 92, 95, 98, 112, 100, 103, 99];

matrizAc= [3 4 6 8 10 12 14 18 25 26;
                    5 8 10 13 16 22 23 24 25 26;
                    6 10 13 20 21 22 23 24 25 26;
                    7 11 14 20 21 22 23 24 25 26;
                    7 12 19 20 21 22 23 24 25 26;
                    8 12 19 20 21 22 23 24 25 26;
                    8 13 19 20 21 22 23 24 25 26;
                    9 13 19 20 21 22 23 24 25 26;
                    9 17 19 20 21 22 23 24 25 26;
                   10 18 19 20 21 22 23 24 25 26;
                   10 18 19 20 21 22 23 24 25 26];
%input_img = imread('peppers.png');
ac_huff_table = {{'00', '01', '100', '1011', '11010', '111000', '1111000', '1111110110', '1111111110000010', '1111111110000011'}, ...
{'1100', '111001', '1111001', '111110110', '11111110110', '1111111110000100', '1111111110000101','1111111110000110', '1111111110000111','1111111110001000'},...
{'11011','11111000','1111110111','1111110111', '1111111110001001','1111111110001010','111111111001011','1111111110001100','1111111110001101','1111111110001110','1111111110001111'}...
{'111010','111110111','11111110111','1111111110010000','1111111110010001','1111111110010010','1111111110010011','1111111110010100','1111111110010101','111111111001110'}...
{'111011','1111111000','1111111110010111','1111111110011000','11111111100111001','1111111110011010','1111111110011011','1111111110011100','1111111110011101','111111111001110'}...
{'1111010','1111111001','1111111110011111','1111111110100000','1111111110100001','1111111110100010','1111111110100011','1111111110100100','1111111110100101','1111111110100110'}...
{'1111011','11111111000','1111111110100111','1111111110101000','1111111110101001','1111111110101010','1111111110101011','1111111110101100','1111111110101101','1111111110101110'}...
{'11111001','11111111001','1111111110101111','1111111110110000','1111111110110001','1111111110110010','1111111110110011','1111111110110100','1111111110110101','1111111110110110'}...
{'11111010','111111111000000','1111111110110111','1111111110111000','1111111110111001','1111111110111010','1111111110111011','1111111110111100','1111111110111101','1111111110111110'}...
{'111111000','1111111110111111','1111111111000000','1111111111000001','1111111111000010','1111111111000011','1111111111000100','1111111111000101','1111111111000110','1111111111000111'}...
{'111111001','1111111111001000','1111111111001001','1111111111001010','1111111111001011','1111111111001100','1111111111001101','1111111111001110','1111111111001111','1111111111010000'}};


category = [0 1 2 3 4 5 6 7 8 9 10 11];
length = [3 4 5 5 7 8 10 12 14 16 18 20];

matrizDc = [category' length'];

dc_huff_table = {'00', '010', '011', '100', '101', '110', '1110', '11110', '111110', '1111110', '11111110', '111111110'};

%% Codigo par arecorrido en zigzag y declaraciones iniciales
%Leer la imagen
imagen = imread('cameraman.tif');
imagen_redimensionada = imresize(imagen, [256 256]);
%imagen = rgb2gray(imagen_redimensionada);

% Obtener el tamaño de la imagen
[filas, columnas] = size(imagen);

% Definir el tamaño de los bloques
tamano_bloque = 8;

% Dividir la imagen en bloques de tamano_bloque x tamano_bloque
bloques = mat2cell(imagen, ones(1, filas/tamano_bloque)*tamano_bloque, ones(1, columnas/tamano_bloque)*tamano_bloque);

%input_img=uint8([52,55,61,66,70,61,64,73;63,59,66,90,109,85,69,72;62,59,68,113,144,104,66,73;63,58,71,122,154,106,70,69;67,61,68,104,126,88,68,70;79,65,60,70,77,68,58,75;85,71,64,59,55,61,65,83;87,79,69,68,65,76,78,94]);
for i = 1:32
    for j = 2:32
        bloques{i,j}(1,1) = bloques{i,j}(1,1) - bloques{i,j-1}(1,1);
    end
    if i+1 <= 32
        bloques{i+1,1}(1,1) = bloques{i+1,1}(1,1) - bloques{i,end}(1,1);
    end
end


while true
    resultado = cell(2, 40);
   
    % Pedir al usuario que ingrese valores para i y j
    input_str = input('Ingrese valores para el bloque (x y)(dejar en blanco para salir): ', 's');

    % Salir del bucle si no se ingresa nada
    if isempty(input_str)
        break;
    end

    % Convertir la entrada del usuario en números y asignarlos a i y j
    vals = str2num(input_str);

    i_bloque = vals(1); % fila del bloque
    j_bloque = vals(2); % columna del bloque
    
    cuadro = bloques{i_bloque,j_bloque};

    ziza = JPEG_ENCO(cuadro,Q);    
    code = forDc(ziza(1), matrizDc, dc_huff_table);
    resultado{1,1} = ziza(1);
    resultado{1,2} = code;

    run = 1;
    x=2;
    for i = 2:64
        if ziza(i) ~= 0
            category = getCategoryAc(ziza(i));
             %disp(category);
    %          disp(run);
    %         disp(ac_huff_table{run}{category})
    %          disp(matrizAc(run, category));
            code = complementoCodeBaseAc(ziza(i), ac_huff_table{run}{category}, matrizAc(run, category));
            run = 1;
            resultado{x,1} = ziza(i);
            resultado{x,2} = code;
            x = x+1;
        else 
            run = run +1;
        end
    end
    resultado{x,1} = 'EOB';
    resultado{x,2} = '1010';
    
    tam = size(resultado, 1) - 1;
    for i = 1: tam
        fprintf('Numero: %d, Codigo: %s\n', resultado{i,1}, resultado{i,2});
    end
    fprintf('%s, Codigo: %s\n', resultado{tam+1,1}, resultado{tam+1,2});

    
end


%% Obtener Codigos para Dc
function codeDc = forDc(value, matrizDc, dc_huff_table)
    codeDc = getCodeDc(value, matrizDc, dc_huff_table);
%     disp(value);
%     disp(codeDc);
end

%% Funciones
function code = getCodeDc(numero, matrizRef, bin_table)    
    category =assign_dc_category(numero);

    code = complementoCodeBase(numero, bin_table(category + 1),  matrizRef(category+1, 2) );

end

function dc_category = assign_dc_category(dc_value)
    dc_category_table = {
        0   0;
        1   1;
        3   2;
        7   3;
        15   4;
        31  5;
        63  6;
        127  7;
        255 8;
        511 9;
        1023 10;
        2047  11;
        4095  12;
        8191  13;
        16383  14;
        32767 15;
    };
    
    % Calcular la magnitud del valor DC actual
    dc_magnitude = abs(dc_value);
    
    % Buscar el rango al que pertenece la magnitud del valor DC actual
    for i = 1:size(dc_category_table, 1)
        if dc_magnitude <= dc_category_table{i}(1)

            % Asignar la categoría DC correspondiente
            dc_category = dc_category_table(i, 2);
            dc_category = dc_category{1};
            break;
        end
    end
end

function ac_category = getCategoryAc(ac_value)
    ac_category_table = {
        0  'N/A';
        1       1;
        3       2;
        7       3;
        15      4;
        31      5;
        63      6;
        127     7;
        255     8;
        511     9;
        1023    10;
        2047    11;
        4095    12;
        8191    13;
        16383   14;
         32767 'N/A';
    };

    
    % Calcular la magnitud del valor DC actual
    ac_magnitude = abs(ac_value);
    
    % Buscar el rango al que pertenece la magnitud del valor DC actual
    for i = 1:size(ac_category_table, 1)
        if ac_magnitude <= ac_category_table{i}(1)

            % Asignar la categoría DC correspondiente
            ac_category = ac_category_table(i, 2);
            ac_category = ac_category{1};
            break;
        end
    end
end

function codigo = complementoCodeBase(num_decimal, codeBase, lengthCode)
    num_binario = pasarBinario(num_decimal);
    %disp(num_binario);
    codeBase= codeBase{1};
    
    % Obtener la longitud actual del código base
    current_length = length(codeBase);
%     disp(current_length);
%     disp(codeBase);
%     disp(lengthCode);
    % Verificar si se necesita agregar ceros a la izquierda
    if current_length < lengthCode
        fullCode = strcat(codeBase, num_binario);
        codigo = fullCode(1:lengthCode);
    else
        codigo = codeBase;
    end
end

function codigo = complementoCodeBaseAc(num_decimal, codeBase, lengthCode)
    num_binario = pasarBinario(num_decimal);
    %disp(num_binario);
    
    % Obtener la longitud actual del código base
    current_length = length(codeBase);
%     disp(current_length);
%     disp(codeBase);
%     disp(lengthCode);
    % Verificar si se necesita agregar ceros a la izquierda
    if current_length < lengthCode
        fullCode = strcat(codeBase, num_binario);
        codigo = fullCode(1:lengthCode);
    else
        codigo = codeBase;
    end
end

function num_binario = pasarBinario(num_decimal)    
    % Comprobar si el número es positivo o negativo
    if num_decimal >= 0
        % Convertir el número decimal a binario
        num_binario = dec2bin(num_decimal);
    else
        num_decimal = abs(num_decimal);
        num_binario = dec2bin(num_decimal);
        num_binario = strcat('0', num_binario);

        % reemplazar "1" con "x" y "0" con "1"
        temp = regexprep(num_binario, '1', 'x');
        temp = regexprep(temp, '0', '1');
        
        % reemplazar "x" con "0"
        binario_inverso = regexprep(temp, 'x', '0');

        % Convertir a decimal y sumar 1
        num_decimalaux = bin2dec(binario_inverso);
        num_decimalaux = num_decimalaux + 1;
        
        % Convertir de nuevo a binario
        num_binario = dec2bin(num_decimalaux);      
        num_binario = num_binario(2:end);
    end
end


function out = zigzag(input_img)
    t=0;
    l=size(input_img);
    sum=l(2)*l(1);
    for d=2:sum
     c=rem(d,2);
        for i=1:l(1)
            for j=1:l(2)
                if((i+j)==d)
                    t=t+1;
                    if(c==0)
                    out(t)=input_img(j,d-j);
                    else          
                    out(t)=input_img(d-j,j);
                    end
                 end    
             end
         end
    end
end

function [ zb] = JPEG_ENCO(input_img, Q)
    [H,  W] = size(input_img);
    for i=1:8:H
        for j=1:8:W
            block = input_img(i:i+7,j:j+7);
            b = double(block)-128;
            bd = round(dct2(b));
            bq = round(bd./Q);
            zb = zigzag(bq);
        end
    end
    subplot(1,2,1);
    imshow(input_img);
    title('Cuadro original');
    
    % Calcular la Transformada Discreta de Coseno del cuadro y mostrarla en el segundo subplot
    disp(bq);
    subplot(1,2,2);
    imshow(bq);
    title('Cuadro en DCT');
end

