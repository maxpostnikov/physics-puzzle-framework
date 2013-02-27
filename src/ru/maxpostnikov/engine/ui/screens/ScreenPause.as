package ru.maxpostnikov.engine.ui.screens 
{
	import flash.events.MouseEvent;
	import ru.maxpostnikov.engine.Engine;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ScreenPause extends Screen
	{
		
		public static const ID:uint = 2;
		
		public function ScreenPause() 
		{
			visual = new sPause();
			
			super();
		}
		
		override public function show(data:Object = null):void 
		{
			addEventListener(MouseEvent.CLICK, onClick, false, 0, true);
		}
		
		override public function hide():void 
		{
			removeEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(e:MouseEvent):void 
		{
			Engine.getInstacne().pause();
		}
		
		override public function getID():uint { return ID; }
		
	}

}