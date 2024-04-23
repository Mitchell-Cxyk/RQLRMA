function testMatrix = ConstructTestMatrix(m,n,distribution,independence)
%
% This script is to construct a m * n quaternion test matrix that statisfy the @distrubution and @independence.
%
% @since 1.0.0
% @param {interger} [m,n] size of testMatrix.
% @param {string} [distribution,independence] distribution of testMatrix, entries independce or row/column independence
% @return {quaternion} [testMatrix]
% @see dependencies
%
OmegaSize=[m,n];
if strcmp(distribution,'Gaussian')
    Omega=quaternion(randn(OmegaSize),randn(OmegaSize),randn(OmegaSize),randn(OmegaSize));
elseif strcmp(distribution,'Radmacher')
    Omega= quaternion(2*(rand(OmegaSize)<0.5)-1,2*(rand(OmegaSize)<0.5)-1,2*(rand(OmegaSize)<0.5)-1,2*(rand(OmegaSize)<0.5)-1);
elseif strcmp(distribution,'SparseGaussian')
    sparseParam=0.01;
    tmp=sprandn(OmegaSize(1),OmegaSize(2),sparseParam);
    Omega=quaternion(0.000001*eye(m,n)+sprandn(tmp),sprandn(tmp),sprandn(tmp),sprandn(tmp));
elseif strcmp(distribution,'subGaussian')
    if strcmp(independence,'entry')
        Omega=quaternion(rand(OmegaSize).*randn(OmegaSize),rand(OmegaSize).*randn(OmegaSize),rand(OmegaSize).*randn(OmegaSize),rand(OmegaSize).*randn(OmegaSize));
    elseif strcmp(independence,'row')
        Omega=[];
    elseif strcmp(independence,'column')
        randList=randperm(n);
        Omega=eyeq(m,n);
        Omega((1:n),:)=Omega(randList,:);
    else
        disp('error Parameter!\n')
    end
end
testMatrix=Omega;

    

end
