function ImprimirDiccionario(dictionary)
    keys = dictionary.keys;
    
    values = dictionary.values;
    
    for i = 1:length(keys)
        fprintf( 'Clave: %s\n', keys{i});
        fprintf('Valor:\n');
        fprintf( '%s\n', values{i});
        fprintf( '------------------------------\n');
    end
    
    
end