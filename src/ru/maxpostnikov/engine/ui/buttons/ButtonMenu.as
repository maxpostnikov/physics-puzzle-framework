package ru.maxpostnikov.engine.ui.buttons 
{
	import ru.maxpostnikov.engine.Engine;
	import ru.maxpostnikov.engine.ui.screens.ScreenMainMenu;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ButtonMenu extends Button
	{
		
		override protected function click():void 
		{
			Engine.getInstacne().pauseLoop();
			Engine.getInstacne().showScreen(ScreenMainMenu.ID, { isResumed:true } );
			
			super.click();
		}
		
	}

}