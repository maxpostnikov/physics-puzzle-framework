package ru.maxpostnikov.engine.ui.buttons 
{
	import ru.maxpostnikov.engine.Engine;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ButtonSoundOff extends Button
	{
		
		public var buttonSoundOn:ButtonSoundOn;
		
		override protected function click():void 
		{
			Engine.getInstacne().mute();
			
			if (buttonSoundOn) 
				buttonSoundOn.visible = true;
			
			this.visible = false;
		}
		
	}

}