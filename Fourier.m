import findjobj.m.* %findobj librairie for scrolldown box
import plan.m.*  % class definition file
import square_signals.m.*  % class definition file

%  Calcul Fourier V2.0 - Signaux carrées -
%  Auteur : Donavan Martin
%  6 Janvier 2016
%  Inspirée de : Mathématiques des systèmes et signaux à temps continu
%  "les séries de Fourier" Roch Lefebvre, Professeur titulaire


% Paramètre d'affichage
% m = nombre de lignes
% n = nombre de colonnes
% p = position
m = 4;
n = 3;
p = 1;
K = 10;

% ---------Signal carrée---------
% Arguments : 
%   Période (sec),    [0 à inf.]
%   rapport cyclique, [0.00 1.00]
%   amp haut,         [-inf inf]
%   amp bas,          [-inf inf]  
%   echantillons      [0 inf.]
signal = square_signals(0.050, 0.5, 1.0, 0.0, 1000.0);

% -------- Affiche Signal --------
% Arguments
%   m (nombre de graphique par lignes)  [1 à inf.]
%   n (nombre de graphique par colonnes)[1 à inf.]
%   p (position dans la matrice mXn)    [1 à  m*n]
signal.plot_signal(m, n, p);
p = p+n;

% -------- Affiche spectre amplitude --------
% Arguments
%   nb_harmoniques (nombre d'harmoniques shouaités) [1 à inf.]
%   m (nombre de graphique par lignes)              [1 à inf.]
%   n (nombre de graphique par colonnes)            [1 à inf.]
%   p (position dans la matrice mXn)                [1 à  m*n]
signal.plot_spectre_ampl(K,m, n, p);
p = p+n;

% -------- Affiche spectre phases --------
% Arguments
%   m (nombre de graphique par lignes)   [1 à inf.]
%   n (nombre de graphique par colonnes) [1 à inf.]
%   p (position dans la matrice mXn)     [1 à  m*n]
signal.plot_spectre_phase(m, n, p);
p = p+n;

% -------- Affiche k premiers harmoniques --------
% Arguments
%   k (nombre d'harmoniques)            [1 à inf.]
%   m (nombre de graphique par lignes)  [1 à inf.]
%   n (nombre de graphique par colonnes)[1 à inf.]
%   p (position dans la matrice mXn)    [1 à m*n ]
signal.plot_sum_harmonique(K,m, n, p);
p = p+n;



