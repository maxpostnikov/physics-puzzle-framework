package ru.maxpostnikov.engine.core 
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class Sounds 
	{
		
		private var _channels:Dictionary;
		private var _transform:SoundTransform;
		
		public function Sounds() 
		{
			_channels = new Dictionary();
			_transform = new SoundTransform();
		}
		
		public function play(sound:Sound, loops:int = int.MAX_VALUE):void 
		{
			stop(sound);
			
			_channels[sound] = sound.play(0, loops);
			
			if (loops == 0)
				(_channels[sound] as SoundChannel).addEventListener(Event.SOUND_COMPLETE, onSoundComplete, false, 0, true);
		}
		
		public function stop(sound:Sound):void 
		{
			if (_channels[sound]) {
				(_channels[sound] as SoundChannel).stop();
				
				if ((_channels[sound] as SoundChannel).hasEventListener(Event.SOUND_COMPLETE))
					(_channels[sound] as SoundChannel).removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
				
				_channels[sound] = null;
				delete _channels[sound];
			}
		}
		
		public function mute(value:Boolean):void 
		{
			if (value)
				_transform.volume = 0;
			else
				_transform.volume = 1;
			
			SoundMixer.soundTransform = _transform;
		}
		
		private function onSoundComplete(e:Event):void 
		{
			for (var sound:Object in _channels) {
				if (_channels[sound] == e.target as SoundChannel) stop(sound as Sound);
			}
		}
		
	}

}