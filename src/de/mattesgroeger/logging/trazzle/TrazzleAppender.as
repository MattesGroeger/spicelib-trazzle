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
package de.mattesgroeger.logging.trazzle
{
	import flash.errors.IllegalOperationError;
	import com.nesium.logging.TrazzleLogger;

	import org.spicefactory.lib.flash.logging.Appender;
	import org.spicefactory.lib.flash.logging.FlashLogger;
	import org.spicefactory.lib.flash.logging.LogEvent;
	import org.spicefactory.lib.flash.logging.LogLevel;
	import org.spicefactory.lib.flash.logging.impl.AbstractAppender;

	import flash.display.Stage;
	import flash.utils.Dictionary;

	public class TrazzleAppender extends AbstractAppender implements Appender
	{
		private static var logLevelMap : Dictionary = new Dictionary();
		
		private var _stage : Stage;
		private var _title : String;
		
		private var trazzleLogger : TrazzleLogger;

		public function TrazzleAppender(stage : Stage = null, title : String = null)
		{
			this.stage = stage;
			this.title = title;
			
			logLevelMap[LogLevel.TRACE] = "";
			logLevelMap[LogLevel.DEBUG] = "d";
			logLevelMap[LogLevel.INFO] 	= "i";
			logLevelMap[LogLevel.WARN] 	= "w";
			logLevelMap[LogLevel.ERROR]	= "e";
			logLevelMap[LogLevel.FATAL] = "f";
		}

		public function get stage() : Stage
		{
			return _stage;
		}

		public function set stage(stage : Stage) : void
		{
			_stage = stage;
		}

		public function get title() : String
		{
			return _title;
		}

		public function set title(title : String) : void
		{
			_title = title;
		}
		
		[Init]
		public function initialize() : void
		{
			if (stage == null)
				throw new IllegalOperationError("Stage should not be null. Please set the stage attribute.");
			
			trazzleLogger = new TrazzleLogger();
			trazzleLogger.setParams(stage, title);
		}

		protected override function handleLogEvent(event : LogEvent) : void
		{
			if (event.level == LogLevel.OFF)
				return;

			var stackIndex : int = getStackIndexOffset(FlashLogger(event.currentTarget).name);
			var logLevelChar : String = logLevelMap[event.level];
			var logMessage : String = event.message;
			
			if (logLevelChar.length > 0)
				logMessage = logLevelChar + " " + logMessage;
			
			trazzleLogger.log(logMessage, stackIndex);
		}

		private function getStackIndexOffset(name : String) : int
		{
			var stacktrace : String = new Error().getStackTrace();
			var stack : Array = stacktrace.split("\n");
			
			for (var i : int = 0; i < stack.length; i++)
			{
				if (String(stack[i]).indexOf(name) >= 0)
					return i - 3;
			}
			
			return 0;
		}
	}
}