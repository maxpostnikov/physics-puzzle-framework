package ru.maxpostnikov.engine.entities.components 
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Common.Math.b2Transform;
	import flash.geom.Rectangle;
	import ru.maxpostnikov.engine.Engine;
	import ru.maxpostnikov.utilities.Utils;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ComponentPrimitiveCircle extends ComponentPrimitive
	{
		
		override public function createShape(transform:b2Transform = null):b2Shape 
		{
			var shape:b2Shape;
			var size:Rectangle = Utils.realSize(this);
			
			var radius:Number = (Math.max(size.width, size.height) / 2) / Engine.RATIO;
			shape = new b2CircleShape(radius);
			
			if (transform)
				(shape as b2CircleShape).SetLocalPosition(transform.position);
			
			return shape;
		}
		
	}

}