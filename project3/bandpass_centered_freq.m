function [output]= bandpass_centered_freq(input,radius,filter_type)
%[output]=ideal_lowpass_centered_frequency(input,radius)
%input and output are fourier frequency components which have been centered for display
if strcmp(filter_type,'Ideal')
    height=size(input,1);
    width=size(input,2);
    distance=distance_from_center(height,width);
    inner=-1*radius;
    outer=radius;
    filter= (distance <= inner) || (distance >= outer);
    output=input.*(filter);
elseif strcmp(filter_type,'Guassian')
    height=size(input,1);
    width=size(input,2);
    distance=distance_from_center(height,width);
    inner=-1*radius;
    outer=radius;
    filter=(1-exp(-1*(distance.^2)/(2*(inner.^2))))* exp(-1*(distance.^2)/(2*(outer.^2)));
    output=input.*(filter);
elseif strcmp(filter_type, 'Butterworth') 
    height=size(input,1);
    width=size(input,2);
    distance=distance_from_center(height,width);
    inner=-1*radius;
    outer=radius;
    filter=1./((1+((inner ./ distance).^(2*order))) * (1+((distance./outer).^(2*order))));
    output=input.*(filter);
else 
    display('Filter type not found');
    output = input;
end

