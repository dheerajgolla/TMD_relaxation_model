function BG = alphaphononBGR(N,dt)
    BGwidth = 8000;
    sigsqr = BGwidth^2; %sigma squared = width of the envelope squared in fs^2
    I0r = 0;0.011;%0.005;
    Ir = @(t) I0r*exp(-(t.^2)/(2*sigsqr)); %intensity envelope
    BG = zeros(1,N);BGrel=100000;
    for jj = 1:N-1
        tr=(jj-1)*dt;
        BG(jj+1) = BG(jj)+ dt*(Ir(tr-200)-(BG(jj)/BGrel));
    end
%     figure
%     plot(dt*(1:N),BG)
    %figure; plot(dt*(1:N),Ir(dt*(1:N)-200))
end