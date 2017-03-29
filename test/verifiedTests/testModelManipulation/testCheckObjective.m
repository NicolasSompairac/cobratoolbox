% The COBRAToolbox: testCheckObjective.m
%
% Purpose:
%     - Tests the changeObjective function
%

currentDir = pwd; % save the current path

% initialize the test
initTest(fileparts(which(mfilename)));

% load the model
load('ecoli_core_model.mat', 'model');

abbr = checkObjective(model);

assert(strcmp(abbr{1}, 'Biomass_Ecoli_core_w_GAM'));

% test if there are more than 1 objective
model.c(1) = 1;
abbr = checkObjective(model);
assert(strcmp(abbr{1}, 'ACALD'));
assert(strcmp(abbr{2}, 'Biomass_Ecoli_core_w_GAM'));

% test if there is no objective - will throw a warning message
w = warning ('off','all');
model.c(1) = 0;
model.c(13) = 0;
try
    abbr = checkObjective(model);
catch ME
    assert(length(ME.message) > 0)
end
w = warning ('on','all');

% change the directory
cd(currentDir)