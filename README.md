Strobe fullscreen event trigger
===============================

A Strobe/OSMF plugin that registers a callback function for listening to fullscreen event from javascript


####How to integrate it with Strobe - OSMF 
    
    see: [index.template.html 
example](http://github.com/aptoma/strobe-fullscreeneventtrigger/blob/master/html-template/index.template.html "example")    

####Building the plugin with mxmlc

Download and install flex installer (ubuntu only) https://github.com/johansyd/flex-installer

From the root directory of this repository. Do the following from the terminal:
    mxmlc -library-path+=lib -source-path src/ -output bin-debug/FullscreenEventTriggerPlugin.swf src//FullscreenEventTriggerPlugin.as

For testing you can set up a vhost and point it to the bin-debug folder. Copy the following files to the bin-debug folder if not 
allready there.
    cp html-template/StrobeMediaPlayback.swf bin-debug/
    cp html-template/crossdomain.xml bin-debug/
    cp html-template/index.template.html bin-debug/FullscreenEventTriggerPlugin.html

