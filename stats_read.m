# Created by Octave 4.4.1, Mon Apr 29 09:28:03 2019 GMT <unknown@cs252586>
% Universidade de Brasilia - UnB
% author: Mylene Farias, mylene@ieee.org
close all;
clear
% Directory where the files are
base_directory= '.\processed_head_movements\';

% Get list of all subfolders.
allSubFolders = genpath(base_directory);
% Parse into a cell array.
remain = allSubFolders;
listOfFolderNames = {};
while true
	[singleSubFolder, remain] = strtok(remain, ';');
	if isempty(singleSubFolder)
		break;
	end
	listOfFolderNames = [listOfFolderNames singleSubFolder];
end
numberOfFolders = length(listOfFolderNames)
videos = [3 : 2: numberOfFolders]
numberOfVideos = size(videos,2); % The number of folders is the number of videos


  % Matrices to save the data
  % captured yaw angle in [-180, 180] degrees
  yaw = [] ; % [numberOfFrames, numberOfSubjectsPerVideo,numberOfVideos]; 
	% captured pitch angle in [-180, 180] degrees
  pitch = [] ; %[numberOfFrames, numberOfSubjectsPerVideo,numberOfVideos]; 
  % captured roll angle in [-180, 180] degrees
	roll = [] ; %[numberOfFrames, numberOfSubjectsPerVideo,numberOfVideos]; 
  % Label of the subject that performed 
  subjects = [] ; % [1, numberOfSubjectsPerVideo,numberOfVideos]; 
  
% Going over all folders containing responses for each video
for V = videos
  
	% Get this folder and print it out. (each folder corresponds to 1 video)
	thisFolder = listOfFolderNames{V};
	fprintf('Processing folder %s\n', thisFolder);
  % Number of the video
  size_bd = size(base_directory); % size of the base directory
  tok = strtok(thisFolder(size_bd(1,2)+2:end), "_") 
  noVideo = str2num(tok);
  
	% Csv file pattern
	filePattern = strcat(thisFolder,"\\*.csv");
	baseFileNames = dir(filePattern);
  % NoOfSubjects that watched this k-th video
  numberOfSubjects = length(baseFileNames); 
	
	if numberOfSubjects >= 1
		% Go through all csv files.
		for S = 1 : numberOfSubjects
			fullFileName = fullfile(thisFolder, baseFileNames(S).name);
			fprintf('Processing image file %s\n', fullFileName);
      % read the file 
      headMovements= csvread(fullFileName);
      % Copy data into the
      [l,c] = size(headMovements(:,1));
      yaw(1:l, S, noVideo) = headMovements(:,1);
		  pitch(1:l, S, noVideo) = headMovements(:,2);
		  roll(1:l, S, noVideo) = headMovements(:,3);
      % Finding the number of the subject
      [tok] = strtok(baseFileNames(S).name, "_");
      subjects(1,S,noVideo) = str2num(tok);
		end
	else
		fprintf('     Folder %s has no image files in it.\n', thisFolder);
	end
end


	