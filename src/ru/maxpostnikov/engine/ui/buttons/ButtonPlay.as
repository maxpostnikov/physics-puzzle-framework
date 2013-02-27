package ru.maxpostnikov.engine.ui.buttons 
{
	import ru.maxpostnikov.engine.Engine;
	import ru.maxpostnikov.engine.ui.screens.ScreenBack;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ButtonPlay extends Button
	{
		
		override protected function click():void 
		{
			Engine.getInstacne().openLevel(1);
			Engine.getInstacne().hideScreen(ScreenBack.ID);
			
			super.click();
		}
		
	}

}