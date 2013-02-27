package ru.maxpostnikov.engine.core 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import ru.maxpostnikov.engine.entities.Entity;
	import ru.maxpostnikov.utilities.Utils;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class Levels 
	{
		
		private const _LEVEL_TOTAL:uint = 3;
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
		
		public function pause():void 
		{
			if (_timer) {
				if (_timer.running)
					_timer.stop();
				else
					_timer.start();
			}
		}
		
		public function addLevel(number:int):void 
		{
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
		}
		
		public function restartLevel():void 
		{
			addLevel(_currentLevel);
		}
		
		public function nextLevel():void 
		{
			if (_currentLevel < _LEVEL_TOTAL) addLevel(_currentLevel + 1);
		}
		
		public function prevLevel():void 
		{
			if (_currentLevel > 1) addLevel(_currentLevel - 1);
		}
		
		private function removeLevel():void 
		{
			_container.removeChild(_level);
			
			for (var i:int = _level.numChildren - 1; i >= 0; i--)
				(_level.getChildAt(i) as Entity).remove();
			
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
		}
		
		public function get lastLevel():int 
		{
			for (var i:int = _LEVEL_TOTAL - 1; i >= 0; i--)
				if (!_data[i].isClosed) return i + 1;
			
			return 1;
		}
		
		public function get data():Vector.<LevelData> { return _data; }
		
		public function get currentLevelData():LevelData { return _data[_currentLevel - 1]; }
		
	}

}