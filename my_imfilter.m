function output = my_imfilter(image, filter)
% This function is intended to behave like the built in function imfilter()
% See 'help imfilter' or 'help conv2'. While terms like "filtering" and
% "convolution" might be used interchangeably, and they are indeed nearly
% the same thing, there is a difference:
% from 'help filter2'
%    2-D correlation is related to 2-D convolution by a 180 degree rotation
%    of the filter matrix.

% Your function should work for color images. Simply filter each color
% channel independently.

% Your function should work for filters of any width and height
% combination, as long as the width and height are odd (e.g. 1, 7, 9). This
% restriction makes it unambigious which pixel in the filter is the center
% pixel.

% Boundary handling can be tricky. The filter can't be centered on pixels
% at the image boundary without parts of the filter being out of bounds. If
% you look at 'help conv2' and 'help imfilter' you see that they have
% several options to deal with boundaries. You should simply recreate the
% default behavior of imfilter -- pad the input image with zeros, and
% return a filtered image which matches the input resolution. A better
% approach is to mirror the image content over the boundaries for padding.

% % Uncomment if you want to simply call imfilter so you can see the desired
% % behavior. When you write your actual solution, you can't use imfilter,
% % filter2, conv2, etc. Simply loop over all the pixels and do the actual
% % computation. It might be slow.
% output = imfilter(image, filter);


%%%%%%%%%%%%%%%%
% Your code here
%%%%%%%%%%%%%%%%  
  % Pad the image with 0's. 
  % The size of the padding should be half the filter size minus 1, or can use floor function
  [filterSizeRow, filterSizeCol] = size(filter);
  paddingRow = floor(filterSizeRow/2);
  paddingCol = floor(filterSizeCol/2);
  
  [imgR, imgC, chan] = size(image);
  
  % pad the image symmetrically which mirrors the border pixels in the image
  imagePad = padarray(image, [paddingRow,paddingCol],'symmetric');
 
  output = zeros(imgR, imgC, chan);
  
  % perform convolution 
  for c=1:chan
    for i=1:imgR
      for j=1:imgC
        % create a window, size of filter, and needs to shift across
        % pixels, so increment by i and j
        window = imagePad(i:i+filterSizeRow-1, j:j+filterSizeCol-1,c);
        
        % do convolution
        window = window .* filter;
        
        % Sum of the new filter calculation
        output(i,j,c) = sum(sum(window(:)));
      end
    end
  end






