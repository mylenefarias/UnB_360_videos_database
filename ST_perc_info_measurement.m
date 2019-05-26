
function [SI, TI] = ST_perc_info_measurement(video_name, summary_type)
% compute spatial and temporal perceptual information measurement according
% to either [1] or [2]
%
% inputs:
% VIDEO_NAME is the name of the (avi) file
% SUMMARY_TYPE is either 'max' or 'Q3' 
%      - 'max' computes TI and SI according to [1]"
%           SI = max(stdev(sobel(f_n)),  n = 1, ..., nFrames
%           TI = max(stdev((f_n - f_n-1)),  n = 1, ..., nFrames
%           being f_n the current frame, nFrames the total no. of
%           frames in the video
%      - 'Q3' computes TI and SI according to [2], i.e. taking the 3rd
%           quartile instead of the max of the distribution
%           SI = 75th_percentile(stdev(sobel(f_n)),  n = 1, ..., nFrames
%           TI = 75th_percentile(stdev((f_n - f_n-1)),  n = 1, ..., nFrames
% 
% References:
% [1] International Telecommunication Union, “Subjective video quality 
% assessment methods for multimedia applications,”Rec. P.910, ITU-T (1999).
% [2] A. Ostaszewska and R. Kloda, “Quantifying the amount of spatial and
% temporal information in video test sequences,” in Recent Advances in 
% Mechatronics. Berlin/Heidelberg: Springer, 2007, pp. 11–15.



% create an mmreader object
videoObject = mmreader(video_name);
nframes = videoObject.NumberOfFrames;

SI_allframes = zeros(1,nframes);
TI_allframes = zeros(1,nframes -1);

for i = 1:nframes
    %Read frames from input video
    imageData = read( videoObject, i );
    % convert the data to grayscale
    im_in = rgb2gray( imageData );

%     im_in = rgb2gray(frame2im(mov_in));
    S_info = edge(im_in, 'sobel');
    SI_allframes (1,i) = std2(S_info);
    
    if (i>1)
        T_info = im_in - im_in_prev;
        TI_allframes (1,i-1) = std2(T_info);
    end
    im_in_prev = im_in;
end

if strcmp(summary_type,'max')
    SI = max(SI_allframes);
    TI = max(TI_allframes);
else %third quartile
    SI = prctile(SI_allframes, 75);
    TI = prctile(TI_allframes, 75); 
end

return;