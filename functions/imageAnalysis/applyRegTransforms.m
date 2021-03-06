function out=applyRegTransforms(image,transforms)

% outputs:
% out is your shifted (registered frame). 
%
% inputs:
% image = image you want registered
% transforms = transforms to apply (from dftregistration).

% The structure of the transforms is:
% output=[error,diffphase,row_shift,col_shift];

varClass=class(image);
buf2ft=fft2(image);

[nr,nc]=size(buf2ft);
Nr = ifftshift([-fix(nr/2):ceil(nr/2)-1]);
Nc = ifftshift([-fix(nc/2):ceil(nc/2)-1]);
[Nc,Nr] = meshgrid(Nc,Nr);
Greg = buf2ft.*exp(i*2*pi*(-transforms(3)*Nr/nr-transforms(4)*Nc/nc));
Greg = Greg*exp(i*transforms(2));


out=abs(ifft2(Greg));
if strcmp(varClass,'uint16')
    out=im2uint16(out);
else
end


