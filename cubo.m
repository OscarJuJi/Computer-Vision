% Creamos las coordenadas x, y, z para cada vértice del cubo unitario
x = [0 1 1 1 0 1 0 0];
y = [0 0 1 0 0 1 1 1];
z = [0 0 0 1 1 1 0 1];

n = length(x);
class1_x = x(1:n/2);
class1_y = y(1:n/2);
class1_z = z(1:n/2);

class2_x = x(n/2+1:end);
class2_y = y(n/2+1:end);
class2_z = z(n/2+1:end);
% Solicitamos un vector al usuario

si=1;
% Verificamos a qué clase pertenece el vector
while (si==1)
    vector = input('Ingrese un vector de la forma [x y z]: ');
   distances = sqrt((x-vector(1)).^2 + (y-vector(2)).^2 + (z-vector(3)).^2);
   
   % Determinamos a qué clase pertenece el vector
   if any(distances(1:4) == min(distances(1:4)))
       disp('El vector pertenece a la Clase 1');
   elseif any(distances(5:8) == min(distances(5:8)))
       disp('El vector pertenece a la Clase 2');
   else
       disp('El vector no pertenece a ninguna clase');
   end
   
    si = input('Desea ingresar otro vector');
end
% Plotear los puntos en un gráfico 3D
figure;
plot3(class1_x, class1_y, class1_z, 'o', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
hold on;
plot3(class2_x, class2_y, class2_z, 'o', 'MarkerSize', 10, 'MarkerFaceColor', 'b');
axis equal;
legend('Clase 1', 'Clase 2');
