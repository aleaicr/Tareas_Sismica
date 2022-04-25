%% Inicializar
clear variables
close all
clc
%% P1
%% P1.1
% Graficar PGA promedio esperado para un terremoto tipo interplaca vs la
% distancia r, con las condiciones
% H = 37 km; r = 10:1:500; Mw = [7.0;8.0;8.8]
% Comparar resultados
C1_rock = 0.00;
C2_rock = 0.00;
C3_rock = -2.552;
C4_rock = 1.45; % * Standard deviation for magnitud greater than 8 is equal to the value for magnitud equal to 8
C5_rock = -0.1; % *

% Para suelo (soil)
C1_soil = 0.00;
C2_soil = 0.00;
C3_soil = -2.329;
C4_soil = 1.45;
C5_soil = -0.1;

Zt_var = 0;
H_var = 37;
Mw_vector = [7.0; 8.0; 8.8];
r = (10:1:500).';

for Mw = 1:3
    Mw_var = Mw_vector(Mw,1);
    for r_var = 1:length(r)
        puntos_rock(r_var,Mw) = exp(0.2418 + 1.414*Mw_var + C1_rock + C2_rock*(10-Mw_var)^3 + C3_rock*log(r(r_var,1) + 1.7818*exp(0.544*Mw_var)) + 0.00607*H_var + 0.3846*Zt_var);
        puntos_soil(r_var,Mw) = exp(-0.6687 + 1.438*Mw_var + C1_soil + C2_soil*(10-Mw_var)^3 + C3_soil*log(r(r_var,1) + 1.097*exp(0.617*Mw_var)) + 0.00648*H_var + 0.3643*Zt_var);
    end
    fprintf('Mw %f Roca \n',Mw_var)

    figure
    loglog(r,puntos_rock(:,Mw))
    xlabel('r [km]')
    ylabel('PGA roca[unidad]')
    title('PGA para roca, sismo magnitud', Mw_var)

    fprintf('Mw %f Suelo \n',Mw_var)
    figure
    loglog(r,puntos_soil(:,Mw))
    xlabel('r [km]')
    ylabel('PGA suelo[unidad]')
    title('PGA para suelo, sismo magnitud', Mw_var)
end


%% P1.2
% Para un periodo de $T_n = 2.0 [sec]$ y un amortiguamiento de $\xi = 0.05$

% Para roca
C1_rock = -3.328;
C2_rock = -0.0080;
C3_rock = -2.1070;
C4_rock = 1.55;
C5_rock = -0.1;

% Para suelo
C1_soil = -6.433;
C2_soil = -0.0164;
C3_soil = -1.290;
C4_soil = 1.55;
C5_soil = -0.1;

for Mw = 1:3
    Mw_var = Mw_vector(Mw,1);
    for r_var = 1:length(r)
        puntos_rock(r_var,Mw) = exp(0.2418 + 1.414*Mw_var + C1_rock + C2_rock*(10-Mw_var)^3 + C3_rock*log(r(r_var,1) + 1.7818*exp(0.544*Mw_var)) + 0.00607*H_var + 0.3846*Zt_var);
        puntos_soil(r_var,Mw) = exp(-0.6687 + 1.438*Mw_var + C1_soil + C2_soil*(10-Mw_var)^3 + C3_soil*log(r(r_var,1) + 1.097*exp(0.617*Mw_var)) + 0.00648*H_var + 0.3643*Zt_var);
    end
    fprintf('Mw %f Roca \n',Mw_var)

    figure
    loglog(r,puntos_rock(:,Mw))
    xlabel('r [km]')
    ylabel('PGA roca[unidad]')
    title('PGA para roca, sismo magnitud', Mw_var)

    fprintf('Mw %f Suelo \n',Mw_var)
    figure
    loglog(r,puntos_soil(:,Mw))
    xlabel('r [km]')
    ylabel('PGA suelo[unidad]')
    title('PGA para suelo, sismo magnitud', Mw_var)
end

%% P1.3
% No sé hacerla xd


%% P2
% Está en Excel completa


%% P3
%% P3.a
% Definir fRM(r)
r_min = 7.2; % km
L1 = 34.4; % km
L2 = 62.3; % km
L = 96.7; % km

% Definr fRM(r)
% La vamos a definir en función de 'l' para que quede con los subcasos
syms r l
% fRM(r,l) = piecewise( ...
%     and(l<L1,L1<L2),piecewise(r == r_min,l/(L-l),and(r<r1,r>r_min),2*(L1-l)/(L-l),and(r<r2,r>r1),(L-2*L1)/(L-l)), ...
%     and(L1<l,l<L2),piecewise(r==r_min,L1/(L-l),and(r2>r,r>r_min),(L2-l)/(L-l)), ...
%     and(l>L2,L2>L1),1);

