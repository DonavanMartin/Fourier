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
        
        %Propriétés Affichage
        hp;
    end
    
    methods
        % Constructeur de l'objet signal carrée
        % Arguments : Période ,rapport cyclique , amp haut, amp bas, nb d'échantillons
        function obj = square_signals(T_,r_cycl,amp_haut,amp_bas,echantillons_)
            obj.T = T_;                  
            obj.w0 = (2*3.141592653)/obj.T;                
            obj.t_haut = r_cycl;                   
            obj.t_bas  = 1-r_cycl;                   
            obj.amp_haut = amp_haut;
            obj.amp_bas  = amp_bas;
            obj.echantillons = echantillons_; 
            
            % Attr. les valeurs de chaque temps t
            obj.dt = obj.T./obj.echantillons;            
            obj.t  = 0:obj.dt:(obj.T-obj.dt); 
            
            % Attr. les valeur de x(t) pour chaque temps t
            x_haut(1:obj.t_haut*echantillons_) = amp_haut;  
            x_bas(1:obj.t_bas*echantillons_)   = amp_bas;   
            obj.x = [x_haut x_bas];
            
            % Propriétés GUI
            obj.hp = uipanel('Title',...
                             'Série de Fourier : Onde Carré',...
                             'FontSize',12,...
                             'BackgroundColor','white',...
                             'Position',[0 0 1 1]);
        end
        
        %Affiche le signal à la position d'une matric mXn 
        function plot_signal(obj,m,n,p)
            subplot(m,n,[p,p+n-1], 'Parent', obj.hp);
            plot(obj.t,obj.x);                             % Affiche Signal
            title(strjoin({'Signal carrée:';... 
                          ' r.c.=';num2str(obj.t_haut/(obj.t_bas+obj.t_haut));...
                          ' Période =';num2str(obj.T) }));
        end
        
        %Affiche le spectre d'amplitude 
        function obj =  plot_spectre_ampl(obj,nb_harmonique,m,n,p)   
            obj.nb_harmonique = nb_harmonique;
          
            for k=1:nb_harmonique                       % e^-jkw0t)
                x0 = exp(-1i*k*obj.w0.*obj.t);
                x1 = x0 + eps(x0); 
                u(k,:) = x1;      
            end
                obj.DC = sum(obj.x)/obj.echantillons;            % X(0)
                
            for k=1:nb_harmonique
                x0 = sum((obj.x.*u(k,:))*(1/obj.echantillons));
                x1 = x0 + eps(x0); 
                obj.X(k) = x1;   % X(k)
            end
            

            obj.A = abs(obj.X);
            
            % Affiche les valeurs (scroll box)
            harmoniques = strtrim(cellstr(num2str((0:obj.nb_harmonique)'))');
            Amplitudes  = strtrim(cellstr(num2str([obj.DC obj.A]'))');
            list = strcat(harmoniques, {': '}, Amplitudes);
            obj.affiche_text_box(list,m,n,p);
            
            % Affiche Batonnêts
            subplot(m,n,[p+1,p+n-1]); 
            stem(0:obj.nb_harmonique,[obj.DC obj.A]);
        end
        
        %Affiche le spectre d'amplitude 
        function obj =  plot_spectre_phase(obj,m,n,p)   
            obj.P = angle(obj.X);
            
             % Affiche les valeurs (scroll box)
            harmoniques = strtrim(cellstr(num2str((0:obj.nb_harmonique)'))');
            phases  = strtrim(cellstr(num2str([0 obj.P]'))');
            list = strcat(harmoniques, {': '}, phases);
            obj.affiche_text_box(list,m,n,p);
            
            % Affiche Batonnêts
            subplot(m,n,[p+1,p+n-1]); 
            stem(0:obj.nb_harmonique,[0 obj.P]);   
        end
        
        %Affiche la somme des k premiers harmoniques
        function obj =  plot_sum_harmonique(obj,K,m,n,p)   
            obj.P = angle(obj.X);
            
            obj.y = obj.DC;          % X(0)
            for k=1:K               
                obj.y = obj.y + 2*obj.A(k)*cos(k*obj.w0*obj.t + obj.P(k));
            end

            subplot(m,n,[p,p+n-1]);
            plot(obj.t,obj.y);                         % Affiche Harmonique
            title(strjoin({'Somme des ';num2str(K);' harmoniques'}));
        end
    end
    methods (Access = private)
         %Affiche un textbox a droite du graphique
        function affiche_text_box(~,str,m,n,p)

            subplot(m,n,p);
            axis off; 
            list_string = strjoin(str,'\n');
            %# GUI with multi-line editbox
            position_y = 1+((p-1)/n);
            set_y = ((m)-position_y)/m;
            uicontrol(figure(1), 'Style','edit', 'FontSize',9, ...
                'Min',0, 'Max',2, 'HorizontalAlignment','left', ...
                'Units','normalized', 'Position',[0.4/n (0.18/m)+set_y 0.65/n 0.60/m], ...
                'String',list_string);
        end
    end 
end
