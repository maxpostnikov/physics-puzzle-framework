package ru.maxpostnikov.engine 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import ru.maxpostnikov.engine.core.Loop;
	import ru.maxpostnikov.engine.entities.IProcessable;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class Engine 
	{
		
		public static const RATIO:Number = 30;
		
		private const _BORDER_WIDTH:Number = 0;
		private const _BORDER_HEIGHT:Number = 0;
		
		private var _loop:Loop;
		private var _width:Number;
		private var _height:Number;
		private var _isDebuged:Boolean;
		private var _isPaused:Boolean;
		
		private static var _instance:Engine;
		
		public function Engine(singleton:PrivateClass) 
		{
			_instance = this;
		}
		
		public static function getInstacne():Engine 
		{
			return (_instance) ? _instance : new Engine(new PrivateClass());
		}
		
		public function launch(container:DisplayObjectContainer):void 
		{
			_loop = new Loop(container, RATIO);
			
			_width = container.stage.stageWidth + _BORDER_WIDTH;
			_height = container.stage.stageHeight + _BORDER_HEIGHT;
		}
		
		public function process(object:IProcessable):void 
		{
			if (_loop.queue.indexOf(object) < 0) _loop.queue.push(object);
		}
		
		public function pause():void 
		{
			if (_isPaused) {
				_loop.start();
				
				_isPaused = false;
			} else {
				_loop.stop();
				
				_isPaused = true;
			}
		}
		
		public function debug():void 
		{
			if (_isDebuged)
				_isDebuged = false;
			else
				_isDebuged = true;
			
			_loop.debug(_isDebuged);
		}
		
		public function get width():Number { return _width; }
		
		public function get height():Number { return _height; }
		
		public function get isPaused():Boolean { return _isPaused; }
		
	}

}

class PrivateClass
{
	public function PrivateClass():void 
	{
		trace("Engine instantiated.");
	}
}