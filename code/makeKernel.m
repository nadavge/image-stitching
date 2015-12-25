function [ kernel ] = makeKernel( size )
%MAKEKERNEL Generate a gaussian kernel (2D) of given size (odd size)
%   Estimate the kernel using binomial coefficents
    
    if mod(size,2)==0,
        kernel = -1;
        return
    end
    
    kernel = 1;
    
    for i=3:2:size,
       kernel = conv([1 1], kernel); 
       kernel = conv([1 1], kernel); 
    end
    
    kernel = kernel' * kernel;
    kernel = kernel/sum(kernel(:));
end

