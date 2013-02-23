package ru.maxpostnikov.engine 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.media.Sound;
	import ru.maxpostnikov.engine.core.KeyInput;
	import ru.maxpostnikov.engine.core.Loop;
	import ru.maxpostnikov.engine.core.Cookie;
	import ru.maxpostnikov.engine.core.Levels;
	import ru.maxpostnikov.engine.core.Sounds;
	import ru.maxpostnikov.engine.entities.IProcessable;
	import ru.maxpostnikov.engine.ui.Canvas;
	import ru.maxpostnikov.engine.ui.screens.ScreenMainMenu;
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
		private var _sounds:Sounds;
		private var _cookie:Cookie;
		private var _levels:Levels;
		private var _canvas:Canvas;
		private var _keyInput:KeyInput;
		
		private var _width:Number;
		private var _height:Number;
		private var _isMuted:Boolean;
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
			_sounds = new Sounds();
			_cookie = new Cookie(cookieName);
			_levels = new Levels(container);
			_canvas = new Canvas(container);
			_keyInput = new KeyInput(container);
			
			load();
			
			_isDebugAllowed = debug;
			_width = container.stage.stageWidth + _BORDER_WIDTH;
			_height = container.stage.stageHeight + _BORDER_HEIGHT;
			
			_canvas.showScreen(ScreenMainMenu.ID);
		}
		
		public function process(object:IProcessable):void 
		{
			if (_loop.queue.indexOf(object) < 0) _loop.queue.push(object);
		}
		
		public function playSound(sound:Sound, loops:int = int.MAX_VALUE):void 
		{
			_sounds.play(sound, loops);
		}
		
		public function stopSound(sound:Sound):void 
		{
			_sounds.stop(sound);
		}
		
		public function openLevel(level:int):void 
		{
			_levels.addLevel(level);
			save();
		}
		
		public function openLastLevel():void 
		{
			_levels.addLevel(_levels.lastLevel);
			save();
		}
		
		public function openNextLevel():void 
		{
			_levels.nextLevel();
			save();
		}
		
		public function openPrevLevel():void 
		{
			_levels.prevLevel();
		}
		
		public function restartLevel():void 
		{
			_levels.restartLevel();
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
				if (!_isMuted) 
					_sounds.mute(false);
				
				_isPaused = false;
			} else {
				_loop.stop();
				_sounds.mute(true);
				
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
		
		public function mute():void 
		{
			if (_isMuted)
				_isMuted = false;
			else
				_isMuted = true;
			
			_sounds.mute(_isMuted);
		}
		
		private function load():void 
		{
			var data:Object = _cookie.load();
			
			if (data) _levels.load(data.levels);
		}
		
		private function save():void 
		{
			_cookie.save( { levels:_levels.save() } );
		}
		
		public function get width():Number { return _width; }
		
		public function get height():Number { return _height; }
		
		public function get isPaused():Boolean { return _isPaused; }
		
		public function get isDebugAllowed():Boolean { return _isDebugAllowed; }
		
	}

}

class PrivateClass { public function PrivateClass():void { trace("Engine instantiated."); } }