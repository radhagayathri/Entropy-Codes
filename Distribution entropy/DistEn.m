% Function to calculate Distribution entropy formulated by Li et al. in
% 2015
function [DE]= DistEn(data,m,M)

% DE is the calculated distribution entropy
% data is the input time-series
% m is the embedding dimension
% M is the bin number used in the probability distribution function 

[row,col]=size(data); % Making the input time-series a column vector
if row==1
    data=data';
    N=col;
else
    N=row;
end
ts=data; 

%Formation of template vectors at the embedding dimension m
tmpltMatM=[];
for i=1:m
    tmpltMatM=[tmpltMatM ts(i:N-m+i)];
end
matLenM=size(tmpltMatM,1);

allDistM=[]; % Matrix of all inter-vector distances 
for i=1:matLenM
    tmpltVec=tmpltMatM(i,:);
    matchMat=tmpltMatM([1:i-1 i+1:matLenM],:);
    tmpltMat=repmat(tmpltVec,matLenM-1,1);
    d= max(abs(tmpltMat-matchMat),[],2); % calculation of inter-vector distances
    allDistM=[allDistM d];
end

% Emperical probability distribution

freqCountBin = hist(allDistM(:),M);
[counts, binCenters]= hist(allDistM(:),M);
ProbfreqCountBin = freqCountBin./length(allDistM(:));

prob=ProbfreqCountBin(ProbfreqCountBin~=0);
y=prob.*log2(prob);
DE = -(1/(log2(M)))*sum(y); % Distribution entropy

epdf=[binCenters' ProbfreqCountBin']; % check the distribution if necessary


%----------------------------------------------------------------------------
% coded by Radhagayathri Udhayakumar,
% radhagayathri.udhayakumar@deakin.edu.au
% Updated version: 19th September 2020
% 
% To cite:
% 1. P. Li, C. Liu, K. Li, D. Zheng, C. Liu, and Y. Hou, “Assessing the complexity
% of short-term heartbeat interval series by distribution entropy.” Medical &
% Biological Engineering & Computing, 2015.
% 2. Chandan Karmakar, Radhagayathri K Udhayakumar, Peng Li, Svetha Venkatesh, Marimuthu Palaniswami,
% Stability, Consistency and Performance of Distribution Entropy in Analysing Short Length Heart Rate Variability
% (HRV) Signal, Frontiers in Physiology, 2017. 
%----------------------------------------------------------------------------