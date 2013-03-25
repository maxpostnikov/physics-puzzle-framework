package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import ru.maxpostnikov.engine.Engine;
	import ru.maxpostnikov.engine.ui.screens.ScreenMainMenu;
	import ru.maxpostnikov.game.GameContent;
	import ru.maxpostnikov.game.GameData;
	
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	[Frame(factoryClass="ru.maxpostnikov.Preloader")]
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) 
				init();
			else 
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			Engine.getInstacne().launch(this, GameData.GAME_NAME, GameData.DEBUG);
			//Engine.getInstacne().playSound(GameContent.music);
			Engine.getInstacne().showScreen(ScreenMainMenu.ID);
			Engine.getInstacne().showCursor(GameContent.CURSOR_ARROW_ID);
		}
		
	}
	
}