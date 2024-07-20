decayList={'low','mid','high'};
m=2000;n=1600;R=100;MonteCarlo=3;
for iterDecay=1:numel(decayList)
    decay=decayList{iterDecay};
    if strcmp(decay,'high')
        xi=0.1;
    elseif strcmp(decay,'mid')
        xi=0.01;

    elseif strcmp(decay,'low')
        xi=0.0001;
    end
    NoiseCore=ConstructTestMatrix(n,n,'Gaussian','entry');
    S=zeros(n);S(1:R,1:R)=eye(R);S=S+xi*1/n*NoiseCore;
    ANoise=GenerateLowRankConsum(m,n,S);
    APoly=GenerateLowRankPlusPolyDecay(m,n,R,decay);
    S=logspace(1,20,n-R)/1e20;
    S=[ones(1,R),S];
    AExp=GenerateLowRankConsum(m,n,S);
    AExp2=GenerateLowRankPlusExpDecay(m,n,R,decay);
    rList=floor(logspace(2.05,2.7,10));
    Rangefinder={@qrQthin,@qMGS1,@MGSQqr,@pseudoSVD2,@stablePesudoQR,@pseudoSVD2};
    onepassStart=5;
    distribution='Gaussian';
    normF=0;
    timeF=0;
    normArray=zeros(numel(Rangefinder),numel(rList));
    timeArray=zeros(numel(Rangefinder),numel(rList));
