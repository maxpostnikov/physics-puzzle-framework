package ru.maxpostnikov.game.entities 
{
	import ru.maxpostnikov.engine.Engine;
	import ru.maxpostnikov.engine.entities.Entity;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class EntityTarget extends Entity
	{
		
		public var isCollected:Boolean;
		
		override protected function onSelfRemoved():void 
		{
			Engine.getInstacne().fail();
		}
		
	}

}