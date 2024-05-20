function obj = minus(obj1, obj2)
   obj = myquaternion(obj1.q1 - obj2.q1,obj1.q2 - obj2.q2);
end