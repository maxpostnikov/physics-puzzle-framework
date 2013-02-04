package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import ru.maxpostnikov.engine.Engine;
	
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
			
			Engine.getInstacne().launch(this);
			
			var level:Level = new Level();
			addChild(level);
			trace(level.getChildAt(0));
		}
		
	}
	
}