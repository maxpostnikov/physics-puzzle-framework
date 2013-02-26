package ru.maxpostnikov.engine.ui.buttons 
{
	import ru.maxpostnikov.game.GameData;
	import ru.maxpostnikov.utilities.Utils;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ButtonWalkthrough extends Button
	{
		
		override protected function click():void 
		{
			Utils.openURL(GameData.URL_WALKTHROUGH);
		}
		
	}

}