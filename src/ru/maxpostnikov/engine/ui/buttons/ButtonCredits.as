package ru.maxpostnikov.engine.ui.buttons 
{
	import ru.maxpostnikov.engine.Engine;
	import ru.maxpostnikov.engine.ui.screens.ScreenCredits;
	import ru.maxpostnikov.engine.ui.screens.ScreenMainMenu;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ButtonCredits extends Button
	{
		
		override protected function click():void 
		{
			Engine.getInstacne().showScreen(ScreenCredits.ID, { isResumed:(this.screen as ScreenMainMenu).isResumed } );
			Engine.getInstacne().hideScreen(this.screen.getID());
		}
		
	}

}