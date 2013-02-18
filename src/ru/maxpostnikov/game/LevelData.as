package ru.maxpostnikov.game 
{
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class LevelData 
	{
		
		public static const SCORE_TIMER:Number = 0;
		
		private const _SCORE_INITIAL:Number = 0;
		private const _SCORE_ON_TIMER:Number = 0;
		
		private var _time:Number;
		private var _score:Number;
		private var _highscore:Number;
		private var _isClosed:Boolean;
		private var _isPassed:Boolean;
		
		public function LevelData() 
		{
			_isClosed = true;
		}
		
		public function init():void 
		{
			_time = 0;
			_score = _SCORE_INITIAL;
			
			_isClosed = false;
		}
		
		public function step():void 
		{
			_time += SCORE_TIMER;
			_score += _SCORE_ON_TIMER;
			
			if (_score < 0) _score = 0;
		}
		
		public function passed():void 
		{
			_isPassed = true;
		}
		
	}

}