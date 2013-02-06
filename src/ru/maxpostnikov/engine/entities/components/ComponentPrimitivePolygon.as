package ru.maxpostnikov.engine.entities.components 
{
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Common.Math.b2Transform;
	import Box2D.Common.Math.b2Vec2;
	import ru.maxpostnikov.engine.Engine;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ComponentPrimitivePolygon extends ComponentPrimitive
	{
		
		override public function createShape(transform:b2Transform = null):b2Shape 
		{
			var coordinates:Array = [new b2Vec2((-this.getChildAt(0).width / 2) / Engine.RATIO, (-this.getChildAt(0).height / 2) / Engine.RATIO), 
									 new b2Vec2(( this.getChildAt(0).width / 2) / Engine.RATIO, ( this.getChildAt(0).height / 2) / Engine.RATIO), 
									 new b2Vec2((-this.getChildAt(0).width / 2) / Engine.RATIO, ( this.getChildAt(0).height / 2) / Engine.RATIO)];
			
			return createPolygonShape(coordinates, transform);
		}
		
	}

}