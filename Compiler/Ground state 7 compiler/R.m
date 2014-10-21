%% Generate the Unitary Matrix for Rotation Around a Product Operator;
function R=R(operator, angle)
R=expm(-i*operator/2*angle*pi/180);