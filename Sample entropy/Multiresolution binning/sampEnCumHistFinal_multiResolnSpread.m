function [sampEn]= sampEnCumHistFinal_multiResolnSpread(ts,m)
[b,a,range] = histogram2_sampEn_multiResolnSpread(ts,m);
nbins=length(range);

sampEn = [];
for i=1:nbins 
    
     sampEnHist(i) = log((b(i))/(a(i)));
     sampEn = [sampEn; i range(i)  sampEnHist(i)];
end

