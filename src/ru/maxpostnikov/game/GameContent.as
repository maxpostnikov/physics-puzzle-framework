package ru.maxpostnikov.game 
{
	import flash.media.Sound;
	import ru.maxpostnikov.engine.ui.screens.*;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class GameContent 
	{
		
		public static const SCREENS:Vector.<Class> = new <Class>[ScreenBack, ScreenPause, ScreenMainMenu, ScreenLevelMap, ScreenReset, ScreenCredits, ScreenHUD];
		
		/*[Embed(source='/../../ThermoBox 2/Sounds/Cattails.mp3')]
		private static var _music:Class;
		
		[Embed(source='/../../ThermoBox 2/Sounds/sound_drop_1.mp3')]
		private static var _sound:Class;
		
		public static var music:Sound = new _music();
		public static var sound:Sound = new _sound();*/
		
	}

}