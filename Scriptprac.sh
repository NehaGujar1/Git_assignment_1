#!/bin/bash
echo "Choose any of the given GPG keys, otherwise enter 0"
key=$(gpg --list-secret-keys --keyid-format=LONG | awk '/sec/{if (length($2)>0) print $2}')
arrn=($key)
key2=$(gpg --list-secret-keys --keyid-format=LONG | awk '/uid/{if (length($3)>0) print $3 }')
len=`expr length "$key2"`
keycopy="$key2"
arr=($keycopy)
leng=${#arr[@]}
for ((p=0;p<$leng;p=p+1))
do 
q=$((p+1))
echo "$q ${arr[$p]}"
done
read var1
publickey(){
    gpg --armor --export $1
    git config --global user.signingkey $1
    echo "GPG Sign-in done"
}
if [[ $var1 == 0 ]];
then
{
    gpg --default-new-key-algo rsa4096 --gen-key
    keynew=$(gpg --list-secret-keys --keyid-format=LONG | awk '/sec/{if (length($2)>0) print $2}')
    arrnew=($keynew)
    varnew=${arrnew[$leng]}
    publickey "$varnew"
}
elif [[ $var1 > leng ]]
then
    echo "Incorrect input"
else {
var1=$(($var1-1))
var2=${arrn[$var1]}
var3="rsa4096/"
var4=${var2#"$var3"}
publickey "$var4"
}
fi

