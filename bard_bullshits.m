% Supongamos que tienes un array de probabilidades ordenadas llamado "probabilidades"
probabilidades = [0.111111,0.222222 ,0.222222, 0.222222, 0.333333, 0.333333, 0.444444];

% Utilizar (la función ajustar_probabilidades para obtener el array reordenado
probabilidades_ajustadas = ajustar_probabilidades(probabilidades);

% Mostrar el array reordenado
disp('Array de probabilidades reordenado:');
disp(string(probabilidades_ajustadas));
[numeros_repetidos, cantidades] = encontrar_numeros_repetidos(probabilidades);

function probabilidades_ajustadas = ajustar_probabilidades(probabilidades)
    probabilidades_ajustadas = probabilidades;
    n = length(probabilidades);
    
    repetidos = find(diff(probabilidades_ajustadas) == 0);  % Índices de elementos repetidos
    
    while ~isempty(repetidos)
        for i = 1:length(repetidos)
            index = repetidos(i) + 1;
            probabilidades_ajustadas(index) = probabilidades_ajustadas(index) + i * 0.000001;
        end
        repetidos = find(diff(probabilidades_ajustadas) == 0);
    end
    
    probabilidades_ajustadas = sort(probabilidades_ajustadas);
end
function [numeros_repetidos, cantidades] = encontrar_numeros_repetidos(array)
    [valores_unicos, ~, idx] = unique(array);
    conteo = histcounts(idx, 1:length(valores_unicos)+1);
    
    numeros_repetidos = valores_unicos(conteo > 1);
    cantidades = conteo(conteo > 1);
end


