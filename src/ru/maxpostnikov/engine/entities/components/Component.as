package ru.maxpostnikov.engine.entities.components 
{
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class Component extends MovieClip
	{
		
		public var bodyDef:b2BodyDef;
		public var fixtureDef:b2FixtureDef;
		
		public function Component() 
		{
			/*for (var i:int = 0; i < numChildren; i++) {
				var child:DisplayObject = getChildAt(i);
				
				if (child is DisplayObjectContainer) {
					(child as DisplayObjectContainer).mouseEnabled = false;
					(child as DisplayObjectContainer).mouseChildren = false;
				}
			}*/
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			loaderInfo.addEventListener(Event.INIT, onInit);
		}
		
		protected function onInit(e:Event):void 
		{
			loaderInfo.removeEventListener(Event.INIT, onInit);
		}
		
		protected function hide():void 
		{
			for (var i:int = 0; i < numChildren; i++)
				getChildAt(i).visible = false;
		}
		
	}

}