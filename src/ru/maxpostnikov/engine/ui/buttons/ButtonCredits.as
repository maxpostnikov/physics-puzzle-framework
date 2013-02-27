package ru.maxpostnikov.engine.ui.buttons 
{
	import ru.maxpostnikov.engine.Engine;
	import ru.maxpostnikov.engine.ui.screens.ScreenCredits;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ButtonCredits extends Button
	{
		
		override protected function click():void 
		{
			Engine.getInstacne().showScreen(ScreenCredits.ID);
			
			super.click();
		}
		
	}

}