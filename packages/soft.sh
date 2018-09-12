# ATOM: wget -O atom-amd64.deb https://atom.io/download/deb
# SUBLIME 1) wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add - 
# SUBLIME 2) sudo apt-add-repository "deb https://download.sublimetext.com/ apt/stable/"
packages=(sublime-text atom)
action=$([[ $1 = "-r" ]] && echo "remove" || echo "install")

echo "Choose package(s) number(s) to" ${action}

action_sublime() {
        if [[ $action -eq "install" ]]; then
        	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add - 
		sudo apt-add-repository "deb https://download.sublimetext.com/ apt/stable/"
	fi
}

action_atom() {
        if [[ $action -eq "install" ]]; then
        	wget -O atom-amd64.deb https://atom.io/download/deb
	fi
}


for ((i=0;i<${#packages[@]};i++)) do
	pos=$(($i + 1 ))
	echo $pos. ${packages[$i]}
done
echo 0. All packages

read package_numbers
packages_to_action=()
for j in $package_numbers
do
	if [ $j -eq 0 ]; then
		packages_to_action=${packages[@]}
		break	
	fi
	n=$(($j - 1))
	packages_to_action+=(${packages[$n]})
done
echo This packages will be $action: ${packages_to_action[@]}

for p in packages_to_action
do
	pack=${packages_to_action[${p}]}
	echo $pack
	if [[ $pack = "sublime-text" ]]; then
		action_sublime
	elif [[ $pack = "atom" ]]; then
		action_atom
	fi
	sudo apt-get $action $pack -f
done

