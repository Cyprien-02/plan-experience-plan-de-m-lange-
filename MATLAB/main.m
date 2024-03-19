clc
clear
close all
format short g

%% Création des points et Matrices

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

    Matrice_Donnees(:,:,i)=[X_A(i,:)' X_B(i,:)' X_C(i,:)'];
    Matrice_Resultats(:,:,i)=rand(nb_points,1);

end

%% Trace les nappes (pas de boucle avec sinon trop de subplot)

subplot(1,2,1)
[h,hg,htick]=terplot;
hlabel=terlabel('SC','BETA','THETA');
colormap jet
ternaryc(Matrice_Donnees(:,1,1),Matrice_Donnees(:,2,1),Matrice_Donnees(:,3,1),Matrice_Resultats(:,:,1),'o');


subplot(1,2,2)
colormap jet
hlabel=terlabel('SC','BETA','THETA');
tersurf(Matrice_Donnees(:,1,1),Matrice_Donnees(:,2,1),Matrice_Donnees(:,3,1),Matrice_Resultats(:,:,1));


% [x,y]= ginput (3) % recupère les x,y quand on clique 



%% erreur de prediction

for j=1:1:nb_boucle

    X(:,:,j)= Matrice_Donnees(:,:,j) ; % pose X

    for i = 1:1:nb_points
        erreur_prediction(i,1,j) = sqrt((X(i,:,j))*inv(X(:,:,j)'*X(:,:,j))*X(i,:,j)'); % prediction
        ecart(1,1,j) = max(erreur_prediction(:,1,j))-min(erreur_prediction(:,1,j)); % ecart
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

for j=1:1:nb_boucle

    X(:,:,j)= Matrice_Donnees(:,:,j) ; % pose X

    matrice_variance_covariance(:,:,j) = inv(X(:,:,j)'*X(:,:,j)) ; % matrice qu'on veut diagonale
    diagonale(:,:,j) = diag(matrice_variance_covariance(:,:,j)) ; % recup les diags
    ecart_diagonale(1,1,j) = max(diagonale(:,:,j))-min(diagonale(:,:,j)); % ecart entre les chiffres des diags
    ecart_type_diag(1,1,j) = std(diagonale(:,:,j)) ; 
end

if ecart_type_diag == 0
    disp('la matrice est diagonale')
else
    disp("la matrice n'est pas diagonale")
end