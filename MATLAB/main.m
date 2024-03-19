clc
clear
close all
format short g

nb_points=40;

Borne_sup_A=0.4;
Borne_sup_B=0.3;
Borne_sup_C=1-Borne_sup_A;
Borne_inf_C=1-Borne_sup_B;

% Intervalle_A=Borne_sup_A-Borne_inf_A;
% Intervalle_B=Borne_sup_B-Borne_inf_B;
X_A=Borne_sup_A*rand(nb_points,1);
X_B=Borne_sup_B*rand(nb_points,1);
X_C=Borne_inf_C+((Borne_sup_C-Borne_inf_C)*rand(nb_points,1));
Matrice_Donnees=[[0;X_A;Borne_sup_A] [0;X_B;Borne_sup_B] [Borne_inf_C;X_C;Borne_sup_C]];
Matrice_Resultats=rand(nb_points+2,1);


subplot(1,2,1)
[h,hg,htick]=terplot;
hlabel=terlabel('SC','BETA','THETA');
colormap jet
ternaryc(Matrice_Donnees(:,1),Matrice_Donnees(:,2),Matrice_Donnees(:,3),Matrice_Resultats,'o');


subplot(1,2,2)
colormap jet
hlabel=terlabel('SC','BETA','THETA');
tersurf(Matrice_Donnees(:,1),Matrice_Donnees(:,2),Matrice_Donnees(:,3),Matrice_Resultats);


% [x,y]= ginput (3)


%% D-optimal : on veut determinant max

X=Matrice_Donnees ; % pose X
determinant = det(X'*X);  % determinant det(X'.X)


%% A-optimalité : trace matrice minimale

trace = trace(inv(X'*X)); 

%% E-optimalité : minimiser valeur propre max

lambda = eig(inv(X'*X)) ; 

%% G-optimalité : minimise valeur max de la diagonale 

valeur_diag = diag(X*inv(X'*X)*X') ; % valeurs diag
max_diag = max(valeur_diag) ;  % max diag

%% erreur de prediction

for i = 1:1:nb_points
erreur_prediction = sqrt((X(i,:))*inv(X'*X)*X(i,:)');
end


