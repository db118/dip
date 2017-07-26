function project2(varargin);
global current_image
global preview_image
global open_button
global save_button
global preview_button
global apply_button
global filter_popup
global bright_slider
global bright_title
global bright_value
global contrast_slider
global contrast_title
global contrast_value
global orig_bright
global orig_contrast
global FIG
global FIG2
global FIG3
function_name='project2';
if nargin<1,
    action='initialize';
else
    action=varargin{1};
end;

if strcmp(action,'initialize'),
    figNumber=figure( ...
        'Name','Project 2', ...
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
    spacing=0.03*0.5;
%====================================
    % The OPEN IMAGE button
    btnNumber=1;
    yPos=top-(btnNumber-1)*(btnHt+spacing);
    labelStr='Open Image';
    callbackStr=strcat(function_name,'(''open'')');  
    % Generic button information
    btnPos=[left yPos-btnHt btnWid btnHt];
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
    btnPos=[left yPos-btnHt btnWid btnHt];
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
    btnPos = [left yPos-btnHt btnWid btnHt];
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
    btnPos = [left yPos-btnHt btnWid btnHt];
    preview_button = uicontrol(...
        'Style', 'pushbutton', ...
        'Units', 'normalized',...
        'Position', btnPos, ...
        'String', labelStr,...
        'Callback', callbackStr);

%====================================
    % The Filter Popup
    btnNumber= 5;
    yPos=top-(btnNumber-1)*(btnHt+spacing);
    labelStr= {'3x3 Low Pass','5x5 Low Pass','7x7 Low Pass','9x9 Low Pass'...
               'HighPass','HighBoost','Histogram equalization'};
    callbackStr=strcat(function_name,'(''filter'')');
     % Generic Popup information
    btnPos=[left yPos-btnHt btnWid btnHt];
    filter_popup = uicontrol( ...
        'Style','popupmenu', ...
        'Units','normalized', ...
        'Position',btnPos, ...
        'String',labelStr, ...
        'Callback',callbackStr);

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
elseif strcmp(action,'filter')
    value = get(filter_popup,'Value');
    string_list = get(filter_popup,'String');
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
    
end;