function diffabs
pulsewidth=50; %fs laser
sigsq = pulsewidth.^2; %sigma squared = width of the envelope squared in fs^2
I0 = 0.5;
I = @(t) I0*exp((-t.^2)/(2*sigsq)); %intensity envelope gaussian
N=100000; dt=1; %total time and resolution
n_c=zeros(1,N);
n_ex=zeros(1,N);
%c_rel_time = 100;
%c_cap_time=1000;
ex_cap_time=1000;%zeros(1,N);
c_rel_time=100;
d_rel_time=62000;
ex_rel_time=2000;
ph_rel_time = 20000;
n_d=zeros(1,N); 
n_ph=zeros(1,N);
for ii=1:N-1
    t=(ii-1)*dt;
    n_c(ii+1) = dt*(I(t-200) - (n_c(ii)/c_rel_time))+n_c(ii);
    n_ex(ii+1) = dt*((n_c(ii)/c_rel_time) - (n_ex(ii)/ex_rel_time)-(n_ex(ii)/ex_cap_time))+n_ex(ii);
    n_d (ii+1) = dt*((n_ex(ii)/ex_cap_time) - (n_d(ii)/d_rel_time))+n_d(ii);
    if n_d(ii+1)<n_d(ii)
        n_ph(ii)=n_ph(ii) + 12*(n_d(ii)-n_d(ii+1));%12 is fitting parameter
    end
    if n_ph(ii)>0
        n_ph(ii+1) = -dt*(n_ph(ii)/ph_rel_time) + n_ph(ii);
    end
end
%*(100-n_d(ii));*(100-n_d(ii))
alphaexc=1.0;alphadef=2.0;n_d_init=n_d(1);alphacarrierBGR=0.3;%(1000-n_d(ii))
alphaphBGR=-0.4;factor = 0.1;
diffabs = factor*(-alphaexc*(n_ex) + alphadef*(n_d - n_d_init) - alphacarrierBGR*(n_c) - alphaphononBGR(N,dt)-alphaphBGR*n_ph);
t = dt*(1:N)/1000;
figure
hold on
plot(t,n_c,'k','DisplayName','n_c')
plot(t,n_d,'b','DisplayName','n_d')
plot(t,n_ex,'r','DisplayName','n_x')
%plot(t,n_ph,'c','DisplayName','n_p')
legend('show');
hold off
figure;
plot(t,diffabs)
grid on;
figure;
plot(t,n_ph)
function BG = alphaphononBGR(N,dt)
    BGwidth = 10000;
    sigsqr = BGwidth^2; %sigma squared = width of the envelope squared in fs^2
    I0r = 0;%0.011;%0.005;
    Ir = @(t) I0r*exp(-(t.^2)/(2*sigsqr)); %intensity envelope
    BG = zeros(1,N);BGrel=100000;
    for jj = 1:N-1
        tr=(jj-1)*dt;
        BG(jj+1) = BG(jj)+ dt*(Ir(tr-200)-(BG(jj)/BGrel));
    end
    figure
    plot(dt*(1:N),BG)
    figure; plot(dt*(1:N),Ir(dt*(1:N)-200))
end

end
    