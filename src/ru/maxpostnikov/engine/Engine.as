package ru.maxpostnikov.engine 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Point;
	import ru.maxpostnikov.engine.core.KeyInput;
	import ru.maxpostnikov.engine.core.Loop;
	import ru.maxpostnikov.engine.core.Cookie;
	import ru.maxpostnikov.engine.core.Levels;
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
		private var _cookie:Cookie;
		private var _levels:Levels;
		private var _keyInput:KeyInput;
		
		private var _width:Number;
		private var _height:Number;
		private var _isPaused:Boolean;
		private var _isDebuged:Boolean;
		private var _isDebugAllowed:Boolean;
		
		private static var _instance:Engine;
		
		public function Engine(singleton:PrivateClass) 
		{
			_instance = this;
		}
		
		public static function getInstacne():Engine 
		{
			return (_instance) ? _instance : new Engine(new PrivateClass());
		}
		
		public function launch(container:DisplayObjectContainer, cookieName:String, debug:Boolean = false):void 
		{
			_loop = new Loop(container, RATIO);
			_cookie = new Cookie(cookieName);
			_levels = new Levels(container);
			_keyInput = new KeyInput(container);
			
			load();
			
			_isDebugAllowed = debug;
			_width = container.stage.stageWidth + _BORDER_WIDTH;
			_height = container.stage.stageHeight + _BORDER_HEIGHT;
		}
		
		public function process(object:IProcessable):void 
		{
			if (_loop.queue.indexOf(object) < 0) _loop.queue.push(object);
		}
		
		public function win():void 
		{
			_levels.currentLevelData.passed();
			
			save();
		}
		
		public function reset():void 
		{
			_levels.resetLevels();
			
			save();
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
			
			_levels.pause();
		}
		
		public function debug():void 
		{
			if (_isDebuged)
				_isDebuged = false;
			else
				_isDebuged = true;
			
			_loop.debug(_isDebuged);
		}
		
		private function load():void 
		{
			var data:Object = _cookie.load();
			
			if (data) {
				_levels.load(data.levels);
			} else {
				save();
			}
		}
		
		private function save():void 
		{
			_cookie.save( { levels:_levels.save() } );
		}
		
		public function get width():Number { return _width; }
		
		public function get height():Number { return _height; }
		
		public function get isPaused():Boolean { return _isPaused; }
		
		public function get isDebugAllowed():Boolean { return _isDebugAllowed; }
		
		public function get levels():Levels { return _levels; }
		
	}

}

class PrivateClass { public function PrivateClass():void { trace("Engine instantiated."); } }