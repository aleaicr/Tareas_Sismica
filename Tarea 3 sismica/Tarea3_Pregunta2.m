%% Pregunta 2


%% Inicializar

clear variables
close all
clc

%% Importar Registro
% load() guarda el registro uppG 
% dt
% uppG
load('el_centro.mat');                                                      
%% Datos
Tn = 0.5;                                                                   % Periodo 
beta = 1/4;                                                                 % Factor de método newmark-beta
xi = 0;                                                                     % Razón de amortiguamiento
wn = 2*pi/Tn;                                                               % Frecuencia natural
kt = wn^2;                                                                  %

% Condiciones iniciales
ui = 0;
udi = 0;

Sd = Newmark_beta_lineal(beta,xi,dt,ui,udi,uppG);

for i = 1:size(Sd,1)
    if Sd(i,1) == Tn
        u_max = Sd(i,2);
    end
end

Fy = 0.125*kt*u_max;                                                        % Resistencia lateral
R = 10^(-5);
t = transpose(0:dt:(size(uppG,1)-1)*dt);

%% Parte i y ii
[u,ud,udd,fs,fluencia,ductilidad] = Newmark_No_Lineal(beta,Tn,xi,dt,ui,udi,uppG,Fy,R,t);


u = u*386.06; % De dónde sale el 386.06?

figure

subplot(3,1,1)
plot(t(:,1),u(:,1))
title('Desplazamientos')
ylabel('Desplazamientos [in]')

subplot(3,1,2)
plot(t(:,1),fs(:,1))
title('Fuerza Restitutiva')
ylabel('f_s/W')

subplot(3,1,3)
plot(t(:,1),fluencia(:,1))
title('Fluencia') 
xlabel('Tiempo [s]')
ylabel('Fluencia')
hold off

%% Parte iii
cont = 0;

for i = 1:size(u,1)
    if t(i,1) <= 2.05 && t(i,1) >= 1.368
        cont = cont + 1;
        fs1(cont,1) = fs(i,1);
        u1(cont,1) = u(i,1);
    end
end

figure
plot(u1(:,1),fs1(:,1))
title('Fuerza Restitutiva vs Desplazamientos') 
xlabel('Desplazamientos [in]')
ylabel('f_s/W')
