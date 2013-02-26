package ru.maxpostnikov.engine.ui.buttons 
{
	import ru.maxpostnikov.engine.Engine;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ButtonSoundOn extends Button
	{
		
		private var _buttonSoundOff:ButtonSoundOff;
		
		override protected function click():void 
		{
			Engine.getInstacne().mute();
			
			if (!_buttonSoundOff) {
				_buttonSoundOff = new bSoundOff();
				_buttonSoundOff.x = this.x;
				_buttonSoundOff.y = this.y;
				_buttonSoundOff.buttonSoundOn = this;
				
				this.parent.addChild(_buttonSoundOff);
			} else {
				_buttonSoundOff.visible = true;
			}
			
			this.visible = false;
		}
		
	}

}