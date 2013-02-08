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
	import ru.maxpostnikov.utilities.Utils;
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
			rotateInsideOut();
			
			bodyDef = createBodyDef();
			fixtureDefs = createFixtureDefs();
		}
		
		override public function remove():void 
		{
			super.remove();
			
			_group = null;
		}
		
		private function rotateInsideOut():void 
		{
			var rotation:Number = this.rotation + this.parent.rotation;
			var angle:Number = Utils.angleInRadians(rotation);
			
			for (var i:int = 0; i < numChildren; i++) {
				var child:DisplayObject = getChildAt(i);
				var position:Point = new Point((Math.cos(angle) * child.x) - (Math.sin(angle) * child.y),
											   (Math.sin(angle) * child.x) + (Math.cos(angle) * child.y));
				
				child.x = position.x;
				child.y = position.y;
				child.rotation += rotation;
			}
			
			this.rotation = 0;
			this.parent.rotation = 0;
		}
		
		private function createBodyDef():b2BodyDef 
		{
			var position:Point = this.parent.localToGlobal(new Point(this.x, this.y));
			
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set(position.x / Engine.RATIO, position.y / Engine.RATIO);
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
			
			for each (var component:Component in _group) {
				if (component is ComponentPrimitive) {
					if ((component as ComponentPrimitive).type == ComponentPrimitive.TYPE_STATIC)
						staticBodies++;
					else
						dynamicBodies++;
				}
			}
			
			if (staticBodies > dynamicBodies)
				return b2Body.b2_staticBody;
			else
				return b2Body.b2_dynamicBody;
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