classdef square_signals < matlab.mixin.SetGet
    
    % Signal carré x(t)
    properties
        x;                    % Le signal
        t;                    % Tableau des temps d'échantillonages
        dt;                   % Intervalle d'échantillonage
        T;                    % Échantillon en millisecondes
        w0;                   % Fréquence fondamentale
        t_haut;               % Temps haut
        t_bas;                % Temps bas
        amp_haut;             % Amplitude haut
        amp_bas;              % Amplitude bas
        echantillons;         % Nombre d'échantillons
        
        % Analyse du signal
        nb_harmonique;        % Nombre d'harmonique désirées
        A;                    % Amplitudes
        P;                    % Phases
        DC;                   % Xo (moyenne)
        X;                    % Coefficient de Fourier
        y;                    % Courbe des harmoniques
    end
    
    methods
        % Constructeur de l'objet signal carrée
        % Arguments : Période ,rapport cyclique , amp haut, amp bas, nb d'échantillons
        function obj = square_signals(T_,r_cycl,amp_haut,amp_bas,echantillons_)
            obj.T = T_;                  
            obj.w0 = 2*pi/obj.T;                
            obj.t_haut = r_cycl;                   
            obj.t_bas  = 1-r_cycl;                   
            obj.amp_haut = amp_haut;
            obj.amp_bas  = amp_bas;
            obj.echantillons = echantillons_; 
            
            % Attr. les valeurs de chaque temps t
            obj.dt = obj.T./obj.echantillons;            
            obj.t  = 0:obj.dt:obj.T-obj.dt; 
            
            % Attr. les valeur de x(t) pour chaque temps t
            x_haut(1:T_*obj.t_haut*echantillons_) = amp_haut;  
            x_bas(1:T_*obj.t_bas*echantillons_)   = amp_bas;   
            obj.x = [x_haut x_bas];
        end
        
        %Affiche le signal à la position d'une matric mXn 
        function plot_signal(obj,m,n,p)                       
            subplot(m,n,p); 
            plot(obj.t,obj.x);                             % Affiche Signal
        end
        
        %Affiche le spectre d'amplitude 
        function obj =  plot_spectre_ampl(obj,nb_harmonique,m,n,p)   
            obj.nb_harmonique = nb_harmonique;
          
            for k=1:nb_harmonique                       % e^-jkw0t)
                u(k,:) = exp(-j*k*obj.w0*obj.t);      
            end
            obj.DC = sum(obj.x)*obj.dt;                 % X(0)
            for k=1:obj.nb_harmonique                   
                obj.X(k) = sum(obj.x.*u(k,:))*obj.dt;   % X(k)
            end
            subplot(m,n,p); 
            obj.A = abs(obj.X);
            stem(0:obj.nb_harmonique,[obj.DC obj.A]);   % Affiche Batonnêts
        end
        
        %Affiche le spectre d'amplitude 
        function obj =  plot_spectre_phase(obj,m,n,p)   
            subplot(m,n,p); 
            obj.P = angle(obj.X);
            stem(0:obj.nb_harmonique,[obj.DC obj.P]);   % Affiche Batonnêts
        end
        
        %Affiche la somme des k premiers harmoniques
        function obj =  plot_sum_harmonique(obj,K,m,n,p)   
            obj.P = angle(obj.X);
            
            obj.y = obj.DC;          % X(0)
            for k=1:K               
                obj.y = obj.y + 2*obj.A(k)*cos(k*obj.w0*obj.t + obj.P(k));
            end

            subplot(m,n,p);
            plot(obj.t,obj.y);                         % Affiche Harmonique  
        end
    end 
end
