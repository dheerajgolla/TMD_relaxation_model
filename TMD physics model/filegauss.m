close all;
dw= 0.001;
w = 1.9:dw:2.1;
A = 0.00296;B=0.92*A;
abs1 = gauss(0.0253,w,1.993,0.05396,A);
abs2 = gauss(0.0253,w,1.976,0.0521,B);
figure
plot(w,abs1);
hold on;
plot(w,abs2);
hold off

xlim([1.9 2.1]);

figure
hax=axes; 
plot(w,abs2-abs1)
xlim([1.9 2.1]);
SP=1.92; %your point goes here 
line([SP SP],get(hax,'YLim'),'Color',[1 0 0])
SP=2; %your point goes here 
line([SP SP],get(hax,'YLim'),'Color',[0 0 1])
SP=2.06; %your point goes here 
line([SP SP],get(hax,'YLim'),'Color',[0 0 0])
refline([0 0])