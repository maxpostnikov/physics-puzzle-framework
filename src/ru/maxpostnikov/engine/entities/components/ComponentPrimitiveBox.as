package ru.maxpostnikov.engine.entities.components 
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Collision.Shapes.b2Shape;
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
		
	}

}