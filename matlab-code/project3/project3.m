function project3(varargin);
global current_image
global preview_image
global open_button
global save_button
global preview_button
global apply_button
global ffilter_popup
global ffilter_title
global sfilter_popup
global sfilter_title
global bright_slider
global bright_title
global bright_value
global contrast_slider
global contrast_title
global contrast_value
global ftype
global filter_type
global filter_type_title
global radius_slider
global radius_title
global radius_value
global FIG
global FIG2
global FIG3
function_name='project3';
if nargin<1,
    action='initialize';
else
    action=varargin{1};
end;

if strcmp(action,'initialize'),
    figNumber=figure( ...
        'Name','Project 3', ...
        'NumberTitle','off', ...
        'Position',[100 100 800 600], ...
        'Visible','off');
     colordef(figNumber,'white')
     current_image = axes('Position',[0.05 0.55 0.60 0.426667]);
     title('Current');
     preview_image =axes('Position',[0.05 0.05 0.60 0.426667]);
     title('Previous');  
%====================================
    % Information for all buttons
    top=0.95;
    left=0.81;
    btnWid=0.15;
    btnHt=0.06;
    % Spacing between the button and the next command's label
    spacing=0.03*0.75;
%====================================
    % The OPEN IMAGE button
    btnNumber=1;
    yPos=top-(btnNumber-1)*(btnHt+spacing);
    labelStr='Open Image';
    callbackStr=strcat(function_name,'(''open'')');  
    % Generic button information
    btnPos=[left yPos-btnHt+0.03 btnWid btnHt-0.0001];
    open_button = uicontrol( ...
        'Style','pushbutton', ...
        'Units','normalized', ...
        'Position',btnPos, ...
        'String',labelStr, ...
        'Callback',callbackStr);
%====================================
    % The SAVE_IMAGE button
    btnNumber=2;
    yPos=top-(btnNumber-1)*(btnHt+spacing);
    labelStr='Save Image';
    callbackStr=strcat(function_name,'(''save'')');
     % Generic button information
    btnPos=[left yPos-btnHt+0.03 btnWid btnHt-0.0001];
    save_button = uicontrol( ...
        'Style','pushbutton', ...
        'Units','normalized', ...
        'Position',btnPos, ...
        'String',labelStr, ...
        'Callback',callbackStr);
%====================================
    % The Apply Changes Button
    btnNumber = 3;
    yPos= top-(btnNumber-1)*(btnHt+spacing);
    labelStr='Apply Changes';
    callbackStr=strcat(function_name,'(''apply'')');
    btnPos = [left yPos-btnHt+0.03 btnWid btnHt-0.0001];
    apply_button = uicontrol(...
        'Style', 'pushbutton', ...
        'Units', 'normalized',...
        'Position', btnPos, ...
        'String', labelStr,...
        'Callback', callbackStr);
    
%====================================
    % The Preview Button
    btnNumber = 4;
    yPos= top-(btnNumber-1)*(btnHt+spacing);
    labelStr='Preview';
    callbackStr=strcat(function_name,'(''preview'')');
    btnPos = [left yPos-btnHt+0.03 btnWid btnHt-0.0001];
    preview_button = uicontrol(...
        'Style', 'pushbutton', ...
        'Units', 'normalized',...
        'Position', btnPos, ...
        'String', labelStr,...
        'Callback', callbackStr);

%====================================
    % The spatial Filter Popup
    btnNumber= 5;
    yPos=top-(btnNumber-1)*(btnHt+spacing);
    labelStr= {'3x3 Low Pass','5x5 Low Pass','7x7 Low Pass','9x9 Low Pass'...
               'HighPass','HighBoost','Histogram equalization'};
    callbackStr=strcat(function_name,'(''sfilter'')');
     % Generic Popup information
    btnPos=[left yPos-btnHt+0.005 btnWid btnHt];
    sfilter_popup = uicontrol( ...
        'Style','popupmenu', ...
        'Units','normalized', ...
        'Position',btnPos, ...
        'String',labelStr, ...
        'Callback',callbackStr);
   sfilter_title = uicontrol(...
        'Style','text',...
        'Units','normalized', ...
        'Position',[left (yPos-btnHt+0.065) btnWid btnHt-0.02],...
        'String','Spatial Filters');

%====================================
    % The Bright slider
    btnNumber=6;
    yPos=top-(btnNumber-1)*(btnHt+spacing);
    callbackStr = strcat(function_name,'(''bright'')');
     % Generic button information
    btnPos=[left (yPos-btnHt) btnWid btnHt];
    bright_slider = uicontrol( ...
        'Style','slider', ...
        'Units','normalized', ...
        'Position',btnPos, ...
        'Min', 0 ,...
        'Max', 255 ,...
        'Value', 130 ,...
        'Callback',callbackStr);
    bright_value = floor(get(bright_slider,'Value'));
    % Add a text uicontrol to label the slider.
    bright_title = uicontrol(...
        'Style','text',...
        'Units','normalized', ...
        'Position',[left (yPos-btnHt+.08) btnWid btnHt-0.04],...
        'String','Brightness');

