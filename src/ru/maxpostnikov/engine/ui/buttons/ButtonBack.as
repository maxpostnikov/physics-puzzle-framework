package ru.maxpostnikov.engine.ui.buttons 
{
	import ru.maxpostnikov.engine.Engine;
	import ru.maxpostnikov.engine.ui.screens.ScreenMainMenu;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ButtonBack extends Button
	{
		
		override protected function click():void 
		{
			Engine.getInstacne().showScreen(ScreenMainMenu.ID);
			
			super.click();
		}
		
	}

}