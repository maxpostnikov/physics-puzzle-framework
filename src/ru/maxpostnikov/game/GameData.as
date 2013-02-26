package ru.maxpostnikov.game 
{
	import ru.maxpostnikov.engine.ui.screens.ScreenCredits;
	import ru.maxpostnikov.engine.ui.screens.ScreenLevelMap;
	import ru.maxpostnikov.engine.ui.screens.ScreenMainMenu;
	import ru.maxpostnikov.engine.ui.screens.ScreenReset;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class GameData 
	{
		
		public static const SCREENS:Vector.<Class> = new <Class>[ScreenMainMenu, ScreenLevelMap, ScreenReset, ScreenCredits];
		
		public static const URL_SPONSOR:String = "http://maxpostnikov.ru";
		public static const URL_MORE_GAMES:String = "http://maxpostnikov.ru";
		public static const URL_WALKTHROUGH:String = "http://maxpostnikov.ru";
		
	}

}