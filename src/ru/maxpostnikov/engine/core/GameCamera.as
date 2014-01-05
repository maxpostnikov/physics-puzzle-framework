package ru.maxpostnikov.engine.core 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class GameCamera 
	{
		
		private var _level:MovieClip;
		private var _debugSprite:DisplayObject;
		
		public function GameCamera(debugSprite:DisplayObject) 
		{
			_debugSprite = debugSprite;
		}
		
		public function trackLevel(level:MovieClip):void 
		{
			_level = level;
			_debugSprite.x = _debugSprite.y = 0;
		}
		
		public function moveTo(globalPoint:Point):void 
		{
			if (!_level) return;
			
			_level.x = _debugSprite.x = 640 / 2 - globalPoint.x;
			_level.y = _debugSprite.y = 480 / 2 - globalPoint.y;
		}
		
	}

}