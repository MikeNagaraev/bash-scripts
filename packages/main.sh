for file in ./*.sh
do
	if [ $file != "./main.sh" ]; then
		$file
	fi
done
