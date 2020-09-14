function [b, a, nbins, bSize, distMax] = histogram2_apEn(data,m)

[row,col]=size(data);
if row==1
    data=data';
    N=col;
else
    N=row;
end

ts=data;

tmpltMatM=[];
for i=1:m
    tmpltMatM=[tmpltMatM ts(i:N-m+i)];
end

tmpltMatM1=[];
for i=1:m+1
    tmpltMatM1=[tmpltMatM1 ts(i:N-(m+1)+i)];
end

matLenM=size(tmpltMatM,1);
allDistM=[];

for i=1:matLenM
    tmpltVecM=tmpltMatM(i,:);
    tmpltMat1=repmat(tmpltVecM,matLenM,1);
    d= max(abs(tmpltMat1-tmpltMatM),[],2);
    allDistM=[allDistM d];
end

matLenM1=size(tmpltMatM1,1);
allDistM1=[];

for i=1:matLenM1
    tmpltVecM1=tmpltMatM1(i,:);
    tmpltMat2=repmat(tmpltVecM1,matLenM1,1);
    d=max(abs(tmpltMat2-tmpltMatM1),[],2);
    allDistM1=[allDistM1 d];
end

distMaxM=max(max(allDistM));
distMaxM1=max(max(allDistM1));
distMax=max(distMaxM,distMaxM1);


%For highest resolution
bSize=binSize_apEn(allDistM,allDistM1);

range=0:bSize:distMax+bSize;
nbins=length(range);

allTmpltVectHistM=[];

for i=1:matLenM   
allDistHistM=histc(allDistM(:,i),range);
allDistcumHistM=cumsum(allDistHistM);
allDistcumHistM_scaled=allDistcumHistM./matLenM;
%allTmpltVectHistM=[allTmpltVectHistM allDistcumHistM_scaled];

allDistcumHistM_scaled_loga=log(allDistcumHistM_scaled);

allTmpltVectHistM=[allTmpltVectHistM allDistcumHistM_scaled_loga];
end

allTmpltVectHistM_sum=sum(allTmpltVectHistM,2);
b=(allTmpltVectHistM_sum)./matLenM;


allTmpltVectHistM1=[];
for i=1:matLenM1   
allDistHistM1=histc(allDistM1(:,i),range);
allDistcumHistM1=cumsum(allDistHistM1);
allDistcumHistM1_scaled=allDistcumHistM1./matLenM1;
%allTmpltVectHistM1=[allTmpltVectHistM1 allDistcumHistM1_scaled];

allDistcumHistM1_scaled_loga=log(allDistcumHistM1_scaled);

allTmpltVectHistM1=[allTmpltVectHistM1 allDistcumHistM1_scaled_loga];

end

allTmpltVectHistM1_sum=sum(allTmpltVectHistM1,2);
a=(allTmpltVectHistM1_sum)./matLenM1;










