package ru.maxpostnikov.engine 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.media.Sound;
	import ru.maxpostnikov.engine.core.KeyInput;
	import ru.maxpostnikov.engine.core.Loop;
	import ru.maxpostnikov.engine.core.Cookie;
	import ru.maxpostnikov.engine.core.Levels;
	import ru.maxpostnikov.engine.core.Sounds;
	import ru.maxpostnikov.engine.ui.Canvas;
	import ru.maxpostnikov.engine.entities.IProcessable;
	import ru.maxpostnikov.engine.ui.screens.ScreenBack;
	import ru.maxpostnikov.engine.ui.screens.ScreenMainMenu;
	import ru.maxpostnikov.engine.ui.screens.ScreenPause;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class Engine 
	{
		
		public static const RATIO:Number = 30;
		
		private const _BORDER_WIDTH:Number = 50;
		private const _BORDER_HEIGHT:Number = 50;
		
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
		private var _isPausedLoop:Boolean;
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
			
			container.addEventListener(Event.DEACTIVATE, onDeactivate);
		}
		
		public function process(object:IProcessable):void 
		{
			if (_loop.queue.indexOf(object) < 0) _loop.queue.push(object);
		}
		
		public function removeFirstEntityOfType(type:Class):void 
		{
			var length:int = _levels.level.numChildren;
			for (var i:int = 0; i < length; i++) {
				var entity:IProcessable = _levels.level.getChildAt(i) as IProcessable;
				
				if (entity is type) {
					entity.remove();
					break;
				}
			}
		}
		
		public function playSound(sound:Sound, loops:int = int.MAX_VALUE):void 
		{
			_sounds.play(sound, loops);
		}
		
		public function stopSound(sound:Sound):void 
		{
			_sounds.stop(sound);
		}
		
		public function showScreen(id:String, data:Object = null):void 
		{
			if (id == ScreenMainMenu.ID) {
				_canvas.showScreen(ScreenBack.ID);
				
				if (_levels.lastLevel > 1) data = { isResumed:true };
			}
			
			_canvas.showScreen(id, data);
		}
		
		public function updateScreen(id:String, data:Object):void 
		{
			_canvas.updateScreen(id, data);
		}
		
		public function hideScreen(id:String):void 
		{
			_canvas.hideScreen(id);
		}
		
		public function openLevel(level:int):void 
		{
			if (_isPausedLoop) pauseLoop();
			
			_levels.addLevel(level);
			save();
		}
		
		public function openLastLevel():void 
		{
			openLevel(_levels.lastLevel);
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
		
		public function isLevelClosed(level:int):Boolean 
		{
			return _levels.data[level - 1].isClosed;
		}
		
		public function win():void 
		{
			_levels.currentLevelData.passed();
			save();
		}
		
		public function reset():void 
		{
			if (_isPausedLoop) pauseLoop();
			
			_levels.resetLevels();
			_canvas.updateScreen(ScreenMainMenu.ID, { isResumed:false } );
			save();
		}
		
		public function pauseLoop():void 
		{
			if (_isPausedLoop) {
				_loop.start();
				_isPausedLoop = false;
			} else {
				_loop.stop();
				_isPausedLoop = true;
			}
			
			_levels.pause();
		}
		
		public function pause():void 
		{
			if (_isPaused) {
				_canvas.hideScreen(ScreenPause.ID);
				if (!_isMuted) 
					_sounds.mute(false);
				if (!_isPausedLoop)
					_loop.start();
				
				_isPaused = false;
			} else {
				_canvas.showScreen(ScreenPause.ID);
				_sounds.mute(true);
				if (!_isPausedLoop)
					_loop.stop();
				
				_isPaused = true;
			}
			
			if (!_isPausedLoop) _levels.pause();
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
		
		private function onDeactivate(e:Event):void 
		{
			if (!_isPaused) pause();
		}
		
		public function get width():Number { return _width; }
		
		public function get height():Number { return _height; }
		
		public function get isMuted():Boolean { return _isMuted; }
		
		public function get isPaused():Boolean { return _isPaused; }
		
		public function get isPausedLoop():Boolean { return _isPausedLoop; }
		
		public function get isDebugAllowed():Boolean { return _isDebugAllowed; }
		
	}

}

class PrivateClass { public function PrivateClass():void { trace("Engine instantiated."); } }