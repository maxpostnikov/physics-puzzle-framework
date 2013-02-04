package ru.maxpostnikov.engine.entities.components 
{
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import flash.events.Event;
	import ru.maxpostnikov.engine.Engine;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ComponentPrimitive extends Component
	{
		
		public static const SHAPE_BOX:String = "Box";
		public static const SHAPE_CIRCLE:String = "Circle";
		public static const SHAPE_POLYGON:String = "Polygon";
		
		public static const TYPE_STATIC:String = "Static";
		public static const TYPE_DINAMIC:String = "Dinamic";
		
		[Inspectable(type="List", enumeration="Static, Dinamic", defaultValue="Static")]
		public var type:String = "Static";
		
		[Inspectable(type="Number", defaultValue=1)]
		public var density:Number = 1;
		
		[Inspectable(type="Number", defaultValue=0.5)]
		public var friction:Number = 0.5;
		
		[Inspectable(type="Number", defaultValue=0.5)]
		public var restitution:Number = 0.5;
		
		[Inspectable(type="Boolean", defaultValue="false")]
		public var isSensor:Boolean = false;
		
		[Inspectable(type="Boolean", defaultValue="false")]
		public var isBullet:Boolean = false;
		
		protected var shape:String;
		
		override protected function onInit(e:Event):void 
		{
			super.onInit(e);
			
			bodyDef = createBodyDef();
			fixtureDef = createFixtureDef();
		}
		
		private function createBodyDef():b2BodyDef 
		{
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set(this.x / Engine.RATIO, this.y / Engine.RATIO);
			bodyDef.bullet = this.isBullet;
			
			if (this.type == TYPE_STATIC)
				bodyDef.type = b2Body.b2_staticBody;
			else
				bodyDef.type = b2Body.b2_dynamicBody;
			
			return bodyDef;	
		}
		
		private function createFixtureDef():b2FixtureDef 
		{
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = createShape();
			fixtureDef.density = this.density;
			fixtureDef.friction = this.friction;
			fixtureDef.restitution = this.restitution;
			fixtureDef.isSensor = this.isSensor;
			//fixtureDef.filter.maskBits = 1;
			//fixtureDef.filter.categoryBits = 1;
			
			return fixtureDef;
		}
		
		protected function createShape():b2Shape 
		{
			throw Error("Primitives subclasses must override this");
		}
		
	}

}