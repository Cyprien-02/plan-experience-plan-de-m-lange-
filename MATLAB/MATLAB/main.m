clc
clear
close all
format short g

%% Création des points et Matrices

nb_boucle = 10 ; 
nb_points=10;

%% délimitations des titres limites

%à essayer pour voir l'affichage qui marche
% a=[0.1 0.1 0.2];
% b=[0.4 0.3 0.9];
a=[0.2 0.2 0.1];
b=[0.5 0.5 0.6];


% % a=rand(1,3);
% % for i=1:1:3
% %     b(i)=a(i)+rand(1,1)*(1-a(i));
% % end

%% Délimitation des bordures

B=zeros(1,3); % matrice des bords
n=1;
for i=1:1:3
    j=mod(i,3)+1;
    k=mod(i+1,3)+1;
    a_e(i)=1-b(j)-b(k);
    b_e(i)=1-a(j)-a(k);
end
m_a=max(a,a_e);
m_b=min(b,b_e);


for i=1:1:3
    j=mod(i,3)+1;
    k=mod(i+1,3)+1;
    if a(i)<=a_e(i)
        B(n,i)=a_e(i);
        B(n,j)=b(j);
        B(n,k)=b(k);
        n=n+1;
    else
        B(n,i)=a(i);
        B(n,j)=m_b(j);
        B(n,k)=1-a(i)-m_b(j);
        B(n+1,i)=a(i);
        B(n+1,j)=1-a(i)-m_b(k);
        B(n+1,k)=m_b(k);
        n=n+2;
    end
end

for i=1:1:3
    j=mod(i,3)+1;
    k=mod(i+1,3)+1;
    if b_e(i)<=b(i)
        B(n,i)=b_e(i);
        B(n,j)=a(j);
        B(n,k)=a(k);
        n=n+1;
    else
        B(n,i)=b(i);
        B(n,j)=m_a(j);
        B(n,k)=1-b(i)-m_a(j);
        B(n+1,i)=b(i);
        B(n+1,j)=1-b(i)-m_a(k);
        B(n+1,k)=m_a(k);
        n=n+2;
    end
end

Rep=rand(n-1,1); % on peut pas mettre que des 1 ternaryc veut pas plot sinon

subplot(2,2,1)
[h,hg,htick]=terplot;
hlabel=terlabel('A','B','C');
colormap jet
ternaryc(B(:,1),B(:,2),B(:,3),Rep,'o');


subplot(2,2,2)
colormap jet
hlabel=terlabel('A','B','C');
tersurf(B(:,1),B(:,2),B(:,3),Rep);

%% matrices des points


% 10 points en ligne , boucle rajoute une ligne de points
X_A=zeros(nb_boucle,nb_points); 
X_B=zeros(nb_boucle,nb_points);
X_C=zeros(nb_boucle,nb_points);

M=zeros(nb_points,3);
for i = 1:1: nb_boucle
    
    M(:,1)=rand(nb_points,1)*(m_b(1)-m_a(1))+m_a(1);
    k_1=max(a(2),1-M(:,1)-m_b(3)); % à priori toujours a(2) ??? bizarre
    k_2=min(b(2),1-M(:,1)-m_a(3));
    M(:,2)=rand(nb_points,1).*(k_2-k_1)+k_1;
    M(:,3)=1-M(:,1)-M(:,2);
    Matrice_Donnees(:,:,i)=M;
    Matrice_Resultats(:,:,i)=rand(nb_points,1);
    % Borne_sup_B=0.3;
    % Borne_sup_C=1-Borne_sup_A;
    % Borne_inf_A = 0 ;
    % Borne_inf_B=0 ;
    % Borne_inf_C=1-Borne_sup_B;
    % 
    % 
    % X_A(i,:)=Borne_inf_A+((Borne_sup_A-Borne_inf_A)*rand(nb_points,1));
    % X_B(i,:)=Borne_inf_B+((Borne_sup_B-Borne_inf_B)*rand(nb_points,1));
    % X_C(i,:)=Borne_inf_C+((Borne_sup_C-Borne_inf_C)*rand(nb_points,1));
    % 
    % Matrice_Donnees(:,:,i)=[X_A(i,:)' X_B(i,:)' X_C(i,:)'];
    % Matrice_Resultats(:,:,i)=rand(nb_points,1);

end

%% Trace les nappes (pas de boucle avec sinon trop de subplot)
subplot(2,2,3)
[h,hg,htick]=terplot;
hlabel=terlabel('A','B','C');
colormap jet
ternaryc([B(:,1);Matrice_Donnees(:,1,1)],[B(:,2);Matrice_Donnees(:,2,1)],[B(:,3);Matrice_Donnees(:,3,1)],[Rep;Matrice_Resultats(:,:,1)],'o');


subplot(2,2,4)
colormap jet
hlabel=terlabel('A','B','C');
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

%% Autres critères otpimalité

for j=1:1:nb_boucle

    X(:,:,j)= Matrice_Donnees(:,:,j) ; % pose X

% D-optimal : on veut determinant max
determinant(:,:,j) = det(X(:,:,j)'*X(:,:,j));  % determinant det(X'.X)

% A-optimalité : trace matrice minimale
valeur_trace(:,:,j) = trace(inv(X(:,:,j)'*X(:,:,j))); 

% E-optimalité : minimiser valeur propre max
lambda(:,:,j) = eig(inv(X(:,:,j)'*X(:,:,j))) ; 

% G-optimalité : minimise valeur max de la diagonale 
valeur_diag(:,:,j) = diag(X(:,:,j)*(X(:,:,j)'*X(:,:,j))*X(:,:,j)') ; % valeurs diag
max_diag(:,:,j) = max(valeur_diag(:,:,j)) ;  % max diag

end
%% Matrice variance/covariance : on veut qu'elle soit diagonale

for j=1:1:nb_boucle

    X(:,:,j)= Matrice_Donnees(:,:,j) ; % pose X
    matrice_variance_covariance(:,:,j) = inv(X(:,:,j)'*X(:,:,j)) ; % matrice qu'on veut diagonale
    diagonale(:,:,j) = diag(matrice_variance_covariance(:,:,j)) ; % recup les diags
    ecart_diagonale(1,1,j) = max(diagonale(:,:,j))-min(diagonale(:,:,j)); % ecart entre les chiffres des diags
    ecart_type_diag(1,1,j) = std(diagonale(:,:,j)) ; % ecart-type de la diagonale

    if ecart_type_diag == 0
        disp('la matrice est diagonale')
    else
        disp("la matrice n'est pas diagonale")
    end

end

%% optimisation


%% Algorithme génétique
G = 500;
N=10; % nb_points
E = 2; % élites retenues
PMUTATION = 0.5;
BMUTATION = 0.8;
PCROISEMENT = 1;
pop=Matrice_Donnees(:,:,:);
for generation=1:G
    pop_croisee = reproduction(pop,selectionElite(pop,N,E),N,E,PCROISEMENT);
    pop_mutee = mutation(pop_croisee,N,E,PMUTATION,BMUTATION);
    pop = evaluationFitness(pop_mutee);
    imagesc(X,Y,Z)
    colormap jet
    hold on
    plot(pop(:,1),pop(:,2),'w*')
    pause(0.01)
    hold off
end

%% Conclusion
pop(1,1:2)
