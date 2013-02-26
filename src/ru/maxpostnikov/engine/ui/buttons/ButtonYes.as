package ru.maxpostnikov.engine.ui.buttons 
{
	import ru.maxpostnikov.engine.Engine;
	import ru.maxpostnikov.engine.ui.screens.ScreenLevelMap;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ButtonYes extends Button
	{
		
		override protected function click():void 
		{
			Engine.getInstacne().reset();
			Engine.getInstacne().updateScreen(ScreenLevelMap.ID, { isResumed:false } );
			Engine.getInstacne().hideScreen(this.screen.getID());
		}
		
	}

}