clc
clear
close all
format short g

Don=[ 1 5.00 0.00 0.00 200.7  0.10  44.9 
    2 0.00 5.00 0.00 627.5  0.12  35.6 
    3 0.00 0.00 5.00 98.73  0.22 42.0 
    4 2.50 2.50 0.00 213.1  0.16  42.4 
    5 2.50 0.00 2.50 134.9  0.13 49.8 
    6 0.00 2.50 2.50 144.1 0.17 40.3 
    7 1.67 1.67 1.67 148.6  0.12  45.5 
    8 3.32 0.84 0.84 181.0  0.12 47.8 
    9 0.84 3.32 0.84 195.4  0.14 41.1 
    10 0.84 0.84 3.32 120.1 0.16 48.3 ];

Exp=Don(:,2:4)/5
Rep=Don(:,5:end)
%enlever la boucle for c'est juste que je voulais automatiser pour les 3
%réponses
for r=1:1:1

subplot(3,2,2*r-1)
[h,hg,htick]=terplot;
hlabel=terlabel('SC','BETA','THETA');
colormap jet
ternaryc(Exp(:,1),Exp(:,2),Exp(:,3),Rep(:,r),'o')
subplot(3,2,2*r)
colormap jet
hlabel=terlabel('SC','BETA','THETA');
tersurf(Exp(:,1),Exp(:,2),Exp(:,3),Rep(:,r))

P1=Exp(:,1);
P2=Exp(:,2);
P3=Exp(:,3);

%MLSI

% modelfun= @(a,x) a(1)*P1+a(2)*P2+a(3)*P3;
% beta0=ones(1,3); % point de départ de l'optimisation

%MLAI

% modelfun= @(a,x) a(1)*P1+a(2)*P2+a(3)*P3 + ...
% a(4)*P1.*P2 + a(5)*P1.*P3 + a(6)*P2.*P3 + a(7)*P1.*P2.*P3;
% beta0=ones(1,7); % point de départ de l'optimisation

% MLAI + effets quad

% modelfun= @(a,x) a(1)*P1+a(2)*P2+a(3)*P3 + ...
% a(4)*P1.*P2 + a(5)*P1.*P3 + a(6)*P2.*P3 + ...
% a(7)*P1.*P2.*P3 + ...
% a(8)*P1.^2 + a(9)*P2.^2 + a(10)*P3.^2;
% beta0=ones(1,10); % point de départ de l'optimisation


mdl=fitnlm(Exp,Rep(:,r),modelfun,beta0)

end

%réponse 1 :
%On regarde les Radj, le mieux c'est mlai sans effet quad R=0.869 c'est
%limite mais ok

%Point en dehors du modèle en bord de ternaire donc c'est un plan mal fait
%si c'était un point abherant dans le ternaire ça aurait juste été la manip
% A1P1 + A2P2 + A12P12 A23P23
% mauvais modèle pour R²adj et mauvais modèle pour les choix de paramètre
% P3 n'est pas significatif et il a été pris dans le modèle mais c'est
% parce que c'est un ordre 1 donc bizarre de le jeter

% corps pur même propriété que les mélanges c'est pas vraiment vrai donc
% c'est foireux de prendre les bords parce que eau+1composant a pas les
% mêmes propriétés que eau+les 3 composants : vaut mieux prendre un point
% D-optimal.

%réponse 2 :
% OK mais meilleur avec MLAI effet quad surement parce que excel est limité
% pour le calcul d'effet quad

%réponse 3 : 
% OK mais MLAI effet quad meilleur R²adj mais tous les p-value >0.05 donc
% en fait MLAI sans effet quad c'est le bon choix.

figure(2)
plot(mdl.Residuals.Raw,'bd')
figure(3)
qqplot(mdl.Residuals.Raw)
figure(4)
plot(Rep(:,r),mdl.Fitted,'ro')