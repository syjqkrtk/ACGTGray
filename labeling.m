clear;

load('bacteria.mat');

temp6 = cell(1766,1);
label = cell(1766,1);
total = cell(1766,6);

for i = 1:1766
    if size(sequence{i,4},1) > 1
        temp6{i} = sequence{i,4}(2,:);
        for j = 3:size(sequence{i,4},1)
            temp6{i} = [temp6{i} sequence{i,4}(j,:)];
            temp4 = split(temp6{i},';');
        end
        for j = 1:length(temp4)
            label{i} = cell(min(length(temp4),6),1);
            for k = 1:min(length(temp4),6)
                temp5 = split(temp4{k});
                if length(temp5) > 1
                    if length(temp5{1}) > length(temp5{2})
                        temp7 = split(temp5{1},'.');
                    else
                        temp7 = split(temp5{2},'.');
                    end
                else
                    temp7 = temp5;
                end
                label{i}{k} = temp7{1};
            end
        end
    end
    
    if length(label{i}) == 5
        label{i}{6} = label{i}{5};
        label{i}{5} = label{i}{4};
        label{i}{4} = label{i}{3};
        label{i}{3} = '';
    end
    
    if length(label{i}) < 5
        label{i} = cell(6,1);
    end
    
    total{i,1} = label{i}{1};
    total{i,2} = label{i}{2};
    total{i,3} = label{i}{3};
    total{i,4} = label{i}{4};
    total{i,5} = label{i}{5};
    total{i,6} = label{i}{6};
    
end