function [Sd,Sv,Sa,PSv,PSa] = Newmark_Lineal(beta,xi,dt,ui,udi,uddg)
% Beta -> factor del método de Newmark
% xi -> Razón de amortiguamiento
% dt -> Rango de partición
% ui -> 
% udi -> 
% uddg -> aceleración del suelo

gamma = 0.5;
Tn = 0:0.01:5;                      % Tn, rango de periodos
N = size(uddg,1);
N2 = size(Tn,2);

% Inicialización de vectores
u = zeros(N,1);
ud = zeros(N,1);         
udd = zeros(N,1);
Sd = zeros(N2,1);
Sv = zeros(N2,1);
Sa = zeros(N2,1);
PSv = zeros(N2,1);
PSa = zeros(N2,1);
u(1,1) = ui;
ud(1,1) = udi;


for j = 1:N2                                                        % j es el periodo a evaluar
    if Tn(1,j) == 0
        for i = 1:size(uddg,1)                                                % i es el número de dato del registro
            udd(i,1) = uddg(i,1);
        end
        Sd(j,1) = Tn(1,j);
        Sd(j,1) = 0;
        Sv(j,1) = Tn(1,j);
        Sv(j,1) = 0;
        Sa(j,1) = Tn(1,j);
        Sa(j,2) = max(abs(udd(:,1)));
    else
        omegan = 2*pi/Tn(1,j);                                               % Frecuencia natural del sistema
        udd(1,1) = uddg(1,1) - 2*xi*omegan*udi - omegan^2*ui;
        a1 = 1/(beta*dt^2) + 2*xi*omegan*gamma/(beta*dt);
        a2 = 1/(beta*dt) + 2*xi*omegan*(gamma/beta-1);
        a3 = (1/(2*beta)-1) + 2*xi*omegan*dt*(gamma/(2*beta)-1);
        k_tongo = a1 + omegan^2;
        for i = 2:size(uddg,1)
            p_tongo = -uddg(i,1) + a1*u(i-1,1) + a2*ud(i-1,1) + a3*udd(i-1,1);
            u(i,1) = p_tongo/k_tongo;
            ud(i,1) = gamma/(beta*dt)*(u(i,1)-u(i-1,1)) + (1-gamma/beta)*ud(i-1,1) + dt*(1-gamma/(2*beta))*udd(i-1,1);
            udd(i,1) = (u(i,1)-u(i-1,1))/(beta*dt^2) - ud(i-1,1)/(beta*dt) - 1/((2*beta)-1)*udd(i-1,1);
        end
        udd_tot = udd + uddg;
        udd_tot(1,1) = uddg(1,1);
        Sd(j,1) = Tn(1,j);
        Sv(j,1) = Tn(1,j);
        Sa(j,1) = Tn(1,j);
        Sd(j,2) = max(abs(u(:,1)));
        Sv(j,2) = max(abs(ud(:,1)));
        Sa(j,2) = max(abs(udd_tot(:,1)));
        PSv(j,1) = Tn(1,j);
        PSa(j,1) = Tn(1,j);
        PSv(j,2) = omegan*Sd(j,2);
        PSa(j,2)=omegan^2*Sd(j,2);
    end
    u(:,1) = zeros(size(u,1),1);
    ud(:,1) = zeros(size(ud,1),1);
    udd(:,1) = zeros(size(udd,1),1);
end