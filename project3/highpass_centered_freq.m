function [output]=highpass_centered_freq(input,radius,filter_type)
%[output]=ideal_lowpass_centered_frequency(input,radius)
%input and output are fourier frequency components which have been centered for display
if strcmp(filter_type,'Ideal')
    height=size(input,1);
    width=size(input,2);
    distance=distance_from_center(height,width);
    filter= distance <= radius;
    output=input.*(1-filter);
elseif strcmp(filter_type,'Guassian')
    height=size(input,1);
    width=size(input,2);
    distance=distance_from_center(height,width);
    filter=exp(-1*(distance.^2)/(2*(radius.^2)));
    output=input.*(1-filter);
elseif strcmp(filter_type, 'Butterworth') 
    height=size(input,1);
    width=size(input,2);
    distance=distance_from_center(height,width);
    filter=1./(1+((distance./radius).^(2*order)));
    output=input.*(1-filter);
else 
    display('Filter type not found');
    output = input;
end