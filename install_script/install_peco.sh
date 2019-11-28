# tarファイルをダウンロード
wget "https://github.com/peco/peco/releases/download/v0.5.1/peco_linux_386.tar.gz"
tar xfvz peco_linux_386.tar.gz 
cd peco_linux_386
chmod +x peco
# PATHの通っている所にpecoを配置
sudo cp peco /usr/local/bin
echo "install peco to /usr/local/bin"
cd ..
# remove
rm -rf peco_linux_386.tar.gz peco_linux_386
echo "rm peco installer"
