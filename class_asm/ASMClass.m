% ASMClass.m
% ASMClass Instruction
% INPUT: 
% X_Ssigma,X_Sh,X_Rsigma_t,R_R_t,U_S,f,PP
%
% Additional Properties:
% X_S;X_R_t;sigma;Sk
%
% Function:
% dispok(obj,color,comment)
% dispmel(obj,color,comment)

classdef ASMClass

    properties
        X_Ssigma;
        X_Sh;
        X_Rsigma_t;
        R_R_t;
        U_S;
        f;
        PP;
        X_S;
        X_R_t;
        sigma;
        Sk; 
    end
    %{
    % If using (Dependent) corresponding Getter function is needed in Method.
    properties (Dependent)
        X_S;
        X_R_t;
        sigma;
        Sk; 
    end
    %}

    methods
        %Construction Function
        
        function obj = ASMClass(X_Ssigma,X_Sh,X_Rsigma_t,R_R_t,U_S,f,PP)
            obj.X_Ssigma=X_Ssigma;
            obj.X_Sh=X_Sh;
            obj.X_Rsigma_t=X_Rsigma_t;
            obj.R_R_t=R_R_t;
            obj.U_S=U_S;
            obj.f=f;
            obj.PP=PP;
            %calc.
            obj.X_S = X_Ssigma+X_Sh;%Rs velaessichtbar
            obj.X_R_t = X_Sh+X_Rsigma_t;
            obj.sigma = 1-(X_Sh^2/obj.X_S/obj.X_R_t);
            obj.Sk = R_R_t/obj.sigma/obj.X_R_t;     
        end
        %% Disp.
        function dispok(obj,color,comment)
            % To display Ortskurve
            s = linspace(-1,1,1000);
            I_S = (obj.R_R_t./s+1j*obj.X_R_t)*obj.U_S./ ...
                      (1j*obj.R_R_t./s*obj.X_S-obj.sigma*obj.X_S*obj.X_R_t);
            plot(-imag(I_S),real(I_S),'.',Color=color,DisplayName=comment);
            hold on;
            axis equal;
            sinf = inf;
            I_S_inf = (obj.R_R_t./sinf+1j*obj.X_R_t)*obj.U_S./ ...
                      (1j*obj.R_R_t./sinf*obj.X_S-obj.sigma*obj.X_S*obj.X_R_t);

            %I_S_inf = (1j*obj.X_R_t)*obj.U_S./ ...
            %         (-obj.sigma*obj.X_S*obj.X_R_t);
            %s0 = 0;
            I_S_0 = obj.U_S/(1j*obj.X_S);

            fprintf('Situation: %s,\ns_inf corresponding Is = %0.2f\n',comment,imag(I_S_inf));
            fprintf('s0 corresponding Is = %0.2f\n',imag(I_S_0));
            fprintf('Radiu is:%0.2f\n\n',-(imag(I_S_0)+imag(I_S_inf))/2);

        end

        function dispmel(obj,color,comment)
            % To display Mel gengen s
             s = linspace(0,2,1000);
             P_delta = 3*obj.X_Sh^2/obj.X_S^2*obj.R_R_t.*s./(obj.R_R_t^2+ ...
                 (obj.sigma*obj.X_R_t.*s).^2)*obj.U_S^2;
             Mel = P_delta/(2*pi*obj.f/obj.PP);
             plot(-s,Mel,LineWidth=1,Color=color,DisplayName=comment);
             hold on;
             [~,idx]=max(P_delta);
             fprintf('Situation: %s, \n Max Momente: %0.2f @ s= %0.2f\n\n', ...
                      comment, max(Mel),s(idx));
             
        end
    end
             
        %{
        % Gegenstrom Bremsbetrieb
        for s = linspace(1,10,100)
            I_S = (R_R_t./s+1j*X_R_t)*U_S./(1j*R_R_t./s*X_S-sigma*X_S*X_R_t);
            %plot_v(I_S);
            plot(-imag(I_S),real(I_S),'.')
            hold on;
            axis equal;
        end
        %}
        
end