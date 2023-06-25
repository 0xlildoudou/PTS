install:
	sudo cp ./wh.sh /usr/local/bin/wh
	sudo chmod 755 /usr/local/bin/wh
	mkdir ~/.pts
	cp ./WEBHOOK.txt ~/.pts/WEBHOOK.txt