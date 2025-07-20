# Tmux 設定腳本工具 —— tmux-pencil
[英文 English](https://github.com/penyt/tmux-pencil/blob/main/README.md)

`tmux-pencil` 是一個能幫助你輕鬆建立 tmux 設定檔（`.tmux.conf`）的小工具。只需依照指引操作，即可快速生成一份啟動用的 `.tmux.conf` 設定檔。

此工具僅會修改你的 `.tmux.conf` 檔案，或建立備份檔。完成後你可以再自行手動編輯添加或刪除任何設定。

![tmux-pencil-logo](https://myrr.penli.quest/content/tmux-pencil/tmux-pencil-logo-text-trans.webp)

# 使用方式

## 1. 建立 tmux 工作環境

由於此工具會即時設定 tmux，建議先進入 tmux session 再執行腳本，這樣大部分變化會立刻生效，可以有更好的視覺體驗。

以下指令會建立一個名為 `tpen` 的 tmux session，並開啟兩個視窗（`setup` 和 `demo`）。這樣設置是因為有些效果需要在多個視窗中才能完整呈現：
```sh
tmux -f /dev/null new-session -d -s tpen -n setup \; \
  set-option -t tpen:setup remain-on-exit on \; \
  new-window -n demo \; \
  select-window -t tpen:setup \; \
  attach-session -t tpen
```

## 2. 下載腳本並設定執行權限

在 tmux session 中，將腳本下載至你的家目錄中。使用完畢後可自行刪除。
```sh
curl -o tmux-pencil.sh https://raw.githubusercontent.com/penyt/tmux-pencil/refs/heads/main/tmux-pencil.sh
```
你也可以直接複製並貼上腳本內容。

然後，設定腳本，使它具有執行權限：
```sh
chmod +x tmux-pencil.sh
```

## 3. 執行腳本
```
./tmux-pencil.sh
```

## 4. 進行設定
根據執行時的提示一步一步完成 tmux 設定。

## 5. 完成
完成後，你的家目錄中會出現一份新的 .tmux.conf 設定檔：
```sh
cat ~/.tmux.conf
```

若已無需使用此腳本，可以刪除它：
```sh
rm tmux-pencil.sh
```

# 支持＆贊助

如果你覺得這個工具對你有幫助，歡迎給我們一個 GitHub ⭐️，非常感謝！

<a href="https://www.buymeacoffee.com/penyt" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-blue.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>

