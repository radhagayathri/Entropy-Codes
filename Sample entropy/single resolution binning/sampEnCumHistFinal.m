function [SampEn]= sampEnCumHistFinal(ts,m)
[b,a,nbins,bSize] = histogram2_sampEn(ts,m);

SampEn = [];
for i=1:nbins 
    
     sampEnHist(i) = log((b(i))/(a(i)));
     SampEn = [SampEn; i bSize (i*bSize) sampEnHist(i)];
end

