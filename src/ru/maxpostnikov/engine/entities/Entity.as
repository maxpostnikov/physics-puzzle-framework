package ru.maxpostnikov.engine.entities 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Fixture;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import ru.maxpostnikov.engine.effects.MCEffect;
	import ru.maxpostnikov.engine.Engine;
	import ru.maxpostnikov.engine.entities.components.Component;
	import ru.maxpostnikov.engine.entities.components.ComponentJoint;
	import ru.maxpostnikov.engine.utilities.Utils;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class Entity extends MovieClip implements IProcessable
	{
		
		private var _isRemoved:Boolean;
		private var _components:Vector.<Component>;
		
		protected var isInited:Boolean;
		protected var initialRotation:Number;
		
		public function Entity()
		{
			initialRotation = this.rotation;
			
			_components = new <Component>[];
			
			for (var i:int = 0; i < numChildren; i++) {
				var child:DisplayObject = getChildAt(i);
				
				if (child is Component)
					_components.push(child as Component);
			}
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
		}
		
		protected function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			Utils.transmitRotation(this);
			Utils.transmitPosition(this);
			
			for each (var component:Component in _components)
				component.add();
			
			Engine.getInstacne().process(this);
		}
		
		public function remove():void 
		{
			for (var i:int = _components.length - 1; i >= 0; i--)
				removeComponent(_components[i]);
			
			this.parent.removeChild(this);
			
			_isRemoved = true;
			Engine.getInstacne().process(this);
			
			_components = null;
		}
		
		public function update():void 
		{
			if (!isInited) init();
			
			for each (var component:Component in _components) {
				component.synchronize();
				
				if (component.isOutsideBorder()) removeComponent(component, true);
			}
		}
		
		public function pause(flag:Boolean):void 
		{
			for (var i:int = 0; i < numChildren; i++) {
				var child:DisplayObject = getChildAt(i);
				
				if (child is MCEffect) {
					(child as MCEffect).pause(flag);
				}
			}
		}
		
		public function contact(type:String, fixture:b2Fixture, entity:Entity, impulse:Number):void 
		{
			//Override
		}
		
		protected function onSelfRemoved():void 
		{
			//Override
		}
		
		protected function init():void 
		{
			isInited = true;
		}
		
		protected function removeComponent(component:Component, isSelfRemoved:Boolean = false):void 
		{
			_components.splice(_components.indexOf(component), 1);
			
			component.remove();
			
			if (isSelfRemoved && isAllBodiesRemoved) {
				remove();
				onSelfRemoved();
			}
		}
		
		protected function stopMoving():void 
		{
			for each (var component:Component in _components)
				component.stopMoving();
		}
		
		private function get isAllBodiesRemoved():Boolean 
		{
			for each (var component:Component in _components) {
				if (!(component is ComponentJoint) && component.body != null)
					return false;
			}
			
			return true;
		}
		
		public function get isAllBodiesCreated():Boolean 
		{
			for each (var component:Component in _components) {
				if (!(component is ComponentJoint) && component.body == null)
					return false;
			}
			
			return true;
		}
		
		public function get positionGlobal():Point
		{
			var coordinatesX:Array = [];
			var coordinatesY:Array = [];
			for each (var component:Component in _components) {
				coordinatesX.push(component.x);
				coordinatesY.push(component.y);
			}
			coordinatesX.sort(Array.NUMERIC);
			coordinatesY.sort(Array.NUMERIC);
			
			return localToGlobal(new Point((coordinatesX[coordinatesX.length - 1] + coordinatesX[0]) / 2,
										   (coordinatesY[coordinatesY.length - 1] + coordinatesY[0]) / 2));
		}
		
		public function get positionLocal():Point 
		{
			return this.parent.globalToLocal(positionGlobal);
		}
		
		public function get positionPhysics():Point 
		{
			var position:b2Vec2;
			var coordinatesX:Array = [];
			var coordinatesY:Array = [];
			for each (var component:Component in _components) {
				if (component.body) {
					position = component.body.GetPosition();
					
					coordinatesX.push(position.x * Engine.RATIO);
					coordinatesY.push(position.y * Engine.RATIO);
				}
			}
			coordinatesX.sort(Array.NUMERIC);
			coordinatesY.sort(Array.NUMERIC);
			
			if (coordinatesX.length > 0 && coordinatesY.length > 0)
				return new Point((coordinatesX[coordinatesX.length - 1] + coordinatesX[0]) / 2, (coordinatesY[coordinatesY.length - 1] + coordinatesY[0]) / 2)
			else
				return new Point(0, 0);
		}
		
		public function get isRemoved():Boolean { return _isRemoved; }
		
		public function get components():Vector.<Component> { return _components; }
		
	}

}