% % l<L1,L1<L2
% r11 = (r_min^2+(L1-l)^2)^0.5;
% r12 = (r_min^2+(L2-l)^2)^0.5;
% fRM1 = piecewise(r == r_min,l/(L-l),and(r<=r11,r>r_min),r/((L-l)*sqrt(r^2-r_min^2)),and(r<=r12,r>r11),r/((L-l)*sqrt(r^2-r_min^2)));
% % L1<l<L2
% r22 = (r_min^2+(L2-l)^2)^0.5;
% fRM2= piecewise(r==r_min,L1/(L-l),and(r22>=r,r>=r_min),r/((L-l)*sqrt(r^2-r_min^2)));
% % L1<L2<l
% fRM3 = piecewise(r==r_min,1,~(r==r_min),0);

%% P3.b
% En Excel
Mmax = 7.38;                                    % Magnitud de momento máxima (con L = 96.7) que la falla es capaz de producir

%% P3.c
% En Excel
l_vals = [43.72; 12.43; 6.62; 1.882]; %km
% magn = [0.95*Mmax; 0.85*Mmax; 0.8*Mmax;0.7*Mmax];

%% P3.d

for i = 1:length(l_vals)
    l = l_vals(i,1);
    l_val = l;
    if and(l_val<=L1,l_val<=L2)
        r1(i,1) = (r_min^2+(L1-l)^2)^0.5;
        r11 = r1(i,1);
        r2(i,1) = (r_min^2+(L2-l)^2)^0.5;
        r12 = r2(i,1);
        fRr(i,1) = piecewise(r == r_min,l/(L-l),and(r<=r11,r>r_min),r/((L-l)*sqrt(r^2-r_min^2)),and(r<=r12,r>r11),r/((L-l)*sqrt(r^2-r_min^2)));
    elseif and(l_val>L1, l_val<L2)
        r2(i,1) = (r_min^2+(L2-l)^2)^0.5;
        r22 = r2(i,1);
        fRr(i,1)= piecewise(r==r_min,L1/(L-l),and(r22>=r,r>=r_min),r/((L-l)*sqrt(r^2-r_min^2))); 
    elseif l_val>=L2
        fRr(i,1) = piecewise(r==r_min,1,~(r==r_min),0);                                        % Coordenada 1 es fR(r), no tiene ni r1 ni r2
    end
end

clear l_val r11 r12 r22
close all

figure
hold on
grid on
for i = 1:length(l_vals)
    fplot(fRr(i,1),[r_min r2(i,1)])
end
xlabel('r [km]')
ylabel('f_{R}(r)')
title('Funciones de densidad de probabilidad para las cuatro longitudes de ruptura')
legend('l = 43.72km; Magn = 7.01','l = 12.42km; Magn = 6.27','l = 6.62km; Magn = 5.90','l = 1.88km; Magn = 5.16')

%% P3.e

% Para el caso de ruptura asociado a 0.7Mmax  => l = 1.882km
% Aproximar fR(r) numéricamente utilizando histogramas

% 1. Dividir la falla en segmentos de longitud dx
Dx = [0.1; 1; 2]; %km
% Para cada división, calcular la distancia ri asociada
for i = 1:length(Dx)
    pos_x(:,i) = (0:Dx(i,1):L).';      % Columna 1 contiene posición x cada 0.1, columna 2 cada 1km, columna 3 cada 2km
end
% Determinamos ri para cada segmento
for i = 1:lenght(Dx)
    for j = 1:length(pos_x(:,i))
        if pos_x(j,i) < L1
            ri(j,i) = sqrt((L1 - pos_x(j,i))^2 + r_min^2);
        end
        if pos_x(j,i) > L1
            ri(j,i) = sqrt((pos_x(j,i) - L1)^2 + r_min^2);
        end
    end
end

% Determinamos cantidad de veces que se repite un ri dentro del rango R

DR = [1;2.5;5]; % km

for i = length(DR)
    R_range(i) = (0:DR(i,1):(r_min^2+L2^2)^0.5).';          %Creo un rango de R+DR.... R+DR...    
end

R_frec = zeros(length(R_range),length(Dx));                 % Inicializo matriz de zeros(Rango_R1,Rango_R2,Rango_R3), pero nos quedamos con el mayor

for i = 1:length(Dx)                                        % Para cada Dx
    for K = 2:length(R_range)                               % Para cada Rango_R, no pasa nada si partimos de 
        for j = 1:length(ri(:,i))                           % Para cada largo del Dx asociaso
            if and(ri(j,i) < R_range(k-1,1),ri(j,i)>R_range(k,1))% Si ri está dentro del rango (ESTO HAY QUE ARREGLARO)
                R_frec(k,i) = R_frec(k,i) + 1;              % Si está dentro del rango, sumamos uno, si no entonces no pasa nada
            end
        end
    end
end


