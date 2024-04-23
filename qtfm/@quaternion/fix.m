function a = fix(q)
% FIX Round towards zero.
% (Quaternion overloading of standard Matlab function.)

% Copyright © 2006 Stephen J. Sangwine and Nicolas Le Bihan.
% See the file : Copyright.m for further details.

narginchk(1, 1), nargoutchk(0, 1) 

a = overload(mfilename, q);

end

% $Id: fix.m 1113 2021-02-01 18:41:09Z sangwine $
