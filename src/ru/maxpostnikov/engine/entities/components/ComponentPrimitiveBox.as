package ru.maxpostnikov.engine.entities.components 
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Common.Math.b2Math;
	import Box2D.Common.Math.b2Transform;
	import Box2D.Common.Math.b2Vec2;
	import ru.maxpostnikov.engine.Engine;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ComponentPrimitiveBox extends ComponentPrimitive
	{
		
		override protected function createShape():b2Shape 
		{
			var shape:b2Shape;
			
			shape = new b2PolygonShape();
			(shape as b2PolygonShape).SetAsBox((this.getChildAt(0).width / 2) / Engine.RATIO, (this.getChildAt(0).height / 2) / Engine.RATIO);
			
			return shape;
		}
		
		override public function createTransformedShape(transform:b2Transform):b2Shape 
		{
			var shape:b2Shape;
			
			var coordinates:Array = [b2Math.MulX(transform, new b2Vec2(( -this.getChildAt(0).width / 2) / Engine.RATIO, ( -this.getChildAt(0).height / 2) / Engine.RATIO)),
									 b2Math.MulX(transform, new b2Vec2((  this.getChildAt(0).width / 2) / Engine.RATIO, ( -this.getChildAt(0).height / 2) / Engine.RATIO)),	
								     b2Math.MulX(transform, new b2Vec2((  this.getChildAt(0).width / 2) / Engine.RATIO, (  this.getChildAt(0).height / 2) / Engine.RATIO)), 
								     b2Math.MulX(transform, new b2Vec2(( -this.getChildAt(0).width / 2) / Engine.RATIO, (  this.getChildAt(0).height / 2) / Engine.RATIO))];
			shape = new b2PolygonShape();
			(shape as b2PolygonShape).SetAsArray(coordinates, coordinates.length);
			
			return shape;
		}
		
	}

}