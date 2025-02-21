clc;
close all;
warning off all;

minc1 = input('Ingrese el valor mínimo del intervalo: ');
maxc1 = input('Ingrese el valor máximo del intervalo: ');

% Inicializar las clases para números primos y no primos
ClasePrimos = [];
ClaseNoPrimos = [];

% Recorremos el intervalo y clasificamos los números
for num = minc1:maxc1
    if isprime(num)
        ClasePrimos = [ClasePrimos, num];
    else
        ClaseNoPrimos = [ClaseNoPrimos, num];
    end
end
numero_a_clasificar = input('Ingrese un número para clasificar: ');
if numero_a_clasificar>maxc1
    fprintf('No esta en el intervalo')
elseif numero_a_clasificar<minc1
    fprintf('No esta en el intervalo')
else
    distancia_euclidiana_primos = abs(ClasePrimos - numero_a_clasificar);
    distancia_euclidiana_no_primos = abs(ClaseNoPrimos - numero_a_clasificar);

    if min(distancia_euclidiana_primos) <= min(distancia_euclidiana_no_primos)
        fprintf('El número %d pertenece a la clase de Primos.\n', numero_a_clasificar);
    else
        fprintf('El número %d pertenece a la clase de No Primos.\n', numero_a_clasificar);
    end
end

% Visualizar las dos clases
figure;
scatter(ClasePrimos, zeros(size(ClasePrimos)), 'filled', 'MarkerFaceColor', 'b');
hold on;
grid on;
scatter(ClaseNoPrimos, zeros(size(ClaseNoPrimos)), 'filled', 'MarkerFaceColor', 'r');
title('Clasificación de Números Primos y No Primos en el Intervalo');
xlabel('Número');

hold on;
scatter(numero_a_clasificar,zeros(size(numero_a_clasificar )),'filled', 'MarkerFaceColor', 'y')
legend('Primos', 'No Primos','Punto');