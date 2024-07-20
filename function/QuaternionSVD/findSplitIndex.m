function Index=findSplitIndex(S,threshold,flag)
%S is a real vector, flag can be 'larger' or 'smaller'. This function find
%the index larger or smaller than threshold.
if strcmp(flag,'larger')
Index=find(S>threshold);
elseif strcmp(flag,'smaller')
Index=find(S<threshold);
else
    error('Error Input, must be [larger] or [smaller]');
end
end
