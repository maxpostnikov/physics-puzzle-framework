package ru.maxpostnikov.engine.ui.buttons 
{
	import ru.maxpostnikov.engine.Engine;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ButtonNext extends Button
	{
		
		override protected function click():void 
		{
			Engine.getInstacne().pauseLoop();
			Engine.getInstacne().openNextLevel();
			
			super.click();
		}
		
	}

}