# Tmux configuration setup script -- tmux-pencil
[繁體中文 zh-tw](https://github.com/penyt/tmux-pencil/blob/main/README-zh-tw.md)

This is a tool that can helps you set your tmux configuration easily. Just follow the instructions, and a kick-start .tmux.conf will be created.

`tmux-pencil` only modifies your .tmux.conf or creates a backup file, you can edit it afterward as needed.

![tmux-pencil-logo](https://myrr.penli.quest/content/tmux-pencil/tmux-pencil-logo-text-trans.webp)

# Usage

## 1. Setup tmux session environment
Since we're configuring tmux, it's recommended to stay inside a tmux session so that you can see most of the effects immediately.

The command below will create a new session (`tpen`) with two windows (`setup` & `demo`), as some effects require multiple windows to demonstrate properly:

```sh
tmux -f /dev/null new-session -d -s tpen -n setup \; \
	set-option -t tpen:setup remain-on-exit on \; \
	new-window -n demo \; \
	select-window -t tpen:setup \; \
	attach-session -t tpen
```


## 2. Download & Set permission
While in the tmux session, download the script to your home directory. You can delete it afterward.
```sh
curl -o tmux-pencil.sh https://raw.githubusercontent.com/penyt/tmux-pencil/refs/heads/main/tmux-pencil.sh
```
Of course, you can also copy and paste the script contents manually.

Then,
make the script executable:
```sh
chmod +x tmux-pencil.sh
```


## 3. Run the script
```
./tmux-pencil.sh
```

## 4. Configure
Follow the on-screen instructions to configure your tmux settings.

## 5. Finish
You can now see your new `.tmux.conf` in your home directory.
```sh
cat ~/.tmux.conf
```

If you no longer need the script, feel free to delete it:
```sh
rm tmux-pencil.sh
```

# Support & Donate
Thanks for using tmux-pencil! Don’t forget to ⭐️ the repo if you like it.

<a href="https://www.buymeacoffee.com/penyt" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-blue.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>