% Rangefinder={@qMGS1,@MGSQqr,@pseudoSVD2,@stablePesudoQR,@pseudoSVD2};
% onepassStart=4;
%%
    
    
    % for iter2=1:numel(Rangefinder)
    %     rangefinder=Rangefinder{iter2};
    %     for iter=1:numel(rList)
    %         r=rList(iter)
    %         if iter2<onepassStart
    %             for iter3=1:MonteCarlo
    %                 tic;
    %                 [U,S,V]=ranQLoRMA_RQSVD(APoly ,r,rangefinder,r+5,2*r+10,distribution,'entry',0);
    %                 time=toc;
    %                 normF=normF+normQf(APoly -U*S*V');
    %                 timeF=timeF+time;
    %             end
    %         else
    %             for iter3=1:MonteCarlo
    %                 tic;
    %                 [U,S,V]=ranQLoRMA(APoly,r,rangefinder,r+5,2*r+10,distribution,'entry',0);
    %                 time=toc;
    %                 normF=normF+normQf(APoly -U*S*V');
    %                 timeF=timeF+time;
    %             end
    %         end
    % 
    %         normArray(iter2,iter)=normF/MonteCarlo;
    %         timeArray(iter2,iter)=timeF/MonteCarlo;
    % 
    %         normF=0;
    %         timeF=0;
    %     end
    % 
    % end
    % normArray=normArray/normQf(APoly);
    % str=['dataAll/Poly_',decay,'.mat'];
    % save(str,"timeArray","normArray");
    %%
    for iter2=1:numel(Rangefinder)
        rangefinder=Rangefinder{iter2};
        for iter=1:numel(rList)
            r=rList(iter)
            if iter2<onepassStart
                for iter3=1:MonteCarlo
                    tic;
                    [U,S,V]=ranQLoRMA_RQSVD(ANoise ,r,rangefinder,r+5,2*r+10,distribution,'entry',0);
                    time=toc;
                    normF=normF+normQf(ANoise -U*S*V');
                    timeF=timeF+time;
                end
            else
                for iter3=1:MonteCarlo
                    tic;
                    [U,S,V]=ranQLoRMA(ANoise,r,rangefinder,r+5,2*r+10,distribution,'entry',0);
                    time=toc;
                    normF=normF+normQf(ANoise -U*S*V');
                    timeF=timeF+time;
                end
            end

            normArray(iter2,iter)=normF/MonteCarlo;
            timeArray(iter2,iter)=timeF/MonteCarlo;

            normF=0;
            timeF=0;
        end
        
    end
    normArray=normArray/normQf(ANoise);
    str=['dataAll/Noise_',decay,'.mat'];
    save(str,"timeArray","normArray");
    %%
    for iter2=1:numel(Rangefinder)
        rangefinder=Rangefinder{iter2};
        for iter=1:numel(rList)
            r=rList(iter)
            if iter2<onepassStart
                for iter3=1:MonteCarlo
                    tic;
                    [U,S,V]=ranQLoRMA_RQSVD(AExp ,r,rangefinder,r+5,2*r+10,distribution,'entry',0);
                    time=toc;
                    normF=normF+normQf(AExp -U*S*V');
                    timeF=timeF+time;
                end
            else
                for iter3=1:MonteCarlo
                    tic;
                    [U,S,V]=ranQLoRMA(AExp,r,rangefinder,r+5,2*r+10,distribution,'entry',0);
                    time=toc;
                    normF=normF+normQf(AExp -U*S*V');
                    timeF=timeF+time;
                end
            end

            normArray(iter2,iter)=normF/MonteCarlo;
            timeArray(iter2,iter)=timeF/MonteCarlo;

            normF=0;
            timeF=0;
        end
        
    end
    normArray=normArray/normQf(AExp);
    str=['dataAll/Exp_',decay,'.mat'];
    save(str,"timeArray","normArray");

    %%
    for iter2=1:numel(Rangefinder)
        rangefinder=Rangefinder{iter2};
        for iter=1:numel(rList)
            r=rList(iter)
            if iter2<onepassStart
                for iter3=1:MonteCarlo
                    tic;
                    [U,S,V]=ranQLoRMA_RQSVD(AExp2 ,r,rangefinder,r+5,2*r+10,distribution,'entry',0);
                    time=toc;
                    normF=normF+normQf(AExp2 -U*S*V');
                    timeF=timeF+time;
                end
            else
                for iter3=1:MonteCarlo
                    tic;
                    [U,S,V]=ranQLoRMA(AExp2,r,rangefinder,r+5,2*r+10,distribution,'entry',0);
                    time=toc;
                    normF=normF+normQf(AExp2 -U*S*V');
                    timeF=timeF+time;
                end
            end

            normArray(iter2,iter)=normF/MonteCarlo;
            timeArray(iter2,iter)=timeF/MonteCarlo;

            normF=0;
            timeF=0;
        end
        
    end
    normArray=normArray/normQf(AExp2);
    str=['dataAll/Exp2_',decay,'.mat'];
    save(str,"timeArray","normArray");


end




% for iterDistribution=1:numel(distributionList)
%     distribution=distributionList{iterDistribution};
%     oversample=5:15:200;
% for iter=1:numel(rList)
%     r=rList(iter)
%     for iter2=1:numel(Rangefinder)
%         rangefinder=Rangefinder{iter2};
%         normF=0;
%         timeF=0;
%         if iter2<onepassStart
%             for iter3=1:MonteCarlo
%             tic;
%             [U,S,V]=ranQLoRMA_RQSVD(ANoise,r,rangefinder,r+5,2*r+10,distribution,'entry',0);
%             time=toc;
%             normF=normF+normQf(ANoise-U*S*V');
%             timeF=timeF+time;
%             end
%         else
%             for iter3=1:MonteCarlo
%             tic;
%             [U,S,V]=ranQLoRMA(ANoise,r,rangefinder,r+5,2*r+10,distribution,'entry',0);
%             time=toc;
%             normF=normF+normQf(ANoise-U*S*V');
%             timeF=timeF+time;
%             end
%         end
%         normArray(iter2,iter)=normF/MonteCarlo;
%         timeArray(iter2,iter)=timeF/MonteCarlo;
%     end
% end
% normArray=normArray/normQf(ANoise);
% str=['data/Noise_',distribution,'_',decay,'.mat'];
% save(str,"timeArray","normArray");
% for iter=1:numel(rList)
%     r=rList(iter)
%     for iter2=1:numel(Rangefinder)
%         rangefinder=Rangefinder{iter2};
%         normF=0;
%         timeF=0;
%         if iter2<onepassStart
%             for iter3=1:MonteCarlo
%             tic;
%             [U,S,V]=ranQLoRMA_RQSVD(APoly,r,rangefinder,r+5,2*r+10,distribution,'entry',0);
%             time=toc;
%             normF=normF+normQf(APoly -U*S*V');
%             timeF=timeF+time;
%             end
%         else
%             for iter3=1:MonteCarlo
%             tic;
%             [U,S,V]=ranQLoRMA(APoly,r,rangefinder,r+5,2*r+10,distribution,'entry',0);
%             time=toc;
%             normF=normF+normQf(APoly-U*S*V');
%             timeF=timeF+time;
%             end
%         end
%         normArray(iter2,iter)=normF/MonteCarlo;
%         timeArray(iter2,iter)=timeF/MonteCarlo;
%     end
% end
% normArray=normArray/normQf(APoly);
% str=['data/Poly_',distribution,'_',decay,'.mat'];
% save(str,"timeArray","normArray");
% for iter=1:numel(rList)
%     r=rList(iter)
%     for iter2=1:numel(Rangefinder)
%         rangefinder=Rangefinder{iter2};
%         normF=0;
%         timeF=0;
%         if iter2<onepassStart
%             for iter3=1:MonteCarlo
%             tic;
%             [U,S,V]=ranQLoRMA_RQSVD(AExp,r,rangefinder,r+5,2*r+10,distribution,'entry',0);
%             time=toc;
%             normF=normF+normQf(AExp -U*S*V');
%             timeF=timeF+time;
%             end
%         else
%             for iter3=1:MonteCarlo
%             tic;
%             [U,S,V]=ranQLoRMA(AExp,r,rangefinder,r+5,2*r+10,distribution,'entry',0);
%             time=toc;
%             normF=normF+normQf(AExp-U*S*V');
%             timeF=timeF+time;
%             end
%         end
%         normArray(iter2,iter)=normF/MonteCarlo;
%         timeArray(iter2,iter)=timeF/MonteCarlo;
%     end
% end
% normArray=normArray/normQf(AExp);
% str=['data/Exp_',distribution,'_',decay,'.mat'];
% save(str,"timeArray","normArray");
% %%
% for iter=1:numel(rList)
%     r=rList(iter)
%     for iter2=1:numel(Rangefinder)
%         rangefinder=Rangefinder{iter2};
%         normF=0;
%         timeF=0;
%         if iter2<onepassStart
%             for iter3=1:MonteCarlo
%             tic;
%             [U,S,V]=ranQLoRMA_RQSVD(AExp2,r,rangefinder,r+5,2*r+10,distribution,'entry',0);
%             time=toc;
%             normF=normF+normQf(AExp2 -U*S*V');
%             timeF=timeF+time;
%             end
%         else
%             for iter3=1:MonteCarlo
%             tic;
%             [U,S,V]=ranQLoRMA(AExp2,r,rangefinder,r+5,2*r+10,distribution,'entry',0);
%             time=toc;
%             normF=normF+normQf(AExp2-U*S*V');
%             timeF=timeF+time;
%             end
%         end
%         normArray(iter2,iter)=normF/MonteCarlo;
%         timeArray(iter2,iter)=timeF/MonteCarlo;
%     end
% end
% %%
% normArray=normArray/normQf(AExp2);
% str=['data/Exp2_',distribution,'_',decay,'.mat'];
% save(str,"timeArray","normArray");
% end
% end
