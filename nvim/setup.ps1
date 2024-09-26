# Windows上でNeovimの設定ファイルを配置
# 実行には管理者権限が必要
New-Item -ItemType SymbolicLink -Path $HOME\AppData\Local\nvim -Target $HOME\dotfiles\nvim
