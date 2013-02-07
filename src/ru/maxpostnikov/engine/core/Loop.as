package ru.maxpostnikov.engine.core 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import ru.maxpostnikov.engine.entities.components.Component;
	import ru.maxpostnikov.engine.entities.Entity;
	import ru.maxpostnikov.engine.entities.IProcessable;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class Loop 
	{
		
		public var queue:Vector.<IProcessable>;
		
		private var _entities:Vector.<Entity>;
		private var _physics:Physics;
		private var _contactListener:ContactListener;
		private var _container:DisplayObjectContainer;
		
		public function Loop(container:DisplayObjectContainer, ratio:Number) 
		{
			_container = container;
			_contactListener = new ContactListener();
			_physics = new Physics(ratio, _contactListener, createDebugSprite());
			
			queue = new <IProcessable>[];
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
			for each (var object:IProcessable in queue) {
				if (object is Entity) {
					if (object.isRemoved) {
						_entities.splice(_entities.indexOf(object as Entity), 1);
					} else {
						for each (var component:Component in (object as Entity).components)
							_physics.addBody(component);
						
						_entities.push(object as Entity);
					}
				} else if (object is Component) {
					if (object.isRemoved)
						_physics.removeBody(object as Component);
					else
						_physics.addBody(object as Component);
				}
			}
			
			queue = new <IProcessable>[];
		}
		
		private function createDebugSprite():Sprite 
		{
			var debugSprite:Sprite = new Sprite();
			
			_container.addChild(debugSprite);
			
			return debugSprite;
		}
		
	}

}