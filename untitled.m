probablities=imread("cameraman.tif");
%phases(probablities);
valores=calcular_valores(probablities);
            sorted_probabilities=sort(valores.probabilidades(),size(valores.probabilidades(),2),"descend");
            sorted_probabilities=flip(sort(sorted_probabilities));
            %dictionary=phases(sorted_probabilities);
            %dictionary=filtrarDiccionario(dictionary);
            %printDictionary(dictionary);
            [codes, lengths] = huffmanCoding(valores.intensidades,valores.probabilidades);
 subplot(1,3,1);
    imshow(probablities);
    title('Cuadro original');
    
    % Calcular la Transformada Discreta de Coseno del cuadro y mostrarla en el segundo subplot
    
    
    subplot(1,3,3);
    bar(valores.intensidades,valores.cantidades);
    % Título y etiquetas de los ejes
    title('Histograma del Canal');
    xlabel('Valores');
    ylabel('Frecuencia');
function dictionary_codes=phases(probabilities)
disp(string(probabilities));
phases = probabilities;
    aux = 0;
    values_stack = CStack();
    dictionary = containers.Map();
    
    for i = 1:(length(probabilities) - 2)
        %disp("etapa" + i);
         
        %disp(phases);
         
        values_stack.push(phases);
        aux = phases(length(phases)) + phases(length(phases) - 1);
        %disp(aux);
        phases = phases(1:length(phases) - 1);
        phases(length(phases)) = phases(length(phases) - 1);
        phases(length(phases) - 1) = aux;
        phases=flip(sort(phases));
    end
    
    values_stack.push(phases);
    aux_matrix = [];
    past_matrix = [];
    str_base="";
    
    
    for i = 1:(length(probabilities) - 1)
        
        
        if (i>1)
           str_base=str_base+"1";
        end

        aux_matrix = values_stack.pop();
        values = string(eliminarDatos(aux_matrix, past_matrix));
        
        %disp(values);
        %disp(str_base + '1');
        %disp(aux_matrix);
        %disp(past_matrix);
        %disp("\n\n\n")
        if(length(values)>1)
        if (values(1) > values(2))
            if(~isKey(dictionary,values(1)))
            dictionary(num2str(values(1))) = strcat(str_base, '0');
            end
            if(~isKey(dictionary,values(2)))
            dictionary(num2str(values(2))) = strcat(str_base, '1');

            end
        end

        end
        
        past_matrix = aux_matrix;
    end
    %printDictionary(dictionary);
    disp("etapa" + (i + 1));
    disp(phases);
    aux = phases(length(phases)) + phases(length(phases) - 1);
    disp(aux);
    dictionary_codes=dictionary;
end
function nuevoDiccionario = filtrarDiccionario(diccionario)
    nuevoDiccionario = containers.Map(); % Crear un nuevo diccionario vacío
    
    % Iterar a través de todas las llaves del diccionario original
    keys = diccionario.keys;
    
    for i = 1:numel(keys)
        key = keys{i};
        value = diccionario(key);


            
        % Verificar si el valor termina en '0'
        if endsWith(value, '0')

            nuevoDiccionario(key) = value; % Agregar la llave y el valor al nuevo diccionario
        end
    end
    printDictionary(nuevoDiccionario);
end


function printDictionary(dictionary, filename)
    keys = dictionary.keys;
    filename="prueba.txt";
    values = dictionary.values;
    
    fid = fopen(filename, 'w'); % Abrir el archivo en modo de escritura
    
    for i = 1:length(keys)
        fprintf(fid, 'Clave: %s\n', keys{i});
        fprintf(fid, 'Valor:\n');
        fprintf(fid, '%s\n', values{i});
        fprintf(fid, '------------------------------\n');
    end
    
    fclose(fid); % Cerrar el archivo
end


function conjuntoRestado = eliminarDatos(matriz, datosAEliminar)
    % Eliminar los datos de la matriz original
    conjuntoRestado = matriz;
    for i = 1:length(datosAEliminar)
        % Encontrar los índices del dato a eliminar
        indiceAEliminar = find(conjuntoRestado == datosAEliminar(i), 1);
        
        % Eliminar el primer dato de los datos a eliminar de la matriz original
        if ~isempty(indiceAEliminar)
            conjuntoRestado(indiceAEliminar) = [];
        end
    end
end

function valores = calcular_valores(canal)
    
    intensidades = unique(canal);
    
    for i=1:length(intensidades)
        
        cantidades(i)=max(cumsum(sum(canal==intensidades(i))));
    end

    %cantidades = histcounts(canal, length(intensidades));
    probabilidades = cantidades / numel(canal);
    prob_acumulada = cumsum(probabilidades);
    valores.intensidades = intensidades;
    valores.cantidades = cantidades;
    valores.probabilidades = probabilidades;
    valores.prob_acumulada = prob_acumulada;
end





function [codes, lengths] = huffmanCoding(symbols, frequencies)

% Initialize the priority queue.
pq = flip(sort(frequencies));

% While there are more than one node in the priority queue...
while numel(pq) > 1
pq = flip(sort(pq));
% Remove the two nodes with the smallest frequencies.
node1 = extract(pq,length(pq));
node2 = extract(pq,length(pq));

% Create a new node with the sum of the frequencies of the two removed nodes.
newNode = node1 + node2;

% Add the new node to the priority queue.
enqueue(pq, newNode);

end

% The root node of the Huffman tree is the only node left in the priority queue.
root = pq.front;

% Create a map from symbols to codes.
codes = containers.Map();

% Recursively build the code for each symbol.
buildCode(root, codes, '');

% Calculate the lengths of the codes.
lengths = zeros(size(symbols));
for i = 1:numel(symbols)
  lengths(i) = numel(codes(symbols(i)));
end

end

function buildCode(node, codes, code)

% If the node is a leaf node, add the symbol to the map.
if isleaf(node)
  codes(node.symbol) = code;

% Otherwise, recursively build the codes for the left and right subtrees.
else
  buildCode(node.left, codes, code + '0');
  buildCode(node.right, codes, code + '1');

end
end