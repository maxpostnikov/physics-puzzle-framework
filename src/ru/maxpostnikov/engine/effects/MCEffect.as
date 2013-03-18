package ru.maxpostnikov.engine.effects 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
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
			Utils.stopChildsOf(this, true);
			
			this.mouseEnabled = false;
			this.mouseChildren = false;
			this.addFrameScript(this.totalFrames - 1, onLastFrame);
			
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage, false, 0, true);
		}
		
		public function init(container:DisplayObjectContainer, position:Point, callback:Function = null):void 
		{
			this.gotoAndStop(1);
			this.x = position.x;
			this.y = position.y;
			
			_callback = callback;
			_container = container;
			_container.addChild(this);
			
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
			Utils.stopChildsOf(this, true);
			
			if (_callback != null) _callback();
			
			_container.removeChild(this);
		}
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			
			Utils.stopChildsOf(this, true);
			
			_callback = null;
			_container = null;
		}
		
	}

}