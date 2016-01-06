import plan.m.*  % class definition file
import square_signals.m.*  % class definition file

%  Calcul Fourier V1.0 - Signaux carrées -
%  Auteur : Donavan Martin
%  5 Janvier 2016
%  Inspirée de : Mathématiques des systèmes et signaux à temps continu
%  "les séries de Fourier" Roch Lefebvre, Professeur titulaire


% ---------Signal carrée---------
% Arguments : 
%   Période (sec),    [0 à inf.]
%   rapport cyclique, [0.00 1.00]
%   amp haut,         [-inf inf]
%   amp bas,          [-inf inf]  
%   echantillons      [0 inf.]
signal = square_signals(1, 0.25, 1, 0, 1000);

% -------- Affiche Signal --------
% Arguments
%   m (nombre de graphique par colonne) [1 à inf.]
%   n (nombre de graphique par ligne)   [1 à inf.]
%   p (position dans la matrice mXn)    [1 à  m*n]
signal.plot_signal(4, 1, 1);

% -------- Affiche spectre amplitude --------
% Arguments
%   nb_harmoniques (nombre d'harmoniques shouaités) [1 à inf.]
%   m (nombre de graphique par colonne)             [1 à inf.]
%   n (nombre de graphique par ligne)               [1 à inf.]
%   p (position dans la matrice mXn)                [1 à  m*n]
signal.plot_spectre_ampl(20,4,1,2); 

% -------- Affiche spectre phases --------
% Arguments
%   m (nombre de graphique par colonne) [1 à inf.]
%   n (nombre de graphique par ligne)   [1 à inf.]
%   p (position dans la matrice mXn)    [1 à  m*n]
signal.plot_spectre_phase(4,1,3); 

% -------- Affiche k premiers harmoniques --------
% Arguments
%   k (nombre d'harmoniques)            [1 à inf.]
%   m (nombre de graphique par colonne) [1 à inf.]
%   n (nombre de graphique par ligne)   [1 à inf.]
%   p (position dans la matrice mXn)    [1 à m*n ]
signal.plot_sum_harmonique(20,4,1,4); 



