package ru.maxpostnikov.engine.ui.buttons 
{
	import ru.maxpostnikov.engine.Engine;
	import ru.maxpostnikov.engine.ui.screens.ScreenLevelMap;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ButtonLevelMap extends Button
	{
		
		override protected function click():void 
		{
			Engine.getInstacne().showScreen(ScreenLevelMap.ID);
			
			super.click();
		}
		
	}

}