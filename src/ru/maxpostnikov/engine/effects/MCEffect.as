package ru.maxpostnikov.engine.effects 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import ru.maxpostnikov.utilities.Utils;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class MCEffect extends MovieClip
	{
		
		private var _callback:Function;
		private var _container:DisplayObjectContainer;
		
		public function MCEffect() 
		{
			this.mouseEnabled = false;
			this.mouseChildren = false;
			
			Utils.stopChildsOf(this, true);
		}
		
		public function init(container:DisplayObjectContainer, position:Point, callback:Function = null):void 
		{
			_callback = callback;
			_container = container;
			
			this.x = position.x;
			this.y = position.y;
			_container.addChild(this);
			
			this.addFrameScript(this.totalFrames - 1, onLastFrame);
			
			Utils.playChildsOf(this);
		}
		
		public function pause(flag:Boolean):void 
		{
			if (flag)
				Utils.stopChildsOf(this, true);
			else
				Utils.playChildsOf(this);
		}
		
		private function onLastFrame():void 
		{
			if (_callback != null) _callback();
			
			remove();
		}
		
		private function remove():void 
		{
			Utils.stopChildsOf(this, true);
			
			_container.removeChild(this);
			
			_callback = null;
			_container = null;
		}
		
	}

}