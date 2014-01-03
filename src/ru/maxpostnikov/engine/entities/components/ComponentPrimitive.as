package ru.maxpostnikov.engine.entities.components 
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Common.Math.b2Math;
	import Box2D.Common.Math.b2Transform;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import flash.geom.Point;
	import ru.maxpostnikov.engine.Engine;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ComponentPrimitive extends Component
	{
		
		public static const TYPE_STATIC:String = "Static";
		public static const TYPE_DINAMIC:String = "Dinamic";
		public static const TYPE_KINEMATIC:String = "Kinematic";
		
		[Inspectable(type="List", enumeration="Static, Dinamic, Kinematic", defaultValue="Static")]
		public var type:String = "Static";
		
		[Inspectable(type="Number", defaultValue=1)]
		public var density:Number = 1;
		
		[Inspectable(type="Number", defaultValue=0.5)]
		public var friction:Number = 0.5;
		
		[Inspectable(type="Number", defaultValue=0.5)]
		public var restitution:Number = 0.5;
		
		[Inspectable(type="Number", defaultValue=1)]
		public var maskBits:Number = 1;
		
		[Inspectable(type="Number", defaultValue=1)]
		public var categoryBits:Number = 1;
		
		[Inspectable(type="Boolean", defaultValue="false")]
		public var isSensor:Boolean = false;
		
		[Inspectable(type="Boolean", defaultValue="false")]
		public var isBullet:Boolean = false;
		
		public function ComponentPrimitive() 
		{
			hide();
		}
		
		override public function add():void 
		{
			bodyDef = createBodyDef();
			fixtureDefs = createFixtureDefs();
			
			super.add();
		}
		
		private function createBodyDef():b2BodyDef 
		{
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set(this.x / Engine.RATIO, this.y / Engine.RATIO);
			bodyDef.bullet = this.isBullet;
			
			if (this.type == TYPE_STATIC)
				bodyDef.type = b2Body.b2_staticBody;
			else if (this.type == TYPE_DINAMIC)
				bodyDef.type = b2Body.b2_dynamicBody;
			else
				bodyDef.type = b2Body.b2_kinematicBody;
			
			return bodyDef;	
		}
		
		public function createFixtureDefs(transform:b2Transform = null):Vector.<b2FixtureDef> 
		{
			var fixtureDefs:Vector.<b2FixtureDef> = new <b2FixtureDef>[];
			
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = createShape(transform);
			fixtureDef.density = this.density;
			fixtureDef.friction = this.friction;
			fixtureDef.restitution = this.restitution;
			fixtureDef.isSensor = this.isSensor;
			fixtureDef.filter.maskBits = this.maskBits;
			fixtureDef.filter.categoryBits = this.categoryBits;
			fixtureDefs.push(fixtureDef);
			
			return fixtureDefs;
		}
		
		public function createShape(transform:b2Transform = null):b2Shape 
		{
			throw Error("Primitives subclasses must override this");
		}
		
		protected function createPolygonShape(coordinates:Array, transform:b2Transform):b2Shape 
		{
			var shape:b2Shape;
			
			if (transform) {
				for (var i:int = 0; i < coordinates.length; i++)
					coordinates[i] = b2Math.MulX(transform, coordinates[i]);
			}
			
			shape = new b2PolygonShape();
			(shape as b2PolygonShape).SetAsArray(coordinates, coordinates.length);
			
			return shape;
		}
		
	}

}