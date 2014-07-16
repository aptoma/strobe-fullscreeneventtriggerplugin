Strobe fullscreen event trigger
===============================

A Strobe/OSMF plugin that registers a callback function for listening to fullscreen event from javascript

NB: If you are working on a development server you may need to set up [ssh-agent-forwarding](https://developer.github.com/guides/using-ssh-agent-forwarding/)

####How to integrate it with the DrVideo JSAPI
    
see: [index.template.html 
example](http://github.com/aptoma/strobe-fullscreeneventtrigger/blob/master/html-template/index.template.html "example")    

####Building the plugin with mxmlc

Download and install flex with the [flex installer](https://github.com/aptoma/flex-installer "Flex installer") (ubuntu only, see [Flex installer README](https://github.com/aptoma/flex-installer) for how to install flex on Mac OSX and Windows)

From the root directory of this repository. Do the following from the terminal:

    mxmlc src/FullscreenEventTriggerPlugin.as -library-path+=libs -sp="src/" -static-link-runtime-shared-libraries=true -o bin-debug/FullscreenEventTriggerPlugin.swf

For testing you can set up a vhost and point it to the bin-debug folder. Copy the following files to the bin-debug folder if not 
allready there.

    cp html-template/StrobeMediaPlayback.swf bin-debug/
    cp html-template/crossdomain.xml bin-debug/
    cp html-template/index.template.html bin-debug/index.html
    
You need to edit the html file and replace the domain name localhost with the name of your vhost

If you want to just work in a folder directly on the root of your webserver you can do this:

    # Assumming /var/www is the root of your webserver
    sudo su
    mkdir /var/www/FullscreenEventTriggerPlugin
    cp -r bin-debug/*  /var/www/FullscreenEventTriggerPlugin/
    
####Documentation

More documentation can be found at the [DrVideo wiki](https://sites.google.com/a/aptoma.com/drvideo/home/software-components/common/osmf "OSMF/StrobeMediaPlayback")
