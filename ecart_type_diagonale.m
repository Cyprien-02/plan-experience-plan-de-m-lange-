function[ecart_type_diag]= ecart_type_diagonale(N,M_don)

for j=1:1:N

    X(:,:,j)= M_don(:,:,j) ; % pose X
    matrice_variance_covariance(:,:,j) = inv(X(:,:,j)'*X(:,:,j)) ; % matrice qu'on veut diagonale
    diagonale(:,:,j) = diag(matrice_variance_covariance(:,:,j)) ; % recup les diags
    ecart_diagonale(1,1,j) = max(diagonale(:,:,j))-min(diagonale(:,:,j)); % ecart entre les chiffres des diags
    ecart_type_diag(j,1) = std(diagonale(:,:,j)) ; % ecart-type de la diagonale
end


end