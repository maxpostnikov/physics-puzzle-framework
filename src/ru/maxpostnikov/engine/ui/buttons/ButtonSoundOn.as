package ru.maxpostnikov.engine.ui.buttons 
{
	import flash.events.Event;
	import ru.maxpostnikov.engine.Engine;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ButtonSoundOn extends Button
	{
		
		private var _buttonSoundOff:ButtonSoundOff;
		
		public function ButtonSoundOn() 
		{
			_buttonSoundOff = new bSoundOff();
			_buttonSoundOff.x = this.x;
			_buttonSoundOff.y = this.y;
			_buttonSoundOff.scaleX = this.scaleX;
			_buttonSoundOff.scaleY = this.scaleY;
			_buttonSoundOff.visible = false;
			_buttonSoundOff.buttonSoundOn = this;
			
			this.parent.addChild(_buttonSoundOff);
			
			super();
		}
		
		override protected function onAddedToStage(e:Event):void 
		{
			super.onAddedToStage(e);
			
			if (_buttonSoundOff) {
				if (Engine.getInstacne().isMuted) {
					this.visible = false;
					_buttonSoundOff.visible = true;
				} else {
					this.visible = true;
					_buttonSoundOff.visible = false;
				}
			}
		}
		
		override protected function click():void 
		{
			Engine.getInstacne().mute();
			
			if (_buttonSoundOff)
				_buttonSoundOff.visible = true;
			
			this.visible = false;
		}
		
	}

}