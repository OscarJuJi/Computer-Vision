% Datos de entrada para la compuerta OR
X = [0 0; 0 1; 1 0; 1 1];
% Etiquetas de salida para la compuerta OR
Y = [0; 1; 1; 1];
puntos_x=[1.5 0];
puntos_y=[0 1.5];

% Inicialización de los pesos y el sesgo
w = rand(1, 2);  % Pesos aleatorios iniciales
b = rand();      % Sesgo aleatorio inicial
lr = 1;        % Tasa de aprendizaje

% Entrenamiento del perceptrón

w_past=0;
while (w_past~=w)
    for i = 1:size(X, 1)
        
        % Calcular la salida del perceptrón
        y_pred = (X(i, :) * w' + b) >= 0;
        
        % Calcular el error
        error = Y(i) - y_pred;
        
        % Actualizar los pesos y el sesgo
        w = w + lr * error * X(i, :);
        b = b + lr * error;
        w_past=w;
        disp("etapa")
    end
end
figure(1)
plot(c1(1,:),X)
% Comprobación del perceptrón entrenado
test_inputs = [0 0; 0 1; 1 0; 1 1];
for i = 1:size(test_inputs, 1)
    y_pred = (test_inputs(i, :) * w' + b) >= 0;
    fprintf('Entrada: [%d %d], Salida predicha: %d\n', test_inputs(i, :), y_pred);
end
