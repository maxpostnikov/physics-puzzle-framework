package ru.maxpostnikov.engine.ui.buttons 
{
	import flash.events.Event;
	import ru.maxpostnikov.engine.Engine;
	import ru.maxpostnikov.engine.ui.screens.ScreenBack;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ButtonLevel extends Button
	{
		
		public var level:int;
		public var isClosed:Boolean;
		
		override protected function onAddedToStage(e:Event):void 
		{
			if (!isClosed) super.onAddedToStage(e);
		}
		
		override protected function click():void 
		{
			Engine.getInstacne().openLevel(level);
			Engine.getInstacne().hideScreen(ScreenBack.ID);
			
			super.click();
		}
		
	}

}