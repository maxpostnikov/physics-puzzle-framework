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
		
		public function Loop(container:DisplayObjectContainer, ratio:Number, gravity:Point) 
		{
			_container = container;
			_physics = new Physics(ratio, new ContactListener(), gravity, createDebugSprite());
			
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
			
			Engine.getInstacne().dispatchEvent(new EngineEvent(EngineEvent.LOOP_STOP));
		}
		
		public function debug(value:Boolean):void 
		{
			_physics.isDebuged = value;
			_debugSprite.visible = value;
		}
		
		public function startDrag(object:IProcessable, force:Number):void 
		{
			if (object is Entity) object = (object as Entity).components[0];
			
			_physics.addMouseJoint(object as Component, force);
		}
		
		public function stopDrag():void 
		{
			_physics.removeMouseJoint();
		}
		
		private function step(e:Event):void 
		{
			_physics.step(new Point(_container.mouseX / Engine.RATIO, _container.mouseY / Engine.RATIO));
			
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
						else
							_physics.removeJoint(object as ComponentJoint);
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
		
		public function get debugSprite():Sprite { return _debugSprite; }
		
	}

}