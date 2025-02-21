puntos=[1 1;1 3;2 3;3 2;3 4;5 5;5 6;7 6];
y_gorro=[1 2;2 4;5 (-3.5);8 3;0 8];
for 1=1:5
total=sum((puntos-y_gorro),"all");
disp()