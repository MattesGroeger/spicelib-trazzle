/*
* Copyright (c) 2010 Mattes Groeger
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/
package de.mattesgroeger.logging
{
	import de.mattesgroeger.logging.trazzle.TrazzleAppender;

	import org.spicefactory.lib.flash.logging.FlashLogFactory;
	import org.spicefactory.lib.flash.logging.impl.DefaultLogFactory;
	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.Logger;

	import flash.display.Sprite;

	public class LoggingDemo extends Sprite
	{
		private static var log : Logger;
		
		public function LoggingDemo()
		{
			initializeLogging();
			testLogMessages();
		}

		private function initializeLogging() : void
		{
			var logFactory : FlashLogFactory = new DefaultLogFactory();
			
			var appender : TrazzleAppender = new TrazzleAppender(stage, "Logging Demo");
			appender.initialize();
			
			logFactory.addAppender(appender);

			LogContext.factory = logFactory;
			
			log = LogContext.getLogger(LoggingDemo);
		}

		private function testLogMessages() : void
		{
			log.trace("trace");
			log.debug("debug");
			log.info("info");
			log.warn("warn");
			log.error("error");
			log.fatal("fatal");
		}
	}
}