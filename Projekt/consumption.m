% Returns a vector of energy consuption values at the given speeds, computed
% using the least squares approximation to the data in the given file.

function c = consumption(s, model)

sData = load(model, 'speed_kmph').speed_kmph;
cData = load(model, 'consumption_Whpkm').consumption_Whpkm;

coeff = myOLS(sData, cData);
S = [1./s' ones(length(s), 1) s' s.^2'];

c = S * coeff;