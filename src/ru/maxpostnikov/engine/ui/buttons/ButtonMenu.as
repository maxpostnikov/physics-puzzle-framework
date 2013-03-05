package ru.maxpostnikov.engine.ui.buttons 
{
	import ru.maxpostnikov.engine.Engine;
	import ru.maxpostnikov.engine.ui.screens.ScreenHUD;
	import ru.maxpostnikov.engine.ui.screens.ScreenMainMenu;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ButtonMenu extends Button
	{
		
		override protected function click():void 
		{
			var isResumed:Boolean;
			
			if (this.screen is ScreenHUD) {
				isResumed = true;
				Engine.getInstacne().pauseLoop();
			}
			
			Engine.getInstacne().showScreen(ScreenMainMenu.ID, { isResumed:isResumed } );
			
			super.click();
		}
		
	}

}