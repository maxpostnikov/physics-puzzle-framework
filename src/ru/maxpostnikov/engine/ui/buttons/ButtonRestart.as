package ru.maxpostnikov.engine.ui.buttons 
{
	import ru.maxpostnikov.engine.Engine;
	import ru.maxpostnikov.engine.ui.screens.ScreenHUD;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ButtonRestart extends Button
	{
		
		override protected function click():void 
		{
			if (!(this.screen is ScreenHUD)) {
				Engine.getInstacne().pauseLoop();
				super.click();
			}
			
			Engine.getInstacne().restartLevel();
		}
		
	}

}