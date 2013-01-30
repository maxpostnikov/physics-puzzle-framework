package ru.maxpostnikov 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class Loop 
	{
		
		private var _physics:Physics;
		private var _contactListener:ContactListener;
		private var _container:DisplayObjectContainer;
		
		public function Loop(container:DisplayObjectContainer, ratio:Number) 
		{
			_container = container;
			_contactListener = new ContactListener();
			_physics = new Physics(ratio, _contactListener, createDebugSprite());
			
			_container.addEventListener(Event.ENTER_FRAME, step);
		}
		
		private function step(e:Event):void 
		{
			_physics.step();
			_physics.debug();
		}
		
		private function createDebugSprite():Sprite 
		{
			var debugSprite:Sprite = new Sprite();
			
			_container.addChild(debugSprite);
			
			return debugSprite;
		}
		
		public function get physics():Physics { return _physics; }
		
	}

}