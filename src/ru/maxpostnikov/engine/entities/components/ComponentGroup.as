package ru.maxpostnikov.engine.entities.components 
{
	import Box2D.Common.Math.b2Transform;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import ru.maxpostnikov.engine.Engine;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ComponentGroup extends Component
	{
		
		private var _skin:MovieClip;
		private var _group:Vector.<Component>;
		
		public function ComponentGroup() 
		{
			_group = new <Component>[];
			
			for (var i:int = 0; i < numChildren; i++) {
				var child:DisplayObject = getChildAt(i);
				
				if (child is Component)
					_group.push(child as Component);
				else
					child.visible = false;
			}
		}
		
		override protected function onInit(e:Event):void 
		{
			super.onInit(e);
			
			_skin = getSkin();
			
			bodyDef = createBodyDef();
			fixtureDefs = createFixtureDefs();
		}
		
		private function getSkin():MovieClip 
		{
			for each (var component:Component in _group) {
				if (component is ComponentGraphic) 
					return component;
			}
			
			return null;
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
		
		private function createFixtureDefs():Vector.<b2FixtureDef> 
		{
			var fixtureDefs:Vector.<b2FixtureDef> = new <b2FixtureDef>[];
			
			var position:Point = this.parent.localToGlobal(new Point(this.x, this.y));
			
			for each (var component:Component in _group) {
				if (component is ComponentPrimitive) {
					var position2:Point = component.parent.localToGlobal(new Point(component.x, component.y));
					
					var transform:b2Transform = new b2Transform();
					transform.R.Set((this.rotation + component.rotation) * Math.PI / 180);
					transform.position = new b2Vec2((position2.x - position.x) / Engine.RATIO, (position2.y - position.y) / Engine.RATIO);
					
					component.fixtureDefs = new <b2FixtureDef>[(component as ComponentPrimitive).createFixtureDef()];
					component.fixtureDefs[0].shape = (component as ComponentPrimitive).createTransformedShape(transform);
					
					fixtureDefs.push(component.fixtureDefs[0]);
				}
			}
			
			return fixtureDefs;
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
		
		public function get group():Vector.<Component> { return _group; }
		
		public function get skin():MovieClip { return _skin; }
		
	}

}