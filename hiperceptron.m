clear all
close all

tanito_halmaz=[1  1 0 1  1 1 1  1 0 1; % H betu 
    1  0 1 0  0 1 0  0 1 0]; % I betu

u=0.5;

elvart=[1 0;  % H betu, mert az elso kimenet 1-es, masodik 0
      0 1;];% I betu, mert az elso kimenet 0-es, masodik 1

N=[10, 2];
teszt_tanito_halmaz=tanito_halmaz;
teszt_elvart=elvart;
w0{1}=(rand(N(1),N(2))-0.5)*0.1 %-súlyzok 
%tanítási ciklusoknak a száma
tanitas=100;
aktualis=0 ; 


aktualis_par=1;
%%neuronháló ciklusban való meghívása
i=1;
for i=1:4
    sa= @(s,a) 1./(1+exp(-a*s))
    dsa= @(s,a) exp(-a*s)./((1+exp(-a*s)).^2)
    a=aktualis_par(1);
    w=w0{1};
    for i=1:tanitas
        E_tanito_halmaz(i)=0;
        [mt, nt] = size(teszt_tanito_halmaz)
        for j=1:mt	%a j-ik elem kiválasztása a tanítóhalmazból@
            x=tanito_halmaz(j,:)'; 
            inger=w'*x;		%az inger kiszámolása
            y=sa(inger,a);		%a háló kimenetének a kiszámolása
            hiba=elvart(j,:)'-y;	%a hiba kiszámolása
            w=w+u*x*(hiba.*dsa(inger,a))';		%a súlyzok tanítása
            E_tanito_halmaz(i)=E_tanito_halmaz(i)+hiba'*hiba;	%a hiba összegzése egy tanítási ciklusra. 
            tm=i;
        end    
        [mteszt, nteszt] = size(teszt_tanito_halmaz)
        E_tanito_halmaz_teszt(i)=0;
        for j=1:mteszt
            x=teszt_tanito_halmaz(j,:)'; 
            inger=w'*x;		
            y=sa(inger,a);	
            hiba=teszt_elvart(j,:)'-y;
            E_tanito_halmaz_teszt(i)=E_tanito_halmaz_teszt(i)+hiba'*hiba;
        end    
    end
    wf{1} = w;    
    figure
    plot(E_tanito_halmaz);
    hold on
    plot(E_tanito_halmaz_teszt)
    xlabel('Lépés')
    ylabel('Hiba')
    grid on;
    meres{i}={tanito_halmaz,elvart, teszt_tanito_halmaz,teszt_elvart, w0, u, tanitas, aktualis, aktualis_par}
    eredmeny{i}={w, tm, E_tanito_halmaz, E_tanito_halmaz_teszt}
end




