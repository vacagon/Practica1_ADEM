clc;
clear variables;

w = 1.5;
imshow(imread("Mecanismo.png"));

%% Definimos las dimensiones del mecanismo
L1 = 95;
L2 = 33;
L3 = 125;
L4 = 75;
AC = 60;
BE = 55;
DE = 300;
CF = 120;
AD = DE-L3-BE;
AE = L3 + BE;
AF = sqrt((AC^2) + (CF^2));

%% Asignamos valores al GDL del cuadrilátero
alpha = 0:0.001:2*pi; %Ángulo que forma la manivela con la barra fija
alpha = rad2deg(alpha);

%% Calculamos los ángulos y dimensiones del cuadrilatero en funcion de la posición de la manivela
O4A = sqrt((ones(size(alpha)).*L2).^2+(ones(size(alpha)).*L1).^2-2*L1*L2.*cosd(alpha)); %Distancia O4A
delta = asind((L2.*sind(alpha))./(O4A)); %Ángulo de la diagonal O4A con la barra fija
phi = acosd((-(ones(size(alpha))*L4).^2 + (ones(size(alpha))*L3).^2 + O4A.^2)./(2*L3.*O4A)); %Ángulo de la diagonal O4A con la acopladora
gamma = 90 - atand(AC/CF).*ones(size(alpha));

%% Punto C
C = [L2.*cosd(alpha) + AC.*cosd(phi-delta); L2.*sind(alpha) + AC.*sind(phi-delta)]';

%% Punto D
D = [L2.*cosd(alpha) - AD.*cosd(phi-delta); L2.*sind(alpha) - AD.*sind(phi-delta)]';

%% Punto E
E = [L2.*cosd(alpha) + AE.*cosd(phi-delta); L2.*sind(alpha) + AE.*sind(phi-delta)]';

%% Punto F
F = [L2.*cosd(alpha) + AF.*cosd(gamma-phi+delta); L2.*sind(alpha) - AF.*sind(gamma-phi+delta)]';

%% Se representan las trayectorias obtenidas
figure;
plot(C(:,1), C(:,2), 'LineWidth', w);
hold on
plot(D(:,1), D(:,2), 'LineWidth', w);
plot(E(:,1), E(:,2), 'LineWidth', w);
plot(F(:,1), F(:,2), 'LineWidth', w);

xlim([-150,250]);
ylim([-150,150]);
grid on;
legend('Punto C', 'Punto D', 'Punto E', 'Punto F');
xlabel('Eje X');
ylabel('Eje Y');
title('Trayectorias de los puntos C, D, E y F')