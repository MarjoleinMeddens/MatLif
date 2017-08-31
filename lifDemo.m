% DEMO FILE FOR LIF CLASS

% make sure to have the bioformats matlab toolbox installed
% get it from http://downloads.openmicroscopy.org/bio-formats/5.1.3/
% you might get a warning about java memory
% increase this by going to matlab preferences -> General -> Java Heap Memory

% the class and all methods have help info
help lif
help lif.loadSeries

% specify location of lif file
fileDir = 'Y:\Marjolein\15-06-25_ICS_RBL_SP8'; % directory of lif file
fileName = 'RBL_YFsyk-mNG_IgE-647001.lif'; % name of lif file

% create lif object
lifObj = lif(fileDir,fileName) % ignore the 'unknown bla bla' outputs

% look at names and sizes of all series stored in lif file
lifObj.SeriesName
lifObj.SeriesSize % [x y z t c]

% load first series
seriesIdx = 10; % index ( order as in lifObj.SeriesName) of series to be loaded
[sequence,metadata] = lifObj.loadSeries(seriesIdx);
% OUTPUT:
% sequence:     5D [x y z t c]
% metadata:     structure with some metadata fields populated 
%               PxSz units are um
%               Time units are sec
%               all other metadata is dumped in omeMetaData and leicaMetaData fields
%               let me know if you want more metadata, it's easy to get


%% batch loading and saving of all series

% specify location of lif file
fileDir = 'Y:\Marjolein\15-06-25_ICS_RBL_SP8'; % directory of lif file
fileName = 'RBL_YFsyk-mNG_IgE-647001.lif'; % name of lif file

% create lif object
lifObj = lif(fileDir,fileName); % ignore the 'unknown bla bla' outputs

% load and save all series as mat files
for ii = 1 : lifObj.NumSeries
    fn = lifObj.SeriesName{ii};
    [sequence,metadata] = lifObj.loadSeries(ii);
    save(fullfile(fileDir,[fn '.mat']),'sequence','metadata')
end