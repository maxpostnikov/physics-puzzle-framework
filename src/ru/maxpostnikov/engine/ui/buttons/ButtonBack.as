package ru.maxpostnikov.engine.ui.buttons 
{
	import ru.maxpostnikov.engine.Engine;
	import ru.maxpostnikov.engine.ui.screens.ScreenLevelMap;
	import ru.maxpostnikov.engine.ui.screens.ScreenMainMenu;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ButtonBack extends Button
	{
		
		override protected function click():void 
		{
			if (this.screen is ScreenLevelMap) {
				Engine.getInstacne().showScreen(ScreenMainMenu.ID, { isResumed:(this.screen as ScreenLevelMap).isResumed });
				Engine.getInstacne().hideScreen(this.screen.getID());
			}
		}
		
	}

}