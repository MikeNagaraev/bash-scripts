packages=(sublime-text atom)
action=$([[ $1 = "-r" ]] && echo "remove" || echo "install")

echo "Choose package(s) number(s) to" ${action}

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
	sudo apt-get $action $packages_to_action[${p}] -f
done
