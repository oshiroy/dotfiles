#!/usr/bin/env sh

sudo apt-get install -y fontforge

mkdir $HOME/.dotfiles/gen_fonts
cd gen_fonts
GENFONTS=$HOME/.dotfiles/gen_fonts

# download nessesary files
wget http://levien.com/type/myfonts/Inconsolata.otf
wget http://iij.dl.sourceforge.jp/mix-mplus-ipa/59022/migu-1m-20130617.zip
unzip migu-1m-20130617.zip
rm migu-1m-20130617.zip
git clone https://github.com/yascentur/Ricty.git
# git clone https://github.com/Lokaltog/powerline.git
git clone https://github.com/powerline/fontpatcher.gi


cd Ricty
./ricty_generator.sh $GENFONTS/Inconsolata.otf $GENFONTS/migu-1m-20130617/migu-1m-regular.ttf $GENFONTS/migu-1m-20130617/migu-1m-bold.ttf
mv Ricty*.ttf $HOME/.fonts
fc-cache -fv

cd $GENFONTS/powerline


cd $GENFONTS
fontforge -script $GENFONTS/fontpatcher/scripts/powerline-fontpatcher $HOME/.fonts/Ricty-Regular.ttf
fontforge -script $GENFONTS/fontpatcher/scripts/powerline-fontpatcher $HOME/.fonts/Ricty-Bold.ttf

for f in *.ttf
do
    mv -i "$f" "$(echo $f | sed -e 's/\s\+/_/g')"
done

cp Ricty_Bold_for_Powerline.ttf ~/.fonts
cp Ricty_Regular_for_Powerline.ttf ~/.fonts
fc-cache -fv
