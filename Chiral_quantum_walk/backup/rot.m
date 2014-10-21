function [A]=rot(axis,theta)
A=expm(-i*axis*theta);
