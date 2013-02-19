package ru.maxpostnikov.engine.core 
{
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	internal class LevelData 
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
		
		public function save():Object 
		{
			return { time:_time, score:_score, highscore:_highscore, isClosed:_isClosed, isPassed:_isPassed };
		}
		
		public function load(data:Object):void 
		{
			_time = data.time;
			_score = data.score;
			_highscore = data.highscore;
			_isClosed = data.isClosed;
			_isPassed = data.isPassed;
		}
		
		public function get isClosed():Boolean { return _isClosed; }
		
	}

}