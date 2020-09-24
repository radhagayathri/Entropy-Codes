% Function to generate the approximate entropy profile of a given time-series
function [AEprofile]= apEnProfiling(ts,m)

% AEprofile - approximate entropy (ApEn)profile w.r.t parameter r
% ts is the input time-series
% m is the embedding dimension (normally take values 2 or 3)

[b,a,range] = CHMforApEn(ts,m); % Cumuative histogram method to find r-profile

AEprofile=[range (b-a)]; % profile: column 1 is the r-value and column 2 is the corresponding ApEn value.

%----------------------------------------------------------------------------
% coded by Radhagayathri Udhayakumar,
% radhagayathri.udhayakumar@deakin.edu.au
% Updated version: 19th September 2020
% 
% To cite:
% 1. Radhagayathri K. Udhayakumar, Chandan Karmakar, and Marimuthu
% Palaniswami, Approximate entropy profile: a novel approach to comprehend 
% irregularity of short-term HRV signal, Nonlinear Dynamics, 2016.
% 2. Radhagayathri K Udhayakumar, Chandan Karmakar, and Marimuthu 
% Palaniswami, Understanding irregularity characteristics of short-term HRV 
% signals using sample entropy profile, IEEE Transactions on Bio-Medical
% Engineering, 2018.
%----------------------------------------------------------------------------