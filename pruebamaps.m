% Crear un mapa con valores aleatorios
m = containers.Map;
m('a') = 5;
m('b') = 2;
m('c') = 10;
m('d') = 7;

% Extraer valores y claves en dos matrices separadas
values = cell2mat(m.values);
keys = m.keys;

% Ordenar los valores y mantener un registro de las claves
[sortedValues, idx] = sort(values);

% Recorrer la matriz ordenada y buscar las claves correspondientes en el mapa original
for i = 1:length(sortedValues)
    key = keys{idx(i)};
    value = m(key);
    fprintf('%s: %d\n', key, value);
end
