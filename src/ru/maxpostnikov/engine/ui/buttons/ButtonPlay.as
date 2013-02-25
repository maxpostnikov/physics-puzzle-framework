package ru.maxpostnikov.engine.ui.buttons 
{
	import ru.maxpostnikov.engine.Engine;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ButtonPlay extends Button
	{
		
		override protected function click():void 
		{
			Engine.getInstacne().hideScreen(this.screen.getID());
			Engine.getInstacne().openLevel(1);
		}
		
	}

}