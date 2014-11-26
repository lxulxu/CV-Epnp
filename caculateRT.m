function [R,T] = caculateRT(R,M)
%R -> M

%Sum the appended matrices R and M across the columns, and divide by the
%column size of the matrices to calculate the mean positions (equation 19)
meanR = sum(R,2)./size(R,2);   
meanM = sum(M,2)./size(M,2);

%Calculate and append position vectors relative to mean positions (equation
%21)
pb = M - repmat(meanM,1,size(M,2));
pa = R - repmat(meanR,1,size(R,2));

%get estimation of rotation maxtrix from a to b
%pa 2*n pb 2*n points at center
%R 2*2
dimen = size(pa,1);
H = zeros(dimen);
for i = 1:dimen
    h = pa(:,i)*pb(:,i)';
    H = H+h;    
end

[U,~,V] = svd(H);
R = V*U';

%% the other way
%Calculate S (equation 20)
%S = C*D';

%Note that the third matrix output by the SVD function is the transpose
%of R2 (equation 22)
%[R1, ~, R2T] = svd(S);
%R2 = R2T';  %calculate R2

%Calculate the rotation matrix and translation vector (equation 23 and 24)
%R = R1*[1 0 0; 0 1 0; 0 0 det(R1*R2)]*R2;

T = meanM - R*meanR;

end