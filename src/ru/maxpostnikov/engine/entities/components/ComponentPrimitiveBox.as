package ru.maxpostnikov.engine.entities.components 
{
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Common.Math.b2Transform;
	import Box2D.Common.Math.b2Vec2;
	import flash.geom.Rectangle;
	import ru.maxpostnikov.engine.Engine;
	import ru.maxpostnikov.utilities.Utils;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ComponentPrimitiveBox extends ComponentPrimitive
	{
		
		override public function createShape(transform:b2Transform = null):b2Shape 
		{
			var size:Rectangle = Utils.realSize(this);
			
			var coordinates:Array = [new b2Vec2((-size.width / 2) / Engine.RATIO, (-size.height / 2) / Engine.RATIO),
									 new b2Vec2(( size.width / 2) / Engine.RATIO, (-size.height / 2) / Engine.RATIO),	
								     new b2Vec2(( size.width / 2) / Engine.RATIO, ( size.height / 2) / Engine.RATIO), 
								     new b2Vec2((-size.width / 2) / Engine.RATIO, ( size.height / 2) / Engine.RATIO)];
			
			return createPolygonShape(coordinates, transform);
		}
		
	}

}