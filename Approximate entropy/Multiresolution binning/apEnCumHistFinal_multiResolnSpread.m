function [apEn]= apEnCumHistFinal_multiResolnSpread(ts,m)
[b,a,range] = histogram2_apEn_multiResolnSpread(ts,m);
nbins=length(range);

apEn = [];
for i=1:nbins 
    
     apEnHist(i) = (b(i))-(a(i));
     apEn = [apEn; i range(i) apEnHist(i)];
end

