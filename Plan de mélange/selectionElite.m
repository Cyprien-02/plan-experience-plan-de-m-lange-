function [popSuivante,detSuivant] = selectionElite(pop,det,N,E)
    popSuivante = zeros(size(pop,1),3,N);
    popSuivante(:,:,E) = pop(:,:,E);
    detSuivant=zeros(1,1,N);
    detSuivant(:,:,E) = det(:,:,E);
end