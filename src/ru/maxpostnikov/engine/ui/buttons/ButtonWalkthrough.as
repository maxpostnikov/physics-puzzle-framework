package ru.maxpostnikov.engine.ui.buttons 
{
	import ru.maxpostnikov.engine.Engine;
	import ru.maxpostnikov.engine.utilities.Utils;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ButtonWalkthrough extends Button
	{
		
		override protected function click():void 
		{
			Utils.openURL(Engine.getInstacne().data.urlWalkthrough);
		}
		
	}

}