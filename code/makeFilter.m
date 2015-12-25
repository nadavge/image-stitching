function [ filter ] = makeFilter( size )
%MAKEKERNEL Generate a gaussian filter (1D) of given size (odd size)
%   Estimate the filter using binomial coefficents
    
    filter = 1;
    
    for i=3:2:size,
       filter = conv([1 1], filter);
       filter = conv([1 1], filter);
    end
    
    filter = filter/sum(filter);

end

