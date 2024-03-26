function [popSuivante] = reproduction(pop,popSuivante,N,E,PCROISEMENT)
    indice = randi([1,N],N-E,3);
    for n=1:length(indice(:,1))
        i = indice(n,1);
        j = indice(n,2);
        k = indice(n,3);

        if rand<PCROISEMENT 
            % faire un choix au hasard de a et b dans i j et k
            popSuivante(E+n,1) = pop(a,1);
            popSuivante(E+n,2) = pop(b,2);
        else 
            popSuivante(E+n,:) = pop(i,:);
        end
    end    
end