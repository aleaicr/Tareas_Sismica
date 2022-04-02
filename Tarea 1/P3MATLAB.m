%% Inicializar
clear variables
close all
clc

uppG = readmatrix('Concepcion2010-L.txt');  % Registro
dt = 0.005;                                 % Paso temporal del registro para el muestreo-sampling
m = length(uppG);                           % Largo del registro
UPPG = fft(uppG);                           % DFT del registro
Fs = 1/dt;                                  % Frecuencia de muestreo del registro
s = -Fs/2:Fs/m:(Fs/2-Fs/m);                 % Rango de frecuencias
w = 2*pi*s;                                 % Rango de frecuencias angulares
Te = 2*pi./w;                                 % Rango de periodos
t = 0:dt:(m-1)*dt;                          % Vector de tiempo

figure
plot(s,fftshift(abs(UPPG)).^2) % Graficar el módulo al cuadrado vs las frecuencias
xlim([0 30])
xlabel('s')
ylabel('DFT')
title('DFT')

figure
plot(Te,fftshift(abs(UPPG)).^2)
xlim([0 50])
xlabel('T [sec]')
ylabel('DFT')
title('DFT')