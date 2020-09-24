% Function to implement Cumulative Histogram Method for entropy profiling
function [b,a,range] = CHMforApEn(data,m)

% data is the input time-series;
% m is the embedding dimension (Emb.dim);
% b, a and range are the output parameters;
% ApEn(r)=(logarithmic probability of matches at Emb.dim m)-(logarithmic probability of matches at
% Emb.dim m+1);
% Representing the difference as b-a, we write ApEn(r)=b-a; 
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
    tmpltMatM=[tmpltMatM ts(i:N-m+i)];
end

% Finding template vectors at Emb.dim m+1
tmpltMatM1=[];
for i=1:m+1
    tmpltMatM1=[tmpltMatM1 ts(i:N-(m+1)+i)];
end

% Finding vector-vectors distances at Emb.dim m 
matLenM=size(tmpltMatM,1);
allDistM=[];
for i=1:matLenM
    tmpltVecM=tmpltMatM(i,:);
    tmpltMat1=repmat(tmpltVecM,matLenM,1);
    d= max(abs(tmpltMat1-tmpltMatM),[],2);
    allDistM=[allDistM d]; % Matrix of all inter-vector distances at Emb.dim m
end

% Finding vector-vectors distances at Emb.dim m+1 
matLenM1=size(tmpltMatM1,1);
allDistM1=[];
for i=1:matLenM1
    tmpltVecM1=tmpltMatM1(i,:);
    tmpltMat2=repmat(tmpltVecM1,matLenM1,1);
    d=max(abs(tmpltMat2-tmpltMatM1),[],2);
    allDistM1=[allDistM1 d]; % Matrix of all inter-vector distances at Emb.dim m+1
end

% Finding the unique set of distance values
% Calculate range and resolution of r-values to be generated for profiling
D=[allDistM(:); allDistM1(:)];
range= unique(D); % range of unique r-values

% Calculate the probabilities b and a at all r-values
% A cumulative probability distribution is generated for the purpose

allTmpltVectHistM=[];
for i=1:matLenM   
allDistHistM=histc(allDistM(:,i),range);
allDistcumHistM=cumsum(allDistHistM);
allDistcumHistM_scaled=allDistcumHistM./matLenM;
allDistcumHistM_scaled_loga=log(allDistcumHistM_scaled);
allTmpltVectHistM=[allTmpltVectHistM allDistcumHistM_scaled_loga];
end

allTmpltVectHistM_sum=sum(allTmpltVectHistM,2);
b=(allTmpltVectHistM_sum)./matLenM; % logarithmic probability at Emb.dim m


allTmpltVectHistM1=[];
for i=1:matLenM1   
allDistHistM1=histc(allDistM1(:,i),range);
allDistcumHistM1=cumsum(allDistHistM1);
allDistcumHistM1_scaled=allDistcumHistM1./matLenM1;
allDistcumHistM1_scaled_loga=log(allDistcumHistM1_scaled);
allTmpltVectHistM1=[allTmpltVectHistM1 allDistcumHistM1_scaled_loga];
end

allTmpltVectHistM1_sum=sum(allTmpltVectHistM1,2);
a=(allTmpltVectHistM1_sum)./matLenM1; % logarithmic probability at Emb.dim m+1


