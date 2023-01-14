# WiFi Camera: Visualizing the 2.4GHz band (WiFi) of the electromagnetic spectrum

Visit http://www.wifiimagingcamera.com/ for more information about the project and sample WiFi images!

## About the project
The WiFi Camera is a camera that allows users to visualize the 2.4 GHz frequency band for wireless 802.11 communication into a 2D image. It is similar in concept to images from Charged Couple Devices or X-ray imaging.

For years, humans have utilized the visible spectrum of the electromagnetic spectrum to see things, and in the last few decades, scientists have employed infrared and ultraviolet telescopes to be able to view the natural world in those spectrums.

We realized that it would be very helpful to be able to "see" rooms through Wi-Fi signals just like doctors and scientists can see x-rays and distant galaxies. After all, the WiFi signals are just another part of the electromagnetic spectrum.

We created a camera consisting of two parts, a cantenna, and the tripod/motor. The cantenna is made of a can, insulated within aluminum (the metal insulation on the sides makes the overall antenna more directional, meaning it takes measurements only in front of it. We could have used more aluminum to secure it further, but it would affect the torque of the motor). Inside the can is a radio transceiver that is responsible for actually measuring the signal strength data and then sending it to a computer program called Homedale, which logs the data in equal time intervals.

Initially we used a WiFi adapter, but then to increase pixels of our finished images, we created a second version of the camera, which was the same can concept, except we created our own antenna, made of an Arduino board (basically a microprocessor that we programmed to interface with a radio transceiver), and the radio transceiver, a Nordic nRF24L01+.

To display the data in an image format, we converted the data collected using the red part of the RGB color scale which is a mathematical scale that relates the saturation of the color red (and green and blue) with a value from 0-255. All black is 0 which corresponds to a weak signal and all red is 255 which is a strong signal.

This device has a lot of research and practical potential and applications. The WiFi Camera can be used for both WiFi optimization and security. As for optimization, the camera can be used to find the places with the best signals and material that best leaks or even optimizes WiFi signals, and certain equipment can be placed nearby such places or with such material.

## The code

The Arduino code powering the nRF24L01 is called "Arduino_nRF24L01.cc" and the Processing code that processes the log files and returns a viewable image is called "Wifi_Image_Processing.pde".

To test the code, sample logs are provided in the folder: "SampleLogs", with two measurements each for angles 70, 80, 90, 100, 110 degrees from the horizontal. The corresponding picture is "Sample Output Image.png".

More WiFi images can be found at http://www.wifiimagingcamera.com/.
