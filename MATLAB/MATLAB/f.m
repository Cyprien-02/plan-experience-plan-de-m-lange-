function [Z] = f(X,Y)
    Z = 40+X.^2+Y.^2-20*(cos(2*pi*X)+cos(2*pi*Y));
end