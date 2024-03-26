function [popSuivante] = reproduction(popSuivante,N,E,PCROISEMENT)
    for n=1:1:(N-E)
        list_1=randperm(size(pop,1));
        for j=1:1:10
            ind_1=list_1(j);
            if rand<PCROISEMENT 
                popSuivante(j,:,E+n) = popSuivante(ind_1,:,mod(n,2)+1);
            else
                popSuivante(j,:,E+n) = popSuivante(j,:,mod(n+1,2)+1)
            end
        end
    end
end

