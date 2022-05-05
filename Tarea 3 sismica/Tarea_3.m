%% Tarea 1 - Pregunta 1 - Ingeniería Sísmica
% Cristóbal Adasme
%
% Alexis Contreras

%% Inicializar

clc
clear all
close all

%% Pregunta 1

%%
%% 1.1
%% Importar datos

delimitador = ' ';
headerlines = 1;
Registro = importdata('Northridge-Tarzana-EW.txt',delimitador,headerlines);
Datos = Registro.data;

xi = [0; 0.01; 0.05: 0.10; 0.20];
n = length(xi);

beta = 1/4;

%% Paso temporal
dt = 0.02;

%%  Condiciones Iniciales
ui = 0;
udi = 0;

%% Aplicación de función NewmarkBeta
% Newmark_Lineal es una función en Newmark_Lineal.m
for i = 1:n
    [Sd(:,i),Sv(:,i),Sa(:,i),Psv(:,i),Psa(i,1)] = Newmark_beta_lineal(beta,xi(i,1),dt,ui,udi,Datos);
%     [Sd_1,Sv_1,Sa_1,PSv_1,PSa_1]=Newmark_Lineal(beta,0.01,0.02,0,0,Datos);
%     [Sd_5,Sv_5,Sa_5,PSv_5,PSa_5]=Newmark_Lineal(beta,0.05,0.02,0,0,Datos);
%     [Sd_10,Sv_10,Sa_10,PSv_10,PSa_10]=Newmark_Lineal(beta,0.10,0.02,0,0,Datos);
%     [Sd_20,Sv_20,Sa_20,PSv_20,PSa_20]=Newmark_Lineal(beta,0.20,0.02,0,0,Datos);
end

