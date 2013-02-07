package ru.maxpostnikov.engine.entities 
{
	import Box2D.Dynamics.b2Body;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import ru.maxpostnikov.engine.Engine;
	import ru.maxpostnikov.engine.entities.components.Component;
	import ru.maxpostnikov.utilities.Utils;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class Entity extends MovieClip implements IProcessable
	{
		
		private var _isRemoved:Boolean;
		private var _components:Vector.<Component>;
		
		public function Entity()
		{
			_components = new <Component>[];
			
			for (var i:int = 0; i < numChildren; i++) {
				var child:DisplayObject = getChildAt(i);
				
				if (child is Component)
					_components.push(child as Component);
			}
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			Engine.getInstacne().process(this);
		}
		
		public function remove():void 
		{
			this.parent.removeChild(this);
			
			_isRemoved = true;
			Engine.getInstacne().process(this);
		}
		
		public function update():void 
		{
			synchronize();
		}
		
		private function synchronize():void 
		{
			for each (var component:Component in _components) {
				if (component.body && component.body.GetType() != b2Body.b2_staticBody) {
					var bodyPosition:Point = new Point(component.body.GetPosition().x * Engine.RATIO, 
													   component.body.GetPosition().y * Engine.RATIO);
					var position:Point = this.globalToLocal(bodyPosition);
					var rotation:Number = Utils.angleInDegrees(component.body.GetAngle());
					if (Math.abs(rotation) > 360) rotation %= 360;
					
					component.x = position.x;
					component.y = position.y;
					component.rotation = rotation;
					
					if (isOutsideBorder(component, bodyPosition)) removeComponent(component);
				}
			}
		}
		
		private function isOutsideBorder(component:Component, position:Point):Boolean 
		{
			if (position.y - (component.height / 2) > Engine.getInstacne().height ||
				position.y + (component.height / 2) < 0 || 
				position.x - (component.width / 2) > Engine.getInstacne().width || 
				position.x + (component.width / 2) < 0) {
				return true;
			}
			
			return false;
		}
		
		private function removeComponent(component:Component):void 
		{
			_components.splice(_components.indexOf(component), 1);
			
			component.remove();
			
			if (_components.length == 0) remove();
		}
		
		public function get isRemoved():Boolean { return _isRemoved; }
		
		public function get components():Vector.<Component> { return _components; }
		
	}

}