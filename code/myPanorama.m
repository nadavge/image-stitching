%
% This script generates two example panorama images found online
%

verbose = true;
warning('OFF','images:initSize:adjustingMag');
tic;
numFrames = 2;
inpPathFormat = '../data/inp/mine/church%d.jpg';
 outPath = '../data/out/mine/church.jpg';
renderAtFrame = ceil(numFrames/2);
generatePanorama(inpPathFormat,outPath,numFrames,renderAtFrame,verbose);
toc;
pause(2);
close all;
tic;
numFrames = 3;
inpPathFormat = '../data/inp/mine/building%d.jpg';
outPath = '../data/out/mine/building.jpg';
renderAtFrame = ceil(numFrames/2);
generatePanorama(inpPathFormat,outPath,numFrames,renderAtFrame,verbose);
toc;
pause(2);
close all;

warning('ON','images:initSize:adjustingMag');
