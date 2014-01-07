package ru.maxpostnikov.engine.entities 
{
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class EntityBackground extends Entity
	{
		
		[Inspectable(type="Number", defaultValue=640)]
		public var levelWidth:Number = 640;
		
		[Inspectable(type="Number", defaultValue=480)]
		public var levelHeight:Number = 480;
		
	}

}