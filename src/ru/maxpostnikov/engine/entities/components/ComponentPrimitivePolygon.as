package ru.maxpostnikov.engine.entities.components 
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Common.Math.b2Vec2;
	import ru.maxpostnikov.engine.Engine;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ComponentPrimitivePolygon extends ComponentPrimitive
	{
		
		override protected function createShape():b2Shape 
		{
			var shape:b2Shape;
			
			var coordinates:Array = [new b2Vec2((-this.getChildAt(0).width / 2) / Engine.RATIO, (-this.getChildAt(0).height / 2) / Engine.RATIO), 
									 new b2Vec2(( this.getChildAt(0).width / 2) / Engine.RATIO, ( this.getChildAt(0).height / 2) / Engine.RATIO), 
									 new b2Vec2((-this.getChildAt(0).width / 2) / Engine.RATIO, ( this.getChildAt(0).height / 2) / Engine.RATIO)];
			shape = new b2PolygonShape();
			(shape as b2PolygonShape).SetAsArray(coordinates, coordinates.length);
			
			return shape;
		}
		
	}

}