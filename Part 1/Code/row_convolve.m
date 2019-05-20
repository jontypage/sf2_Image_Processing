function output = row_convolve(image, filter)
convolution = [];
for i=1:size(image, 1)
    addition = conv(image(i, :), filter);
    convolution = [convolution;addition];
end
output = convolution;