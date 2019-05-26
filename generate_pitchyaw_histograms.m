% script to plot histograms 
% Load head_tracking.mat
% Read each category into a vectorize
close all
font_size_1 =30;
font_size_2 =14;

for i = 1:6, % loop trough categories
  % Read pitch for the ith category
  temp = pitch(:,:,1+(i-1)*3: (1+(i-1)*3)+2);
  cat_pitch = temp(:); 
  % Read yaw for the ith category
  temp = yaw(:,:,1+(i-1)*3: (1+(i-1)*3)+2);
  cat_yaw = temp(:); 
  % Plot Pitch
  h1 = figure(1); grid on;
  %get axes handle to use for setting properties
  h=get (gcf, "currentaxes");
  set(h,"fontweight","bold","linewidth",2, 'fontsize', font_size_1)
 
  % Histogram pitch
  hist(cat_pitch, [-90: 10: 90], 1);
  %title(' ');
  xlabel('Pitch Angles (degree)', "fontsize", font_size_2, "fontweight","bold");
  %ylabel('frequency count', "fontsize", font_size_2);
  filename =sprintf('pitch_cat%d.png',i);
  print(h1,'-dpng','-color',filename);
  
  % Plot Yaw
  h2 = figure(2); grid on;
  set(gca,'linewidth',1.5, 'fontsize', font_size_1);
  % Histogram  
  hist(cat_yaw, [-180: 30: 180], 1);
  %title(' ');
  xlabel('Yaw Angles (degree)', "fontsize", font_size_2);
  %ylabel('frequency count', "fontsize", font_size_2);
  % save the image
  filename =sprintf('yaw_cat%d.png',i);
  print(h2,'-dpng','-color',filename);
endfor

  %set(gca,'fontsize', 20);
  %set(gca,'fontsize', 15);  
