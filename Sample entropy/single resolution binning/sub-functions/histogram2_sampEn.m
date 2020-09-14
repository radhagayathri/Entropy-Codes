function [b, a, nbins, bSize, distMax] = histogram2_sampEn(data,m)

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
    tmpltMatM=[tmpltMatM ts(i:N-(m+1)+i)];
end

tmpltMatM1=[];
for i=1:m+1
    tmpltMatM1=[tmpltMatM1 ts(i:N-(m+1)+i)];
end

matLenM=size(tmpltMatM,1);
allDistM=[];

for i=1:matLenM
    tmpltVecM=tmpltMatM(i,:);
    tmpltMatMa=repmat(tmpltVecM,matLenM-1,1);
    tmpltMatMb=tmpltMatM;
    tmpltMatMb(i,:)=[];
    d= max(abs(tmpltMatMa-tmpltMatMb),[],2);
    allDistM=[allDistM d];
end

matLenM1=size(tmpltMatM1,1);
allDistM1=[];

for i=1:matLenM1
    tmpltVecM1=tmpltMatM1(i,:);
    tmpltMatM1a=repmat(tmpltVecM1,matLenM1-1,1);
    tmpltMatM1b=tmpltMatM1;
    tmpltMatM1b(i,:)=[];
    d=max(abs(tmpltMatM1a-tmpltMatM1b),[],2);
    allDistM1=[allDistM1 d];
end

distMaxM=max(max(allDistM));
distMaxM1=max(max(allDistM1));
distMax=max(distMaxM,distMaxM1);


%For highest resolution
bSize=binSize_sampEn(allDistM,allDistM1);

range=0:bSize:distMax+bSize;
nbins=length(range);

allTmpltVectHistM=[];

for i=1:matLenM   
allDistHistM=histc(allDistM(:,i),range);
allDistcumHistM=cumsum(allDistHistM);
allDistcumHistM_scaled=allDistcumHistM./(matLenM-1);

allTmpltVectHistM=[allTmpltVectHistM allDistcumHistM_scaled];
end

allTmpltVectHistM_sum=sum(allTmpltVectHistM,2);
b=(allTmpltVectHistM_sum)./(matLenM);


allTmpltVectHistM1=[];
for i=1:matLenM1   
allDistHistM1=histc(allDistM1(:,i),range);
allDistcumHistM1=cumsum(allDistHistM1);
allDistcumHistM1_scaled=allDistcumHistM1./(matLenM1-1);

allTmpltVectHistM1=[allTmpltVectHistM1 allDistcumHistM1_scaled];

end

allTmpltVectHistM1_sum=sum(allTmpltVectHistM1,2);
a=(allTmpltVectHistM1_sum)./matLenM1;










