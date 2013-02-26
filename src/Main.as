package 
{
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import ru.maxpostnikov.engine.Engine;
	import ru.maxpostnikov.engine.ui.screens.ScreenMainMenu;
	import ru.maxpostnikov.game.GameSounds;
	
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
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
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			Engine.getInstacne().launch(this, "Test", true);
			Engine.getInstacne().playSound(GameSounds.music);
			Engine.getInstacne().showScreen(ScreenMainMenu.ID);
		}
		
	}
	
}