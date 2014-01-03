package ru.maxpostnikov.engine.entities.components 
{
	import Box2D.Common.Math.b2Transform;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import ru.maxpostnikov.engine.Engine;
	import ru.maxpostnikov.engine.utilities.Utils;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ComponentGroup extends Component
	{
		
		private var _group:Vector.<Component>;
		
		public function ComponentGroup() 
		{
			_group = new <Component>[];
			
			for (var i:int = 0; i < numChildren; i++) {
				var child:DisplayObject = getChildAt(i);
				
				if (child is Component)
					_group.push(child as Component);
			}
		}
		
		override public function add():void 
		{
			Utils.transmitRotation(this);
			
			bodyDef = createBodyDef();
			fixtureDefs = createFixtureDefs();
			
			super.add();
		}
		
		override public function remove():void 
		{
			super.remove();
			
			_group = null;
		}
		
		private function createBodyDef():b2BodyDef 
		{
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set(this.x / Engine.RATIO, this.y / Engine.RATIO);
			bodyDef.bullet = getBullet();
			bodyDef.type = getType();
			
			return bodyDef;	
		}
		
		private function getBullet():Boolean 
		{
			for each (var component:Component in _group) {
				if (component is ComponentPrimitive && (component as ComponentPrimitive).isBullet)
					return true;
			}
			
			return false;
		}
		
		private function getType():uint 
		{
			var staticBodies:int;
			var dynamicBodies:int;
			var kinematicBodies:int;
			
			for each (var component:Component in _group) {
				if (component is ComponentPrimitive) {
					if ((component as ComponentPrimitive).type == ComponentPrimitive.TYPE_STATIC)
						staticBodies++;
					else if ((component as ComponentPrimitive).type == ComponentPrimitive.TYPE_DINAMIC)
						dynamicBodies++;
					else
						kinematicBodies++;
				}
			}
			
			var maxBodies:int = Math.max(staticBodies, dynamicBodies, kinematicBodies);
			
			if (staticBodies == maxBodies)
				return b2Body.b2_staticBody;
			else if (dynamicBodies == maxBodies)
				return b2Body.b2_dynamicBody;
			else
				return b2Body.b2_kinematicBody;
		}
		
		private function createFixtureDefs():Vector.<b2FixtureDef> 
		{
			var fixtureDefs:Vector.<b2FixtureDef> = new <b2FixtureDef>[];
			
			for each (var component:Component in _group) {
				if (component is ComponentPrimitive) {
					var transform:b2Transform = new b2Transform();
					transform.R.Set(Utils.angleInRadians(component.rotation));
					transform.position = new b2Vec2(component.x / Engine.RATIO, component.y / Engine.RATIO);
					
					fixtureDefs = fixtureDefs.concat((component as ComponentPrimitive).createFixtureDefs(transform));
				}
			}
			
			return fixtureDefs;
		}
		
	}

}