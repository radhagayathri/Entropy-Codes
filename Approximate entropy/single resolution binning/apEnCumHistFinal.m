function [apEn]= apEnCumHistFinal(ts,m)
[b,a,nbins,bSize] = histogram2_apEn(ts,m);

apEn = [];
for i=1:nbins 
    
     apEnHist(i) = (b(i))-(a(i));
     apEn = [apEn; i bSize (i*bSize) apEnHist(i)];
end

