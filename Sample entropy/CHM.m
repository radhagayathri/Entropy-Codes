% Function to implement Cumulative Histogram Method for entropy profiling

function [b,a,range] = CHM(data,m)

% data is the input time-series;
% m is the embedding dimension (Emb.dim);
% b, a and range are the output parameters;
% SampEn(r)=ln(probability of matches at Emb.dim m/probability of matches at
% Emb.dim m+1);
% Representing the ratio as b/a, we write SampEn(r)=ln(b/a); 
% range is the entire set of data driven r-values for the given time-series
% b and a are vectors, denoting the probabilities calculated at all values of range.

[row,col]=size(data); % correcting time-series representation, making it a column vector;
if row==1
    data=data';
    N=col;
else
    N=row;
end

ts=data; % Time-series as a column vector

% Finding template vectors at Emb.dim m
tmpltMatM=[];
for i=1:m
    tmpltMatM=[tmpltMatM ts(i:N-(m+1)+i)];
end

% Finding template vectors at Emb.dim m+1
tmpltMatM1=[];
for i=1:m+1
    tmpltMatM1=[tmpltMatM1 ts(i:N-(m+1)+i)];
end

% Finding vector-vectors distances at Emb.dim m and m+1
matLenM=size(tmpltMatM,1);
allDistM=[]; % Matrix of all inter-vector distances at Emb.dim m
allDistM1=[]; % Matrix of all inter-vector distances at Emb.dim m+1

for i=1:matLenM
    tmpltVecM=tmpltMatM(i,:);
    tmpltMatMa=repmat(tmpltVecM,matLenM-1,1);
    tmpltMatMb=tmpltMatM;
    tmpltMatMb(i,:)=[];
    d= max(abs(tmpltMatMa-tmpltMatMb),[],2);
    d=round(d,3);
    allDistM=[allDistM d];
    
    tmpltVecM1=tmpltMatM1(i,:);
    tmpltMatM1a=repmat(tmpltVecM1,matLenM-1,1);
    tmpltMatM1b=tmpltMatM1;
    tmpltMatM1b(i,:)=[];
    d1=max(abs(tmpltMatM1a-tmpltMatM1b),[],2);
    d1=round(d1,3);
    allDistM1=[allDistM1 d1];
end

% Finding the unique set of distance values
% This is to calculate range and resolution of r-values to be generated for
% profiling

D=[allDistM(:); allDistM1(:)];
range= unique(D); % range of unique r-values

% Calculate the probabilities b and a at all r-values
% A cumulative probability distribution is generated for the purpose

allTmpltVectHistM=[];
allTmpltVectHistM1=[];

for i=1:matLenM   
allDistHistM=histc(allDistM(:,i),range);
allDistcumHistM=cumsum(allDistHistM);
allDistcumHistM_scaled=allDistcumHistM./(matLenM-1);

allTmpltVectHistM=[allTmpltVectHistM allDistcumHistM_scaled];

allDistHistM1=histc(allDistM1(:,i),range);
allDistcumHistM1=cumsum(allDistHistM1);
allDistcumHistM1_scaled=allDistcumHistM1./(matLenM-1);

allTmpltVectHistM1=[allTmpltVectHistM1 allDistcumHistM1_scaled];
end

allTmpltVectHistM_sum=sum(allTmpltVectHistM,2);
b=(allTmpltVectHistM_sum)./(matLenM);

allTmpltVectHistM1_sum=sum(allTmpltVectHistM1,2);
a=(allTmpltVectHistM1_sum)./matLenM;


