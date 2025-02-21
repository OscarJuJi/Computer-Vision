% Especifica la ruta de la carpeta que contiene las imágenes
carpeta = 'C:\Users\Oscar\Documents\MATLAB\WhatsApp Unknown 2023-10-25 at 6.23.06 PM';

% Obtiene la lista de archivos en la carpeta
archivos = dir(fullfile(carpeta, '*.jpeg')); % Cambia '*.png' al formato de tus imágenes

% Inicializa un contador para el nuevo nombre de archivo
contador = 1;

% Itera a través de cada archivo en la carpeta
for i = 1:length(archivos)
    % Obtiene el nombre del archivo actual
    nombreArchivo = archivos(i).name;
    
    % Crea el nuevo nombre de archivo con un formato secuencial
    nuevoNombre = sprintf('imagen%d.png', contador); % Cambia 'imagen%d.png' según tus necesidades
    
    % Renombra el archivo actual
    movefile(fullfile(carpeta, nombreArchivo), fullfile(carpeta, nuevoNombre));
    
    % Incrementa el contador para el próximo archivo
    contador = contador + 1;
end

disp('Proceso de renombrado completado.');
