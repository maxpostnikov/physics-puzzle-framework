package ru.maxpostnikov.engine.ui.buttons 
{
	import ru.maxpostnikov.engine.Engine;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ButtonNo extends Button
	{
		
		override protected function click():void 
		{
			Engine.getInstacne().hideScreen(this.screen.getID());
		}
		
	}

}