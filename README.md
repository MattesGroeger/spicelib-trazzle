spicelib-trazzle
================

This library provides a Trazzle appender for the Spicelib logging framework.

Spicelib
--------

Spicelib is an AS3 library that Parsley builds upon, but that can also be used separately. It contains a Logging Framework for Flash Applications.

[Product Website](http://www.spicefactory.org/parsley/)

Trazzle
-------

Trazzle is a console tool for debugging flash content on OS X.

[Product Website](http://www.nesium.com/products/trazzle)

Usage
-----

You can find a small demo in the "example" folder. 

In order to use the trazzle appender you have to put the two SWC files from the libs folder into your classpath.

To establish the connection to the logger application you have to call the initialize() method within the TrazzleAppender:

	var appender : TrazzleAppender = new TrazzleAppender(stage, "Logging Demo");
	appender.initialize();
	
