#!/bin/bash

FILES_DIR="$HOME/dotfiles/files"

cd "$HOME"

# filesフォルダ内のファイルとディレクトリを再帰的に処理
find "$FILES_DIR" -type f -o -type d | while read -r src; do

    # filesフォルダのパスを取り除いてリンク先のパスを作成
    dest="${src#$FILES_DIR/}"

    # srcがファイルの場合のみ処理を行う
    if [ -f "$src" ]; then
        # リンク先のディレクトリが存在しない場合は作成
        mkdir -p "$(dirname "$dest")"

        # シンボリックリンクを作成
        ln -s "$(realpath "$src")" "$HOME/$dest"
    fi
done