package ru.maxpostnikov.engine.ui.buttons 
{
	import ru.maxpostnikov.engine.Engine;
	import ru.maxpostnikov.engine.ui.screens.ScreenLevelMap;
	import ru.maxpostnikov.engine.ui.screens.ScreenMainMenu;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ButtonLevelMap extends Button
	{
		
		override protected function click():void 
		{
			Engine.getInstacne().showScreen(ScreenLevelMap.ID, { isResumed:(this.screen as ScreenMainMenu).isResumed } );
			Engine.getInstacne().hideScreen(this.screen.getID());
		}
		
	}

}