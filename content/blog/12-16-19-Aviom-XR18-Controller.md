---
title: "ESP8266 DIY XR18 Controller"
created_at: 2019-12-16
kind: article
---

<img src="/data/XR18_ESP8266/IMG_0286.JPG" alt="Overview Image"/>

 This is a project that I worked on this past summer, as I was looking for some simple and reliable physical controller for my XR18. I would love to get a X-Touch, but it costs more than the XR18, and I don't use it enough to justify the price. The PC Control App for it is great, but when you are in the middle of a show, nothing beats physical controls. This is not a perfect setup and is a but clunky to use, but it was fun to build, and I wanted to see what I could do with what parts I had on hand. It should work with any device in the X Air Family, and the Midas MR Family, but some channels/features may not work on the 12/16 channel models due to being designed for the XR18.

 For OSC(Open Sound Control) info I pulled heavily from [Behringer's OSC Control Info](https://behringerwiki.musictribe.com/index.php?title=OSC_Remote_Protocol), as well as [Patrick‐Gilles Maillot's Huge page of OSC documentation.](https://bf95dc13-a-62cb3a1a-s-sites.googlegroups.com/site/patrickmaillot/docs/X32-OSC.pdf?attachauth=ANoY7co2bQINyDVej0XI8b9gruG_PaSunneasJo6xVxfHcZrMV50ns06Z_a8No10eVFJDd4_geNLyexQrhiTWgK023Iwv0T4qj5-YzXdBN6WTYkXvtT5rc6GQnEV3NCnjL1jiCMqFUAFVjPl_3IV6cnyEHD4Nc_vCdZkHC9qn3UrMQB8QDpp5GkI9_WC6Xe1IwbJ8UFYplGzbQ_JRDzh6UNHlRG5ZnZDlg%3D%3D&attredirects=0)
 Other Links for pages I pulled from for info, [BCR2000 control of XR16 with Arduino](https://community.musictribe.com/t5/Recording/BCR2000-control-of-XR16-with-Arduino/td-p/220059/) and [https://community.musictribe.com/t5/Recording/DIY-WiFi-MIDI-Remote-control-box-for-X-AIR-WORKING/m-p/257791](https://community.musictribe.com/t5/Recording/DIY-WiFi-MIDI-Remote-control-box-for-X-AIR-WORKING/m-p/257791), as well as some other pages I cannot find at the moment, but can be found using a search engine. The code for this project is mostly written by me, but sections of it are pull from other people's sketches.
 
 I used a WEMOS D1 mini in this project to do pretty much everything, except for driving the LEDs, which are driven via a MAX7219. An old Aviom that was broken was reused for the case and knobs/buttons, as well as using part of the original circuit board for parts of the circuity. All of the buttons/knobs are original and still connected to the original board, but wires had to be connected to them directly, as well as some required traces to be cut. I have a wiring diagram in [This ZIP File](/data/XR18_ESP8266/Aviom_ESP8266_XAir.zip). The file also contains the Arduino sketch, as well as some other handy info. This project is not perfect, and the sketch has some bugs and quirks, but after using it for the past 6 months, has proven very stable in a variety of situations.

 As for button mapping, due to the lack of input pins, some compromises had to be made. The ESP32 would have an advantage due to having more input pins, or a matrix could have been setup for the 20 buttons, but I did not do it that way due to wanting to keep it simple, and lack of parts on hand. There is a Page Up button, a Page Down button, a channel select knob that allows you to scroll to the channel you want, a Volume knob, A Tap Tempo button, and a Mute button. The Tap Tempo button is set up to have the Stereo Delay Plugin in FX3, and is only changable in the sketch. There are two "pages" of buttons, Page 0 controls Channels 1-16, and page 1 controls The Aux input, FX1-4, DCAs 1-4, BUSes 1-6 and LR. The main issue I have is that the rotary controls are a bit finicky, and if turned too fast will go in a random direction, but it is not terrible. I have not found a solid workaround for this yet.

 There are a couple of "Features" built into some of the buttons. If you hold down the Page Up button for 2 seconds, you can change the selected channel's Pan using the Volume Knob. If you hold the Mute button for 3 seconds, any channel you select while holding the mute button will have it's Mute status inverted.
 If you hold down the Page Up, Page Down and Tap Tempo buttons for 10 seconds, it enters Network Config Mode and all of the LEDs come on. It causes the ESP8266 to create an Open WiFi Hotspot that you can open in a web browser(the IP address should be 192.168.1.1 unless already connected to another network that used a different IP range, which it remembers and re-uses, and will always be <code>*.*.*.1</code>), and configure the WiFi network to connect to, as well as the IP Address of your X Air/MR Mixer. If the controller fails to connect to the WiFi Network, it will just recreate the hotspot and let you re-enter your details. If it fails to connect to the Mixer but still connects to the network all of the Mute Lights and the Tap Tempo light will be on, and nothing will work. I do not have any sort of error correction/ping set up, so if the mixer goes down, the controller has no way of displaying the issue, it just stops responding untill the mixer is re-connected.
 For the Aviom enclosure, I masked off the lower black plastic around the buttons, sanded the surface slightly to help the paint adhere and remove the letters, then painted it with a couple coats of Glossy Black paint. The paint took a good week to dry fully, and now it looks *much* better than that ugly old blue. The labels are just printed off onto plain paper, cut out and taped onto the case, and they work really well.

 The WEMOS D1 mini is directly accessible from the back, so updating the sketch is just a matter of plugging it in to a Micro-USB cable. The "1 PSU Only" notice is to remind myself that if I power it via the 5V DC Jack, it will put power back out the Micro-USB Port, and vice-versa. Don't want to cook something major like my computer.

<img src="/data/XR18_ESP8266/IMG_0285.JPG" alt="Image of Back of Controller"/>

 In [This ZIP File](/data/XR18_ESP8266/Aviom_ESP8266_XAir.zip) I have the Sketch, as well as a wiring diagram, and some other helpful files. I used the Ground Plane on the Aviom Board to my advantage, so I did not have to run ground wires to all of the switches/rotary encoders, and just wired the WeMos D1's ground to the same ground plane. Some of the traces had to be cut for the switches because the old circuitry was causing both sides of the switches to be pulled low constantly, vs just when depressed. As for the LEDs, the Aviom board already has them set up in a 8 by 8 matrix, so it was just a matter of tacking the right wires onto the right pads, which was rather simple. There is alot of documentation on the MAX7219 online for wiring, and I have the diagram shown in the files as well. I put my MAX7219 on a daughter board with 5 wires going to the ESP8266 for power and data, and it tucks nicely in the case. It is a textbook use case for the MAX7219.

<img src="/data/XR18_ESP8266/IMG_0279.JPG" alt="Overall Image of Circuit Board"/>
<br><code> Yeah... lets put the cover back on it. </code>

<img src="/data/XR18_ESP8266/IMG_0280.JPG" alt="Image of Daughter Board with MAX7219 Chip"/>
<br><code> The daughter board with the MAX7219. Pretty, right? Wrong. But hey, it gets covered up anyways... </code>

<img src="/data/XR18_ESP8266/IMG_0281.JPG" alt="Another Image of Daughter Board with MAX7219 Chip"/>
<br><code> Close up of the Daughter board. Yes, I put insulating tape around it so nothing shorts out. </code>

<img src="/data/XR18_ESP8266/Wiring.png" alt="Image of Wiring Diagram"/>
<br><code> Hmm, hopefully I did not miss anything in this diagram.</code>

I snipped off the original A-Net Riser board from the Aviom, and managed to hook my proto-board onto some of the pins, specifically the ground plane pins.
<img src="/data/XR18_ESP8266/IMG_0282.JPG" alt="Image of Wiring Diagram"/>
<br><code> Look, another custom daughter board!</code>

 I had to remove the extra spacer and trim the legs on my WEMOS D1 mini to get it to sit low enough that I can plug a Micro-USB cable into the port with the case assembled.

<img src="/data/XR18_ESP8266/IMG_0283.JPG" alt="Image Of ESP8266"/>

And here is a video if it in action! In this video the control is quite fluid, but if there is alot of WiFi traffic going on, or I am far away from the AP, usage may be "choppy". I have never had an issue with it, but I do have a seperate AP set up in my rack that is dedicated to the XR18, and a couple of WiFI-phone controlled Aux Mixes.
 <video width="640" height="480" controls>
  <source src="/data/XR18_ESP8266/Video.mp4" type="video/mp4">
</video>