%====================================
    % The Contrast slider
    btnNumber=7;
    yPos=top-(btnNumber-1)*(btnHt+spacing);
    callbackStr = strcat(function_name,'(''contrast'')');
     % Generic button information
    btnPos=[left yPos-btnHt btnWid btnHt];
    contrast_slider = uicontrol( ...
        'Style','slider', ...
        'Units','normalized', ...
        'Position',btnPos, ...
        'Min', 0 ,...
        'Max', 255 ,...
        'Value', 130,...
        'Callback',callbackStr);
    contrast_value = floor(get(contrast_slider,'Value'));
    % Add a text uicontrol to label the slider.
    contrast_title = uicontrol(...
        'Style','text',...
        'Units','normalized', ...
        'Position',[left (yPos-btnHt+.08) btnWid btnHt-0.04],...
        'String','Contrast');
%====================================
    % The filter type Popup
    btnNumber= 8;
    yPos=top-(btnNumber-1)*(btnHt+spacing);
    labelStr= {'Ideal','Gaussian','Butterworth'};
    callbackStr=strcat(function_name,'(''ftype'')');
     % Generic Popup information
    btnPos=[left yPos-btnHt-0.01 btnWid btnHt+0.02];
    ftype = uicontrol( ...
        'Style','popupmenu', ...
        'Units','normalized', ...
        'Position',btnPos, ...
        'String',labelStr, ...
        'Callback',callbackStr);
        % Add a text uicontrol to label the slider.
    filter_type_title = uicontrol(...
        'Style','text',...
        'Units','normalized', ...
        'Position',[left (yPos-btnHt+0.065) btnWid btnHt-0.02],...
        'String','Filter Types');
    
%====================================
    % The Radius slider
    btnNumber=9;
    yPos=top-(btnNumber-1)*(btnHt+spacing);
    callbackStr = strcat(function_name,'(''radius'')');
     % Generic button information
    btnPos=[left yPos-btnHt btnWid btnHt];
    radius_slider = uicontrol( ...
        'Style','slider', ...
        'Units','normalized', ...
        'Position',btnPos, ...
        'Min', 0 ,...
        'Max', 100 ,...
        'Value', 10,...
        'Callback',callbackStr);
    radius_value = floor(get(radius_slider,'Value'));
    % Add a text uicontrol to label the slider.
    radius_title = uicontrol(...
        'Style','text',...
        'Units','normalized', ...
        'Position',[left (yPos-btnHt+.08) btnWid btnHt-0.04],...
        'String','Cutoff Frequency radius');

%====================================
    % The Frequencey Filter Popup
    btnNumber= 10;
    yPos=top-(btnNumber-1)*(btnHt+spacing);
    labelStr= {'Freq Low Pass', 'Freq High Pass', 'Freq HighBoost'...
               'Freq Band-Pass', 'Freq Band-Stop','Homomophoric'};
    callbackStr=strcat(function_name,'(''ffilter'')');
     % Generic Popup information
    btnPos=[left yPos-btnHt+0.02 btnWid btnHt-0.02];
    ffilter_popup = uicontrol( ...
        'Style','popupmenu', ...
        'Units','normalized', ...
        'Position',btnPos, ...
        'String',labelStr, ...
        'Callback',callbackStr);
    % Add a text uicontrol to label the slider.
    ffilter_title = uicontrol(...
        'Style','text',...
        'Units','normalized', ...
        'Position',[left (yPos-btnHt+0.06) btnWid btnHt-0.02],...
        'String','Frequency Filters');
    % Now uncover the figure
    set(figNumber,'Visible','on');
    
elseif strcmp(action,'save'),
    save_image(FIG);
elseif strcmp(action,'open'),
    axes(current_image);
    FIG=open_image();
    fig_size=size(FIG);
    if (max(size(fig_size >= 4)))
        FIG=FIG(:,:,:,1);
    end;
    fig_size=size(FIG);
    if (max(size(fig_size) >= 3))
        FIG=rgb2ycbcr(FIG);
    end
    fig_size=size(FIG);
    if (max(size(fig_size) == 2))
        temp=FIG(:,:,1);
        FIG=temp;
    end
    imshow(ycbcr2rgb(FIG));
    title('Current Image')
    FIG2 = FIG;
    axes(preview_image)
    imshow(ycbcr2rgb(FIG2));
    title('Preview Image')
elseif strcmp(action,'preview'),
    axes(preview_image);
    imshow(ycbcr2rgb(FIG2));
    title('Preview Image');
elseif strcmp(action,'apply'),
    axes(current_image);
    FIG = FIG2;
    imshow(ycbcr2rgb(FIG));
    title('Current Image');
elseif strcmp(action,'bright')
    bright_value = floor(get(bright_slider,'Value'));
    difference = mean2(FIG) - bright_value;
    if (difference < 0)
        FIG2(:,:,1) = FIG(:,:,1) + -1*difference;
    else
        FIG2(:,:,1) = FIG(:,:,1) - difference;
    end
