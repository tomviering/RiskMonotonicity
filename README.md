# Minimizers of the Empirical Risk and Risk Monotonicity

This git contains all files necessary to reproduce the results of the paper:

[https://papers.nips.cc/paper/8966-minimizers-of-the-empirical-risk-and-risk-monotonicity.pdf](https://papers.nips.cc/paper/8966-minimizers-of-the-empirical-risk-and-risk-monotonicity.pdf)

Minimizers of the Empirical Risk and Risk Monotonicity

Marco Loog, Tom Viering, Alexander Mey

in NeurIPS 2019

If you use this code please cite the paper above.

## Installation

 1. Clone repository to your local PC: `git clone https://github.com/tomviering/RiskMonotonicity.git`
 2. (Optional) Download and put the [export_fig](https://nl.mathworks.com/matlabcentral/fileexchange/23629-export_fig) package in the folder export_fig under the same folder as the other files. Include it in your Matlab path by typing `addpath export_fig'.

## Files
### main.m
Runs all experiments and shows all resulting figures. If you set `save_to_file` to 1 all figures are exported to PDF (requires export_fig package).

