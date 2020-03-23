clear all
close all

%AND tanitohalmaz
tanito_halmaz=[1  0 0;
    1  0 1;
    1  1 0;
    1  1 1;];
u=0.5;
%AND elvart kimenet
 elvart=[0;
       0;
       0;
       1];
%AND bemenet es kimenet szama  
N=[3,1]  

teszt_tanito_halmaz=tanito_halmaz;
teszt_elvart=elvart;
w0{1}=(rand(N(1),N(2))-0.5)*0.1 %-s�lyzok kezdeti �rt�k�nek inicializ�l�sa
%tan�t�si ciklusoknak a sz�ma
tanitas=100;
aktualis=0 ; 
aktualis_par=1;
i=1;
for i=1:4
    sa= @(s,a) 1./(1+exp(-a*s))
    dsa= @(s,a) exp(-a*s)./((1+exp(-a*s)).^2)
    a=aktualis_par(1);
    w=w0{1};
    for i=1:tanitas
        E_tanito_halmaz(i)=0;
        [mt, nt] = size(teszt_tanito_halmaz)
        for j=1:mt	%a j-ik elem kiv�laszt�sa a tan�t�halmazb�l@
            x=tanito_halmaz(j,:)'; 
            inger=w'*x;		%az inger kisz�mol�sa
            y=sa(inger,a);		%a h�l� kimenet�nek a kisz�mol�sa
            hiba=elvart(j,:)'-y;	%a hiba kisz�mol�sa
            w=w+u*x*(hiba.*dsa(inger,a))';		%a s�lyzok tan�t�sa
            E_tanito_halmaz(i)=E_tanito_halmaz(i)+hiba'*hiba;	%a hiba �sszegz�se egy tan�t�si ciklusra. 
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
    xlabel('L�p�s')
    ylabel('Hiba')
    grid on;
    meres{i}={tanito_halmaz,elvart, teszt_tanito_halmaz,teszt_elvart, w0, u, tanitas, aktualis, aktualis_par}
    eredmeny{i}={w, tm, E_tanito_halmaz, E_tanito_halmaz_teszt}
end





