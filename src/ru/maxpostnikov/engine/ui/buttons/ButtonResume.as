package ru.maxpostnikov.engine.ui.buttons 
{
	import ru.maxpostnikov.engine.Engine;
	import ru.maxpostnikov.engine.ui.screens.ScreenBack;
	import ru.maxpostnikov.engine.ui.screens.ScreenHUD;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ButtonResume extends Button
	{
		
		override protected function click():void 
		{
			if (Engine.getInstacne().isPausedLoop) {
				Engine.getInstacne().pauseLoop();
				Engine.getInstacne().showScreen(ScreenHUD.ID);
			} else {
				Engine.getInstacne().openLastLevel();
			}
			
			Engine.getInstacne().hideScreen(ScreenBack.ID);
			
			super.click();
		}
		
	}

}