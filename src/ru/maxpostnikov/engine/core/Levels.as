package ru.maxpostnikov.engine.core 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import ru.maxpostnikov.engine.effects.MCEffect;
	import ru.maxpostnikov.engine.Engine;
	import ru.maxpostnikov.engine.EngineEvent;
	import ru.maxpostnikov.engine.entities.Entity;
	import ru.maxpostnikov.engine.ui.screens.ScreenHUD;
	import ru.maxpostnikov.engine.utilities.Utils;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class Levels 
	{
		
		private const _LEVEL_TOTAL:uint = Engine.getInstacne().data.levelsTotal;
		private const _LEVEL_PREFIX:String = "Level_";
		
		private var _timer:Timer;
		private var _level:MovieClip;
		private var _currentLevel:int;
		private var _data:Vector.<LevelData>;
		private var _container:DisplayObjectContainer;
		
		public function Levels(container:DisplayObjectContainer) 
		{
			_container = container;
			
			resetLevels();
		}
		
		public function resetLevels():void 
		{
			_data = new <LevelData>[];
			for (var i:int = 0; i < _LEVEL_TOTAL; i++)
				_data.push(new LevelData());
			
			if (_level) removeLevel();
			
			_currentLevel = 0;
		}
		
		public function save():Array 
		{
			var data:Array = [];
			
			for (var i:int = 0; i < _LEVEL_TOTAL; i++)
				data.push(_data[i].save());
			
			return data;
		}
		
		public function load(data:Array):void 
		{
			for (var i:int = 0; i < _LEVEL_TOTAL; i++)
				_data[i].load(data[i]);
		}
		
		public function pause(flag:Boolean):void 
		{
			if (_timer) {
				if (_timer.running)
					_timer.stop();
				else
					_timer.start();
			}
			
			if (_level) {
				for (var i:int = 0; i < _level.numChildren; i++) {
					var child:DisplayObject = _level.getChildAt(i);
					
					if (child is Entity) {
						(child as Entity).pause(flag);
					} else if (child is MCEffect) {
						(child as MCEffect).pause(flag);
					}
				}
			}
		}
		
		public function addLevel(number:int):void 
		{
			Engine.getInstacne().dispatchEvent(new EngineEvent(EngineEvent.LEVEL_ADDED));
			
			_currentLevel = number;
			
			if (_level) removeLevel();
			
			var levelClass:Class = Utils.getDefinition(_LEVEL_PREFIX + number.toString()) as Class;
			_level = new levelClass();
			_container.addChild(_level);
			
			_data[_currentLevel - 1].init();
			
			if (LevelData.SCORE_TIMER != 0) {
				_timer = new Timer(LevelData.SCORE_TIMER);
				_timer.addEventListener(TimerEvent.TIMER, onTimer, false, 0, true);
				_timer.start();
			}
			
			_level.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
			_level.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
			
			Engine.getInstacne().camera.trackLevel(_level);
			Engine.getInstacne().showScreen(ScreenHUD.ID, { level:number, score:_data[_currentLevel - 1].score } );
		}
		
		public function restartLevel():void 
		{
			if (_level) addLevel(_currentLevel);
		}
		
		public function nextLevel():void 
		{
			if (_level && _currentLevel < _LEVEL_TOTAL) addLevel(_currentLevel + 1);
		}
		
		public function prevLevel():void 
		{
			if (_level && _currentLevel > 1) addLevel(_currentLevel - 1);
		}
		
		private function removeLevel():void 
		{
			_level.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			_level.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			
			for (var i:int = _level.numChildren - 1; i >= 0; i--) {
				if (_level.getChildAt(i) is Entity) {
					(_level.getChildAt(i) as Entity).remove();
				}
			}
			
			_container.removeChild(_level);	
			
			_level = null;
			
			if (_timer) {
				_timer.removeEventListener(TimerEvent.TIMER, onTimer);
				_timer.stop();
				_timer = null;
			}
		}
		
		private function onTimer(e:TimerEvent):void 
		{
			_data[_currentLevel - 1].step();
			
			Engine.getInstacne().updateScreen(ScreenHUD.ID, { score:_data[_currentLevel - 1].score } );
		}
		
		private function onMouseOver(e:MouseEvent):void 
		{
			Engine.getInstacne().dispatchEvent(new EngineEvent(EngineEvent.LEVEL_MOUSE_OVER, e));
		}
		
		private function onMouseOut(e:MouseEvent):void 
		{
			Engine.getInstacne().dispatchEvent(new EngineEvent(EngineEvent.LEVEL_MOUSE_OUT, e));
		}
		
		public function get lastLevel():int 
		{
			for (var i:int = _LEVEL_TOTAL - 1; i >= 0; i--)
				if (!_data[i].isClosed) return i + 1;
			
			return 1;
		}
		
		public function get totalScore():Number 
		{
			var totalScore:Number = 0;
			
			for (var i:int = 0; i < _LEVEL_TOTAL; i++) {
				if (_data[i].isPassed)
					totalScore += _data[i].score;
			}
			
			return totalScore;
		}
		
		public function get isAllLevelsCompleted():Boolean 
		{
			for (var i:int = 0; i < _LEVEL_TOTAL; i++) {
				if (!_data[i].isPassed)
					return false;
			}
			
			return true;
		}
		
		public function get level():MovieClip { return _level; }
		
		public function get data():Vector.<LevelData> { return _data; }
		
		public function get currentLevelData():LevelData { return _data[_currentLevel - 1]; }
		
		public function get isLevelLast():Boolean { return (_currentLevel == _LEVEL_TOTAL) ? true : false; }
		
	}

}