package ru.maxpostnikov.engine.entities.components 
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2Shape;
	import ru.maxpostnikov.engine.Engine;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ComponentPrimitiveCircle extends ComponentPrimitive
	{
		
		override protected function createShape():b2Shape 
		{
			var shape:b2Shape;
			
			var radius:Number = (Math.max(this.getChildAt(0).width, this.getChildAt(0).height) / 2) / Engine.RATIO;
			shape = new b2CircleShape(radius);
			
			return shape;
		}
		
	}

}