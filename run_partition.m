clc;
clear;
load('data.mat');
aa = affnity(query, ref, acc);
[ca, new_order] = BEAalgorithm(aa);
[r1, r2] = verticalPartition(new_order, ref, acc, query);