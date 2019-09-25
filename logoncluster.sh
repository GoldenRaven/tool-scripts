#!/bin/sh
#ssh ligy09@210.26.51.126 -p 9134 -t 'tmux list-session; if [[ $? -eq  0 ]]; then tmux attach; else tmux;fi'
ssh -X ligy09@210.26.51.126 -p 9135
exit 0
