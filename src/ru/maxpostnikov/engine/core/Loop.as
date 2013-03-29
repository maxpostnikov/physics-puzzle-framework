package ru.maxpostnikov.engine.core 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import ru.maxpostnikov.engine.Engine;
	import ru.maxpostnikov.engine.EngineEvent;
	import ru.maxpostnikov.engine.entities.components.Component;
	import ru.maxpostnikov.engine.entities.components.ComponentJoint;
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
		private var _container:DisplayObjectContainer;
		private var _debugSprite:Sprite;
		
		public function Loop(container:DisplayObjectContainer, ratio:Number) 
		{
			_container = container;
			_physics = new Physics(ratio, new ContactListener(), createDebugSprite());
			
			queue = new <IProcessable>[];
			_entities = new <Entity>[];
			
			start();
		}
		
		public function start():void 
		{
			_container.addEventListener(Event.ENTER_FRAME, step);
		}
		
		public function stop():void 
		{
			_container.removeEventListener(Event.ENTER_FRAME, step);
		}
		
		public function debug(value:Boolean):void 
		{
			_physics.isDebuged = value;
			_debugSprite.visible = value;
		}
		
		private function step(e:Event):void 
		{
			_physics.step();
			
			update();
			
			Engine.getInstacne().dispatchEvent(new EngineEvent(EngineEvent.LOOP_STEP));
		}
		
		private function update():void 
		{
			for each (var entity:Entity in _entities)
				entity.update();
			
			processQueue();
			debugOnTop();
		}
		
		private function processQueue():void 
		{
			for each (var object:IProcessable in queue) {
				if (object is Entity) {
					if (object.isRemoved) {
						_entities.splice(_entities.indexOf(object as Entity), 1);
						
						Engine.getInstacne().dispatchEvent(new EngineEvent(EngineEvent.ENTITY_REMOVED, object));
					} else {
						_entities.push(object as Entity);
						
						Engine.getInstacne().dispatchEvent(new EngineEvent(EngineEvent.ENTITY_ADDED, object));
					}
				} else if (object is Component) {
					if (object is ComponentJoint) {
						if (!object.isRemoved)
							_physics.addJoint(object as ComponentJoint);
					} else {
						if (object.isRemoved)
							_physics.removeBody(object as Component);
						else
							_physics.addBody(object as Component);
					}
				}
			}
			
			queue = new <IProcessable>[];
		}
		
		private function debugOnTop():void 
		{
			_debugSprite.parent.setChildIndex(_debugSprite, _debugSprite.parent.numChildren - 1);
		}
		
		private function createDebugSprite():Sprite 
		{
			_debugSprite = new Sprite();
			_debugSprite.visible = false;
			
			_container.addChild(_debugSprite);
			
			return _debugSprite;
		}
		
	}

}