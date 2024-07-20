m=2000;n=1600;R=100;xi=0.01;MonteCarlo=3;
NoiseCore=ConstructTestMatrix(n,n,'Gaussian','entry');
S=zeros(n);S(1:R,1:R)=eye(R);S=S+xi*1/n*NoiseCore;
ANoise=GenerateLowRankConsum(m,n,S);
APoly=GenerateLowRankPlusPolyDecay(m,n,R,'high');
S=logspace(1,20,n-R)/1e20;
S=[ones(1,R),S];
AExp=GenerateLowRankConsum(m,n,S);
AExp2=GenerateLowRankPlusExpDecay(m,n,R,'low');
rList=floor(logspace(2.05,2.7,30));
Rangefinder={@qrQthin,@qMGS1,@MGSQqr,@pseudoSVD2,@stablePesudoQR,@pseudoSVD2};
onepassStart=5;
normArray=zeros(numel(Rangefinder),numel(rList));
timeArray=zeros(numel(Rangefinder),numel(rList));
%%
for iter=1:numel(rList)
    r=rList(iter)
    for iter2=1:numel(Rangefinder)
        rangefinder=Rangefinder{iter2};
        normF=0;
        timeF=0;
        if iter2<onepassStart
            for iter3=1:MonteCarlo
            tic;
            [U,S,V]=ranQLoRMA_RQSVD(ANoise,r,rangefinder,r+5,2*r+10,'Gaussian','entry',0);
            time=toc;
            normF=normF+normQf(ANoise-U*S*V');
            timeF=timeF+time;
            end
        else
            for iter3=1:MonteCarlo
            tic;
            [U,S,V]=ranQLoRMA(ANoise,r,rangefinder,r+5,2*r+10,'Gaussian','entry',0);
            time=toc;
            normF=normF+normQf(ANoise-U*S*V');
            timeF=timeF+time;
            end
        end
        normArray(iter2,iter)=normF/MonteCarlo;
        timeArray(iter2,iter)=timeF/MonteCarlo;
    end
end
save('data/NoiseData6.mat',"timeArray","normArray");
for iter=1:numel(rList)
    r=rList(iter)
    for iter2=1:numel(Rangefinder)
        rangefinder=Rangefinder{iter2};
        normF=0;
        timeF=0;
        if iter2<onepassStart
            for iter3=1:MonteCarlo
            tic;
            [U,S,V]=ranQLoRMA_RQSVD(APoly,r,rangefinder,r+5,2*r+10,'Gaussian','entry',0);
            time=toc;
            normF=normF+normQf(APoly -U*S*V');
            timeF=timeF+time;
            end
        else
            for iter3=1:MonteCarlo
            tic;
            [U,S,V]=ranQLoRMA(APoly,r,rangefinder,r+5,2*r+10,'Gaussian','entry',0);
            time=toc;
            normF=normF+normQf(APoly-U*S*V');
            timeF=timeF+time;
            end
        end
        normArray(iter2,iter)=normF/MonteCarlo;
        timeArray(iter2,iter)=timeF/MonteCarlo;
    end
end
save('data/PolyData6.mat',"timeArray","normArray");
for iter=1:numel(rList)
    r=rList(iter)
    for iter2=1:numel(Rangefinder)
        rangefinder=Rangefinder{iter2};
        normF=0;
        timeF=0;
        if iter2<onepassStart
            for iter3=1:MonteCarlo
            tic;
            [U,S,V]=ranQLoRMA_RQSVD(AExp,r,rangefinder,r+5,2*r+10,'Gaussian','entry',0);
            time=toc;
            normF=normF+normQf(AExp -U*S*V');
            timeF=timeF+time;
            end
        else
            for iter3=1:MonteCarlo
            tic;
            [U,S,V]=ranQLoRMA(AExp,r,rangefinder,r+5,2*r+10,'Gaussian','entry',0);
            time=toc;
            normF=normF+normQf(AExp-U*S*V');
            timeF=timeF+time;
            end
        end
        normArray(iter2,iter)=normF/MonteCarlo;
        timeArray(iter2,iter)=timeF/MonteCarlo;
    end
end
save('data/ExpData6.mat',"timeArray","normArray");
%%
for iter=1:numel(rList)
    r=rList(iter)
    for iter2=1:numel(Rangefinder)
        rangefinder=Rangefinder{iter2};
        normF=0;
        timeF=0;
        if iter2<onepassStart
            for iter3=1:MonteCarlo
            tic;
            [U,S,V]=ranQLoRMA_RQSVD(AExp2,r,rangefinder,r+5,2*r+10,'Gaussian','entry',0);
            time=toc;
            normF=normF+normQf(AExp2 -U*S*V');
            timeF=timeF+time;
            end
        else
            for iter3=1:MonteCarlo
            tic;
            [U,S,V]=ranQLoRMA(AExp2,r,rangefinder,r+5,2*r+10,'Gaussian','entry',0);
            time=toc;
            normF=normF+normQf(AExp2-U*S*V');
            timeF=timeF+time;
            end
        end
        normArray(iter2,iter)=normF/MonteCarlo;
        timeArray(iter2,iter)=timeF/MonteCarlo;
    end
end
%%
save('data/Exp2Data7.mat',"timeArray","normArray");