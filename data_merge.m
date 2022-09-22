function [merge]=data_merge(filepath,channel,gesture)

namelist = dir(filepath);

len = length(namelist);
file_name={};
merge=[];
a=gesture;

for i=1:len

    file_name{i} = namelist(i).name;
    r = load(file_name{i});
    merge=[merge,r(:,channel)];
    
%     ch_r=[a;r(:,channel)];
%     merge=[merge,ch_r(:,channel)];

end

