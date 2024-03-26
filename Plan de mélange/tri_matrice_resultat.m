function[Matrice_Resultats_triee]= tri_matrice_resultat(N,det,M)

ordre = 1 : 1 : N ;
D = [det ordre'] ; 
D = sortrows(D,1,'descend') ; 

for i = 1 : 1 : N

    j = D(i,2) ; 
    Matrice_Resultats_triee(:,:,i) = M(:,:,j) ; 

end


end