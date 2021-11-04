kGray = cell(5,1);
ACGT = cell(5,1);

kGray{1,1} = [0 1; 3 2];
ACGT{1,1} = {'A' 'T'; 'G' 'C'};

for k = 2:5
    
    len = 2^k;
    for i = 1:len/2
        for j = 1:len/2
            kGray{k,1}(i,j) = kGray{k-1,1}(i,j);
            kGray{k,1}(len+1-i,j) = kGray{k-1,1}(i,j) + 3*4^(k-1);
            kGray{k,1}(i,len+1-j) = kGray{k-1,1}(i,j) + 4^(k-1);
            kGray{k,1}(len+1-i,len+1-j) = kGray{k-1,1}(i,j) + 2*4^(k-1);
        end
    end

    order = kGray{k};
    result = reshape(dec2base(reshape(order, [len,len]),4)-'0',[len,len,k]);
    temp = char(('A'*(result==0))+('T'*(result==1))+('C'*(result==2))+('G'*(result==3)));
    ACGT{k} = num2cell(temp,3);

end