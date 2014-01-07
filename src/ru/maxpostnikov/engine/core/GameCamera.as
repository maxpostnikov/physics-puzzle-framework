package ru.maxpostnikov.engine.core 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import ru.maxpostnikov.engine.Engine;
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
		
		public function moveTo(position:Point, margin:Point = null):void 
		{
			if (!_level) return;
			if (!margin) margin = new Point(0, 0);
			
			var offset:Point = new Point(Engine.getInstacne().data.cameraWidth / 2 - position.x, 
										 Engine.getInstacne().data.cameraHeight / 2 - position.y);
			
			if (Math.abs(offset.x) > margin.x) {
				_level.x = _debugSprite.x = offset.x + margin.x;
				
				if (_level.x > 0) 
					_level.x = _debugSprite.x = 0;
				else if (_level.x < Engine.getInstacne().data.cameraWidth - Engine.getInstacne().levelWidth)
					_level.x = _debugSprite.x = Engine.getInstacne().data.cameraWidth - Engine.getInstacne().levelWidth;
			}
			
			if (Math.abs(offset.y) > margin.y) {
				_level.y = _debugSprite.y = offset.y + margin.y;
				
				if (_level.y > 0) 
					_level.y = _debugSprite.y = 0;
				else if (_level.y < Engine.getInstacne().data.cameraHeight - Engine.getInstacne().levelHeight) 
					_level.y = _debugSprite.y = Engine.getInstacne().data.cameraHeight - Engine.getInstacne().levelHeight;
			}
		}
		
	}

}