matriz = [1 1 0 0; 1 1 0 0; 0 0 1 0; 0 0 0 1];
num_islands = contar_islas(matriz);
disp(['Número de islas de 1''s en la matriz: ', num2str(num_islands)]);
function num_islands = contar_islas(matriz)
    [filas, columnas] = size(matriz);
    num_islands = 0;

    for i = 1:filas
        for j = 1:columnas
            if matriz(i, j) == 1
                num_islands = num_islands + 1;
                matriz = dfs(matriz, i, j);
            end
        end
    end
end

function matriz = dfs(matriz, i, j)
    [filas, columnas] = size(matriz);
    
    if i < 1 || i > filas || j < 1 || j > columnas || matriz(i, j) == 0
        return;
    end
    
    matriz(i, j) = 0;
    
    % Revisar los vecinos
    matriz = dfs(matriz, i-1, j);
    matriz = dfs(matriz, i+1, j);
    matriz = dfs(matriz, i, j-1);
    matriz = dfs(matriz, i, j+1);
end

