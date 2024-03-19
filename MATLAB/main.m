clc
clear
close all
format short g

%% A boucler 

nb_boucle = 10 ; 
nb_points=10;
% 10 points en ligne , boucle rajoute une ligne de points
X_A=zeros(nb_boucle,nb_points); 
X_B=zeros(nb_boucle,nb_points);
X_C=zeros(nb_boucle,nb_points);

for i = 1:1: nb_boucle

Borne_sup_A=0.4;
Borne_sup_B=0.3;
Borne_sup_C=1-Borne_sup_A;
Borne_inf_A = 0 ; 
Borne_inf_B=0 ;
Borne_inf_C=1-Borne_sup_B;


X_A(i,:)=Borne_inf_A+((Borne_sup_A-Borne_inf_A)*rand(nb_points,1));
X_B(i,:)=Borne_inf_B+((Borne_sup_B-Borne_inf_B)*rand(nb_points,1));
X_C(i,:)=Borne_inf_C+((Borne_sup_C-Borne_inf_C)*rand(nb_points,1));



Matrice_Donnees(:,:,i)=[[X_A(i,:)'] [X_B(i,:)'] [X_C(i,:)']];

end

%end

% trace les nappes
Matrice_Resultats=rand(nb_points,1);

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



%% erreur de prediction

X=Matrice_Donnees ; % pose X
for j = 1:1:nb_boucle
for i = 1:1:nb_points
erreur_prediction(i,j) = sqrt((X(i,:))*inv(X'*X)*X(i,:)'); % prediction
ecart(j) = max(erreur_prediction(:,j))-min(erreur_prediction(:,j)); % ecart 

end
end




% %% D-optimal : on veut determinant max
% 
% 
% determinant = det(X'*X);  % determinant det(X'.X)
% 
% 
% %% A-optimalité : trace matrice minimale
% 
% trace = trace(inv(X'*X)); 
% 
% %% E-optimalité : minimiser valeur propre max
% 
% lambda = eig(inv(X'*X)) ; 
% 
% %% G-optimalité : minimise valeur max de la diagonale 
% 
% valeur_diag = diag(X*inv(X'*X)*X') ; % valeurs diag
% max_diag = max(valeur_diag) ;  % max diag


%% Matrice diagonale

%for i= 1:1:nb_boucle
X=Matrice_Donnees ; % pose X
variance_covariance = inv(X'*X) ; 
diagonale= diag(variance_covariance) ; 
ecart_diagonale = max(diagonale)-min(diagonale)
if ecart_diagonale == 0
    disp('la matrice est diagonale')
else
    disp("la matrice n'est pas diagonale")
end