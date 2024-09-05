#!/bin/sh

# Generate files for the dotfile repository.
# Usage: ./gentemplate.sh dirname

dirname=$1
# Check the argument.
if [ -z $dirname ]; then
    echo "Error: There is no argument: Usage './gentemplate.sh dirname'" 1>&2
    exit 1
fi
if [ -d ./$dirname ]; then
    echo "Error: The dir ${dirname} has been exist" 1>&2
    exit 1
fi

mkdir $dirname
LF='
'
# Make README.md file with template
echo "# ${dirname} 設定ファイル${LF}${LF}## ファイル構成${LF}${LF}### 環境依存ファイル" > $dirname/README.md
# Make .gitignore file with template
echo "# .gitignore${LF}*${LF}${LF}# Whitelist${LF}!.gitignore${LF}!README.md${LF}!setup.sh${LF}!" > $dirname/.gitignore
# Make setup.sh file with template
echo "#!/bin/sh${LF}${LF}# Make simbolic link for ${dirname} settings${LF}ln -s ~/dotfiles/${dirname} ~/.config/${dirname}" > $dirname/setup.sh
chmod 755 $dirname/setup.sh
