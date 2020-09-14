function [Bsize] = binSize_sampEn(allDistM,allDistM1)

allDistM_asVector = allDistM(:);
allDistM_ascOrder = sort(allDistM_asVector);
lenM=length(allDistM_ascOrder);

allDistM1_asVector = allDistM1(:);
allDistM1_ascOrder = sort(allDistM1_asVector);
lenM1=length(allDistM1_ascOrder);
diffVectorM = [];
diffVectorM1 = [];

for i=1:(lenM-1)
    diffM = allDistM_ascOrder(i+1)-allDistM_ascOrder(i);
    diffM_rounded=roundn(diffM,-3);
    if diffM_rounded~=0
        diffVectorM=[diffVectorM diffM];
    end   
end

for i=1:(lenM1-1)
    diffM1 = allDistM1_ascOrder(i+1)-allDistM1_ascOrder(i);
    diffM1_rounded=roundn(diffM1,-3);
    if diffM1_rounded~=0
        diffVectorM1=[diffVectorM1 diffM1];
    end   
end

diffVector=[diffVectorM diffVectorM1];
flag=isempty(diffVector);

if  flag == 0
Bsize=min(diffVector);

else
    
for j=1:length(allDistM_ascOrder)
    if allDistM_ascOrder(j)~=0
        diffVectorM=allDistM_ascOrder(j);
        break;
    end
end

for j=1:length(allDistM1_ascOrder)
    if allDistM1_ascOrder(j)~=0
        diffVectorM1=allDistM1_ascOrder(j);
        break;
    end
end
    
diffVector=[diffVectorM diffVectorM1];
Bsize=min(diffVector);
end