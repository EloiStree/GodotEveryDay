Python and Website succeed to have the webcam on PI 5 but not Godot 4.5.1.
At least without the CPP addons.

I will have to use python export or the CPP addons.


Should work on Quest3.. but not tutorial
https://github.com/j20001970/godot-cameraserver-extension/issues/9

------------

Doc
https://docs.godotengine.org/fr/4.x/classes/class_cameraserver.html

If you project can allows GDExtension for CPP
https://github.com/j20001970/godot-cameraserver-extension

Test your webcam
https://fr.webcamtests.com/


```
cat /etc/os-release
sudo apt full-upgrade -y
sudo apt update
sudo apt install -y libcamera0 libcamera-dev libcamera-apps
libcamera-hello
```

```
eloistree@eloistree:~ $ libcamera-hello
bash: libcamera-hello: command not found
```

```
sudo apt update
sudo apt install v4l-utils \
    gstreamer1.0-tools \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-libav
sudo apt install gstreamer1.0-plugins-*
```


------------


```
pip install opencv-python
```


---------------

```
extends Node

func _ready():
	print("Feed count:", CameraServer.get_feed_count())
	for i in range(CameraServer.get_feed_count()):
		var feed := CameraServer.get_feed(i)
		if feed:
			print("Feed", i, "->", feed.get_name(), "id:", feed.get_id())
		else:
			print("Feed", i, "is null")

```


