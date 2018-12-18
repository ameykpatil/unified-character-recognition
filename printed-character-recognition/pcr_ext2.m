function [ array ] = pcr_ext2( q )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


u=imresize(q,[14,10],'bicubic');
level = graythresh(u);
array = im2bw(u,level);
end

