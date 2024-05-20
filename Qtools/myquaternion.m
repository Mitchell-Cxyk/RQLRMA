classdef myquaternion
    %UNTITLED compactly complex representation of a quaternion scalar,
    %vector, or matrix. q = myquaternion(q1,q2) means q = q1 + q2*j, where
    %q1 and q2 are complex scalars, vectors, matrix, or tensors of the same
    %size

    properties
        q1;
        q2;
    end

    methods
        function obj = myquaternion(q1,q2)
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            obj.q1 = q1;
            obj.q2 = q2;
        end

        function obj = plus(obj1,obj2)
            isq1 = isa(obj1, 'myquaternion');
            isq2 = isa(obj2, 'myquaternion');
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            if isq1 && isq2
                obj = myquaternion(obj1.q1 + obj2.q1,obj1.q2 + obj2.q2);
            elseif isq1 && (~isq2)  % obj2 is a real or complex number
                obj = myquaternion(obj1.q1 + obj2, obj1.q2);
            elseif (~isq1) && isq2  % obj1 is a real or complex number
                obj = myquaternion(obj1 + obj2.q1, obj2.q2);
            else                    % both obj1 and obj2 are real or complex numbers
                obj = obj1+obj2;
            end
        end
        function obj = minus(obj1, obj2)
            isq1 = isa(obj1, 'myquaternion');
            isq2 = isa(obj2, 'myquaternion');
            if isq1 && isq2
                obj = myquaternion(obj1.q1 - obj2.q1,obj1.q2 - obj2.q2);
            elseif isq1 && (~isq2)  % obj2 is a real or complex number
                obj = myquaternion(obj1.q1 - obj2, obj1.q2);
            elseif (~isq1) && isq2  % obj1 is a real or complex number
                obj = myquaternion(obj1 - obj2.q1, obj2.q2);
            else                    % both obj1 and obj2 are real or complex numbers
                obj = obj1-obj2;
            end
        end
        function obj = mtimes(o1,o2)
            isq1 = isa(o1, 'myquaternion');
            isq2 = isa(o2, 'myquaternion');
            if isq1 && isq2
                % o1 = o1.q1 + o1.q2*j, o2 = o2.q1 + o2.q2*j
                %(o1*o2).q1 = o1.q1*o2.q1 - o1.q2*conj(o2.q2);
                % (o1*o2).q2 = o1.q1*o2.q2 + o1.q2*conj(o2.q1).
                obj = myquaternion(o1.q1*o2.q1 - o1.q2*conj(o2.q2),...
                    o1.q1*o2.q2+o1.q2*conj(o2.q1));
            elseif isq1 && (~isq2)  % q2 is real or complex, and so o2 = o2.q1
                % o1 = o1.q1 + o1.q2*j, o2 = o2.q1
                %(o1*o2).q1 = o1.q1*o2.q1;
                % (o1*o2).q2 = o1.q2*conj(o2.q1).
                obj = myquaternion(o1.q1*o2, o1.q2*conj(o2));
            elseif (~isq1) && isq2  % q1 is real or complex, and so o1 = o1.q1
                % o1 = o1.q1, o2 = o2.q1 + o2.q2*j
                %(o1*o2).q1 = o1.q1*o2.q1;
                % (o1*o2).q2 = o1.q1*o2.q2.
                obj = myquaternion(o1*o2.q1, o1*o2.q2);
            else
                obj = o1*o2;
            end
        end
        function obj = uminus(o1)
            obj = o1; obj.q1 = -obj.q1; obj.q2 = -obj.q2;
        end
        function obj = uplus(o1)
            obj = o1;
        end
        function obj = times(o1,o2)
            isq1 = isa(o1, 'myquaternion');
            isq2 = isa(o2, 'myquaternion');
            % o1 = o1.q1 + o1.q2*j, o2 = o2.q1 + o2.q2*j
            %(o1.*o2).q1 = o1.q1.*o2.q1 - o1.q2.*conj(o2.q2);
            % (o1.*o2).q2 = o1.q1.*o2.q2 + o1.q2.*conj(o2.q1).
            if isq1 && isq2
                obj = myquaternion(o1.q1.*o2.q1 - o1.q2.*conj(o2.q2),...
                    o1.q1.*o2.q2+o1.q2.*conj(o2.q1));
            elseif isq1 && (~isq2)
                % o1 = o1.q1 + o1.q2*j, o2 = o2.q1
                %(o1.*o2).q1 = o1.q1.*o2.q1;
                % (o1.*o2).q2 = o1.q2.*conj(o2.q1).
                obj = myquaternion(o1.q1.*o2, o1.q2.*conj(o2));
            elseif (~isq1) && isq2
                % o1 = o1.q1, o2 = o2.q1 + o2.q2*j
                %(o1.*o2).q1 = o1.q1.*o2.q1;
                % (o1.*o2).q2 = o1.q1.*o2.q2.
                obj = myquaternion(o1.*o2.q1, o1.*o2.q2);
            else
                obj = o1.*o2;
            end
        end
        function obj = rdivide(o1,o2)
            isq1 = isa(o1, 'myquaternion');
            isq2 = isa(o2, 'myquaternion');
            % o1 = o1.q1 + o1.q2*j, o2 = o2.q1 + o2.q2*j
            %(o1./o2).q1 = o1.q1./o2.q1 - o1.q2./conj(o2.q2);
            % (o1./o2).q2 = o1.q1./o2.q2 + o1.q2./conj(o2.q1).
            if isq1 && isq2
                obj = myquaternion(o1.q1./o2.q1 - o1.q2./conj(o2.q2),...
                    o1.q1./o2.q2+o1.q2./conj(o2.q1));
            elseif isq1 && (~isq2)
                % o1 = o1.q1 + o1.q2*j, o2 = o2.q1
                %(o1./o2).q1 = o1.q1./o2.q1;
                % (o1./o2).q2 = o1.q2./conj(o2.q1).
                obj = myquaternion(o1.q1./o2, o1.q2./conj(o2));
            elseif (~isq1) && isq2
                % o1 = o1.q1, o2 = o2.q1 + o2.q2*j
                %(o1./o2).q1 = o1.q1./o2.q1;
                % (o1./o2).q2 = o1.q1./o2.q2.
                obj = myquaternion(o1./o2.q1, o1./o2.q2);
            else
                obj = o1.*o2;
            end
        end
        function sz = size(o,varargin)
            if isa(o,'myquaternion')
                if isempty(varargin)
                    sz = size(o.q1);
                else
                    sz = size(o.q1,varargin{:});
                end
            else
                if isempty(varargin)
                    sz = size(o);
                else
                    sz = size(o,varargin{:});
                end
            end
        end
        function obj = subsref(o,s)
            if isa(o,'myquaternion')
                switch s.type
                    case '()'
                        obj = myquaternion(o.q1(s.subs{:}),o.q2(s.subs{:}));
                    case '.'
                        switch s.subs
                            case 'q1'
                                obj = o.q1;
                            case 'q2'
                                obj = o.q2;
                            case {'w','a'}
                                obj = real(o.q1);
                            case {'x','i','I','b'}
                                obj = imag(o.q1);
                            case {'y','j','J','c'}
                                obj = real(o.q2);
                            case {'z','k','K','d'}
                                obj = imag(o.q2);
                        end
                end
            else
                obj = o(s.subs{:});
            end
        end
        function obj = transpose(o)
            obj.q1 = o.q1.';
            obj.q2 = o.q2.';
        end
        function obj = ctranspose(o)
            obj = myquaternion(0,0);
            obj.q1 = o.q1';
            obj.q2 = -o.q2.';
        end
        function obj = conj(o)
            obj = myquaternion(0,0);
            obj.q1 = conj(o.q1);
            obj.q2 = -o.q2;
        end
        function f = full(o)
            f = [o.q1 o.q2; -conj(o.q2) conj(o.q1)];
        end
        function r = ndims(o)
            r = ndims(o.q1);
        end
    end


end

