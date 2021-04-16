# Last modified: 23 February 2019
#
# Based on tmux: productive mouse-free development
#################################################

# Change prefix to C-a
unbind C-b
set -g prefix C-a
bind C-a send-prefix

# Shorten tmux delay
set -sg escape-time 50

# Index windows and panes to 1 instead of 0
set -g base-index 1
set -g pane-base-index 1

# Set shortcut so Prefix r reloads config file
bind r source-file ~/.tmux.conf \; display "Reloaded"

# Splitting panes
bind | split-window -h
bind - split-window -v

# Movement like vim
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

bind -r C-h select-window -t :-
bind -r C-l select-window -t :+

# Resizing panes
bind -r H resize-pane -L 5
bind -r J resize-pane -D 5
bind -r K resize-pane -U 5
bind -r L resize-pane -R 5

# Mouse
setw -g mouse on

# All the colors
set -g default-terminal "screen-256color"

# Colors
set -g status-bg black

setw -g monitor-activity on
set -g visual-activity on
set -g message-fg white
set -g message-bg default
set -g message-attr bright

# Time and date
set -g status-right "#[fg=colour170]%d %b %R"
set -g status-interval 60

# Status left side
set -g status-left-length 40
set -g status-left "#[fg=colour245]Session: #S #[g=colour145]#I #[fg=colour75]#P"

# window pane center and blue
set -g status-justify centre
setw -g window-status-fg colour75
setw -g window-status-bg default
setw -g window-status-attr dim

# active and inactive panes
set -g window-style 'fg=colour247,bg=colour236'
set -g window-active-style 'fg=colour250,bg=black'
set -g pane-border-bg colour75
set -g pane-border-bg black
set -g pane-active-border-fg colour75
set -g pane-active-border-bg black

# Vim mode for navigating text
setw -g mode-keys vi

# Make it so up and down arrows pop out and in windows
unbind Up
bind Up new-window -d -n tmp \; swap-pane -s tmp.1 \; select-window -t tmp

unbind Down
bind Down last-window \; swap-pane -s tmp.1 \; kill-window -t tmp
© 2021 GitHub, Inc.
Terms
Privacy
Security
Status
Docs
Contact GitHub
Pricing
API
Training
Blog
About
