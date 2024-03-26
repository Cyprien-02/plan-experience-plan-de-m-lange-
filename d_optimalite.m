function[determinant]= d_optimalite(N,M)

for j=1:1:N

    X(:,:,j)= M(:,:,j) ; % pose X

    % D-optimal : on veut determinant max
    determinant(j,1) = det(X(:,:,j)'*X(:,:,j));  % determinant det(X'.X)


end

end
