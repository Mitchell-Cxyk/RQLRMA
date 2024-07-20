mm = 80:40:1500; n = 80;
tresult = zeros(1,length(mm));
i = 0;
tmp = 0;
mont_times = 3;
for m = mm
    tmp = 0;
    for j = 1: mont_times
    A = randnQ([m,n]);
    tic,
    [q,r] = qrQ(A);
    t1 = toc;
    tmp = tmp + t1;
    end
    tmp = tmp/mont_times;
    i = i + 1;
    tresult(i) = tmp;
end


plot(tresult)




 

 
