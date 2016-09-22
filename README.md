Strobe fullscreen event trigger
===============================

A Strobe/OSMF plugin that registers a callback function for listening to fullscreen event from javascript

NB: If you are working on a development server you may need to set up [ssh-agent-forwarding](https://developer.github.com/guides/using-ssh-agent-forwarding/)

####Building the plugin with mxmlc

Download and install flex with the [flex installer](https://github.com/johansyd/flex-installer "Flex installer") (ubuntu only, see [Flex installer README](https://github.com/aptoma/flex-installer) for how to install flex on Mac OSX and Windows)

From the root directory of this repository. Do the following from the terminal:

    mxmlc src/FullscreenEventTriggerPlugin.as -library-path+=libs -sp="src/" -static-link-runtime-shared-libraries=true -o bin-debug/FullscreenEventTriggerPlugin.swf

For testing you can set up a vhost and point it to the bin-debug folder. Copy the following files to the bin-debug folder if not 
allready there.

    cp html-template/StrobeMediaPlayback.swf bin-debug/
    cp html-template/crossdomain.xml bin-debug/
    
You need to setup a html file see [Using plug-ins](http://help.adobe.com/en_US/FMPSMP/Dev/WS3fd35e178bb08cb33ccc1b6f129f146edb7-7fff.html) for more information on how to add the strobe-fullscreeneventtriggerplugin to strobe. Add the html file to bin-debug

If you want to just work in a folder directly on the root of your webserver you can do this:

    # Assumming /var/www is the root of your webserver
    sudo su
    mkdir /var/www/FullscreenEventTriggerPlugin
    cp -r bin-debug/*  /var/www/FullscreenEventTriggerPlugin/
    # Add a html file with an object tag like [this](http://help.adobe.com/en_US/FMPSMP/Dev/WS3fd35e178bb08cb33ccc1b6f129f146edb7-7fff.html) 

####Debugging

If you want firebug/chrome style debugging you can do the following:

    # Calls console.log
    console.log("Hello Foxy lady");
    # calls console.error
    console.error("Hello Foxy lady");
    # creates a javascript alert box (does not require firebug or chrome)
    console.alert("Hello Foxy lady");

I have mentinoned some possibilities in the [flex installer README](https://github.com/johansyd/flex-installer "Flex installer") if you want other tools.

####Documentation

More documentation can be found at the [help adobe](http://help.adobe.com/en_US/FMPSMP/Dev/index.html "OSMF/StrobeMediaPlayback")
