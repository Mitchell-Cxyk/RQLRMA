function d = single(~) %#ok<STOUT>
% SINGLE Convert octonion to single precision (obsolete).
% (Octonion overloading of standard Matlab function.)

% Copyright © 2006 Stephen J. Sangwine and Nicolas Le Bihan.
% See the file : Copyright.m for further details.

error(['Conversion to single from octonion is not possible. ',...
       'Try cast(q, ''single'')'])

% Note: this function was replaced from version 0.9 with the convert
% function, because it is incorrect to provide a conversion function
% that returns an octonion result. The convert function provides the
% same functionality, but will not be called implicitly by Matlab to
% implement an assignment like X(1,2) = octonion(1,2,3,4) which gave
% erroneous results prior to version 0.9 and now raises an error.

end

% $Id: single.m 1113 2021-02-01 18:41:09Z sangwine $

% Created automatically from the quaternion
% function of the same name on 17-Feb-2020.