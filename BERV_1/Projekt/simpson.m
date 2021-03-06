% Approximates the integral from lower to upper of f using Simpsons method.
% f is a vector of function values.
% PRE: length(f) must be odd.

function res = simpson(lower, upper, f)

dx = (upper - lower)/(length(f) - 1);
c = ones(1, length(f));

for i = 2:length(f) - 1
    if ~mod(i, 2)
        c(i) = 4;
    else
        c(i) = 2;
    end
end

res = dx / 3  * (c * f');