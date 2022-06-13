function [Sd,Sv,Sa,PSv,PSa]=Newmark_Lineal(beta,xi,dt,u_i,ud_i,uddg)
gamma=0.5;
Tn=0:0.01:5;
u=zeros(size(uddg,1),1);
ud=zeros(size(uddg,1),1);
udd=zeros(size(uddg,1),1);
Sd=zeros(size(Tn,2),1);
Sv=zeros(size(Tn,2),1);
Sa=zeros(size(Tn,2),1);
PSv=zeros(size(Tn,2),1);
PSa=zeros(size(Tn,2),1);
u(1,1)=u_i;
ud(1,1)=ud_i;
for j=1:size(Tn,2)                                                          % j es el periodo a evaluar
    if Tn(1,j)==0
        for i=1:size(uddg,1)                                                % i es el número de dato del registro
            udd(i,1)=uddg(i,1);
        end
        Sd(j,1)=Tn(1,j);
        Sd(j,1)=0;
        Sv(j,1)=Tn(1,j);
        Sv(j,1)=0;
        Sa(j,1)=Tn(1,j);
        Sa(j,2)=max(abs(udd(:,1)));
    else
        omega_n=2*pi/Tn(1,j);                                               % Frecuencia natural del sistema
        udd(1,1)=uddg(1,1)-2*xi*omega_n*ud_i-omega_n^2*u_i;
        a1=1/(beta*dt^2)+2*xi*omega_n*gamma/(beta*dt);
        a2=1/(beta*dt)+2*xi*omega_n*(gamma/beta-1);
        a3=(1/(2*beta)-1)+2*xi*omega_n*dt*(gamma/(2*beta)-1);
        k_ton=a1+omega_n^2;
        for i=2:size(uddg,1)
            p_ton=-uddg(i,1)+a1*u(i-1,1)+a2*ud(i-1,1)+a3*udd(i-1,1);
            u(i,1)=p_ton/k_ton;
            ud(i,1)=gamma/(beta*dt)*(u(i,1)-u(i-1,1))+(1-gamma/beta)*ud(i-1,1)+dt*(1-gamma/(2*beta))*udd(i-1,1);
            udd(i,1)=(u(i,1)-u(i-1,1))/(beta*dt^2)-ud(i-1,1)/(beta*dt)-(1/(2*beta)-1)*udd(i-1,1);
        end
        udd_tot=udd+uddg;
        udd_tot(1,1)=uddg(1,1);
        Sd(j,1)=Tn(1,j);
        Sd(j,2)=max(abs(u(:,1)));
        Sv(j,1)=Tn(1,j);
        Sv(j,2)=max(abs(ud(:,1)));
        Sa(j,1)=Tn(1,j);
        Sa(j,2)=max(abs(udd_tot(:,1)));
        PSv(j,1)=Tn(1,j);
        PSv(j,2)=omega_n*Sd(j,2);
        PSa(j,1)=Tn(1,j);
        PSa(j,2)=omega_n^2*Sd(j,2);
    end
    u(:,1)=zeros(size(u,1),1);
    ud(:,1)=zeros(size(ud,1),1);
    udd(:,1)=zeros(size(udd,1),1);
end

