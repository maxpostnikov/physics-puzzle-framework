package ru.maxpostnikov.engine.ui.buttons 
{
	import ru.maxpostnikov.engine.Engine;
	import ru.maxpostnikov.engine.ui.screens.ScreenReset;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ButtonReset extends Button
	{
		
		override protected function click():void 
		{
			Engine.getInstacne().showScreen(ScreenReset.ID);
		}
		
	}

}