package ru.maxpostnikov.engine.core 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import ru.maxpostnikov.engine.entities.components.Component;
	import ru.maxpostnikov.engine.entities.Entity;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class Loop 
	{
		
		public var queue:Vector.<MovieClip>;
		
		private var _entities:Vector.<Entity>;
		private var _physics:Physics;
		private var _contactListener:ContactListener;
		private var _container:DisplayObjectContainer;
		
		public function Loop(container:DisplayObjectContainer, ratio:Number) 
		{
			_container = container;
			_contactListener = new ContactListener();
			_physics = new Physics(ratio, _contactListener, createDebugSprite());
			
			queue = new <MovieClip>[];
			_entities = new <Entity>[];
			
			_container.addEventListener(Event.ENTER_FRAME, step);
		}
		
		private function step(e:Event):void 
		{
			_physics.step();
			
			update();
		}
		
		private function update():void 
		{
			for each (var entity:Entity in _entities)
				entity.update();
			
			processQueue();
		}
		
		private function processQueue():void 
		{
			for each (var mc:MovieClip in queue) {
				if (mc is Entity) {
					if (!(mc as Entity).isRemoved) {
						for each (var component:Component in (mc as Entity).components)
							_physics.addBody(component);
						
						_entities.push(mc as Entity);
					}
				} else if (mc is Component) {
					_physics.removeBody(mc as Component);
				}
			}
			
			queue = new <MovieClip>[];
		}
		
		private function createDebugSprite():Sprite 
		{
			var debugSprite:Sprite = new Sprite();
			
			_container.addChild(debugSprite);
			
			return debugSprite;
		}
		
	}

}