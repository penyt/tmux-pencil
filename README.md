# tmux-pencil

This is a tool that can let you set your tmux config easily.


```
tmux new-session -d -s tpen -n setup \; \
	set-option -t tpen:0 remain-on-exit on \; \
	new-window -n demo \; \
	select-window -t tpen:0 \; \
	attach-session -t tpen
```
