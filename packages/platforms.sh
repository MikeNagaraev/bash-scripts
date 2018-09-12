packages=(nodejs python3.7)
action=$([[ $1 = "-r" ]] && echo "remove" || echo "install")
for i in "${packages[@]}"
do
	sudo apt-get $action $i -f
done
