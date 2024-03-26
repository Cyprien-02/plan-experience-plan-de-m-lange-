function[M_don_triee]= trie_matrice_donnees(N,ecartype,M_don)

ordre = 1 : 1 : N ;
D = [ecartype ordre'] ;
D = sortrows(D,1,'ascend') ;

for i = 1 : 1 : N

    j = D(i,2) ;
    M_don_triee(:,:,i) = M_don(:,:,j) ;

end


