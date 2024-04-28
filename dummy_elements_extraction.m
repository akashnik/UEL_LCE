clear all
fileID=fopen('fine_pattern.inp');
elines=9;
nodes=10201;
Nelements=10010;
Nelem=10000;
count=0;
H=[];
AA=[];
while count<elines
tline1 = fgetl(fileID);
count=count+1;
end

%%
while count<elines+nodes
tline1 = fgetl(fileID);
h=split(tline1,",")';
H=[H;h];
count=count+1;
end
tline1=fgetl(fileID);
while count<nodes+Nelements-1
tline1 = fgetl(fileID);
a= split(tline1,",")';
AA=[AA;a];
count=count+1;
end
fclose(fileID);
%A=zeros(nodes,3);
%for i=1:nodes
    %for j=1:3
       % A(i,j)=str2num(H{i,j});
   % end 
%end

C=zeros(Nelem,5);
for i=1:Nelem
    for j=1:5
        C(i,j)=str2num(AA{i,j});
    end 
end
jj=0;
fileID = fopen('elements_pattern_2.txt','w');
for i=1:Nelem
fprintf(fileID,'%d,%d,%d,%d,%d\n',Nelem+C(i,1),C(i,2),C(i,3),C(i,4),C(i,5));
jj=jj+1
end
fclose(fileID);