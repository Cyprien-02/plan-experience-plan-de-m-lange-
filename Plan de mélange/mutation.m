function [popSuivante] = mutation(popSuivante,N,E,PMUTATION,BMUTATION)
    direction = 0.5;
    for x=E+1:N
        a = rand;
        d = rand;
        if a<PMUTATION && d<direction
            popSuivante(x,1) = -BMUTATION+(BMUTATION+BMUTATION)*rand;
        elseif a<PMUTATION &&d>direction
            popSuivante(x,2) = -BMUTATION+(BMUTATION+BMUTATION)*rand;
        end
        popSuivante(x,3) = f(popSuivante(x,1),popSuivante(x,2));
    end    
end