package ru.maxpostnikov.engine.entities.components 
{
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import flash.display.MovieClip;
	import flash.events.Event;
	import ru.maxpostnikov.engine.Engine;
	import ru.maxpostnikov.engine.entities.IProcessable;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class Component extends MovieClip implements IProcessable
	{
		
		public var body:b2Body;
		public var bodyDef:b2BodyDef;
		public var fixtureDefs:Vector.<b2FixtureDef>;
		
		private var _isRemoved:Boolean;
		
		public function Component() 
		{
			this.mouseChildren = false;
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
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
		
		public function remove():void 
		{
			this.parent.removeChild(this);
			
			_isRemoved = true;
			Engine.getInstacne().process(this);
		}
		
		protected function hide():void 
		{
			for (var i:int = 0; i < numChildren; i++)
				getChildAt(i).visible = false;
		}
		
		public function get isRemoved():Boolean { return _isRemoved; }
		
	}

}