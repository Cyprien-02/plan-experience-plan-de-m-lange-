function [popSuivante] = selectionElite(pop,N,E)
    popSuivante = zeros(N,3);
    popSuivante(1:E,:) = pop(1:E,:);
end