elseif strcmp(action,'contrast')
    contrast_value = floor(get(contrast_slider,'Value'));
    contrast = contrast_value/255;
    if (contrast >= 0.5)
        FIG2(:,:,1) = imadjust(FIG(:,:,1),[0 contrast],[0, 1]); 
    end
    if (contrast < 0.5)
        FIG2(:,:,1) = imadjust(FIG(:,:,1),[contrast 1],[0, 1]); 
    end
elseif strcmp(action,'sfilter')
    value = get(sfilter_popup,'Value');
    string_list = get(sfilter_popup,'String');
    popup_string = string_list{value};
    if strcmp(popup_string,  '3x3 Low Pass')
        FIG2(:,:,1) = imfilter(FIG(:,:,1), ones(3,3)/9);
    elseif strcmp(popup_string,'5x5 Low Pass')
        FIG2(:,:,1) = imfilter(FIG(:,:,1) ,ones(5,5)/25);
    elseif strcmp(popup_string, '7x7 Low Pass')
        FIG2(:,:,1) = imfilter(FIG(:,:,1),ones(7,7)/49);
    elseif strcmp(popup_string, '9x9 Low Pass')
        FIG2(:,:,1) = imfilter(FIG(:,:,1),ones(9,9)/81);        
    elseif strcmp(popup_string, 'HighPass')
        filterhp = [-1,-1,-1;-1,8,-1;-1,-1,-1];
        FIG2(:,:,1) = imfilter(FIG(:,:,1),filterhp);
    elseif strcmp(popup_string,'HighBoost')
        FIG3(:,:,1)=imfilter(imsubtract(FIG(:,:,1),25),[-1 -1 -1;-1 8 -1;-1 -1 -1]);
        FIG2(:,:,1) = imadd(FIG(:,:,1), FIG3(:,:,1))
    elseif strcmp(popup_string, 'Histogram equalization')
        FIG2(:,:,1) = histeq(FIG(:,:,1))
    end
        
elseif strcmp(action,'ffilter')
    value = get(ffilter_popup,'Value');
    string_list = get(ffilter_popup,'String');
    popup_string = string_list{value};
    if strcmp(popup_string,'Homomophoric')
%         display('here')
%         picture = im2double(FIG(:,:,1));
%         picture = log(1 + picture);
%         M = 2*size(picture,1) + 1;
%         N = 2*size(picture,2) + 1;
%         sigma = 10;
%         [X, Y] = meshgrid(1:N,1:M);
%         centerX = ceil(N/2);
%         centerY = ceil(M/2);
%         gaussianNumerator = (X - centerX).^2 + (Y - centerY).^2;
%         H = exp(-gaussianNumerator./(2*sigma.^2));
%         H = 1 - H;
%         H = fftshift(H);
%         freq = fft2(picture, M, N);
%         image = real(ifft2(H.*freq));
%         image = image(1:size(picture,1),1:size(picture,2));
%         Ihmf = exp(image) - 1;
%         FIG2(:,:,1) = Ihmf;
        FIG2(:,:,1) = homomorphic(FIG(:,:,1),radius_value);
    else
        picture = FIG(:,:,1);
        [height, width]=size(picture);
        picture2 =zeros(height,width);
        for x=1:height
           for y=1:width
              picture2(x,y)=picture(x,y)*((-1)^(x+y));
           end
        end
        freq = fft2(picture2);
        if strcmp(popup_string,  'Freq Low Pass')
            freq2 = lowpass_centered_freq(freq,radius_value, filter_type);
            recovered = abs(real(ifft2(freq2)));
            FIG2(:,:,1) = recovered;
        elseif strcmp(popup_string, 'Freq High Pass')
            freq2 = highpass_centered_freq(freq,radius_value, filter_type);
            recovered = abs(real(ifft2(freq2)));
            FIG2(:,:,1) = recovered;
        elseif strcmp(popup_string, 'Freq HighBoost')
            freq2 = highboost_centered_freq(freq,radius_value, filter_type);
            recovered = abs(real(ifft2(freq2)));
            FIG2(:,:,1) = recovered;
        elseif strcmp(popup_string, 'Freq Band-Pass')
            freq2 = bandpass_centered_freq(freq,radius_value, filter_type);
            recovered = abs(real(ifft2(freq2)));
            FIG2(:,:,1) = recovered;
        elseif strcmp(popup_string, 'Freq Band-Stop')
            freq2 = bandstop_centered_freq(freq,radius_value, filter_type);
            recovered = abs(real(ifft2(freq2)));
            FIG2(:,:,1) = recovered;
        end
    end
    
elseif strcmp(action,'ftype')
    value = get(ftype,'Value');
    string_list = get(ftype,'String');
    filter_type = string_list{value};

elseif strcmp(action,'radius')
    radius_value = get(radius_slider,'Value')


end;