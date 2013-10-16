package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;

	public class AngleBounceOpt extends Sprite
	{
		private var ball:Ball;
		private var line:Sprite;
		private var gravity:Number = 0.3;
		private var bounce:Number = -0.6;
		
		public function AngleBounceOpt()
		{
			init();
		}
		
		private function init():void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			ball = new Ball();
			addChild(ball);
			ball.x = 100;
			ball.y = 100;
			
			line = new Sprite();
			line.graphics.lineStyle(1);
			line.graphics.lineTo(300, 0);
			addChild(line);
			line.x = 50;
			line.y = 200;
			line.rotation = 30;
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(event:Event):void
		{
			// 보통의 모션코드
			ball.vy += gravity;
			ball.x += ball.vx;
			ball.y += ball.vy;
			
			// 각도, 사인, 코사인을 가져옵니다
			var angle:Number = line.rotation * Math.PI / 180;
			var cos:Number = Math.cos(angle);
			var sin:Number = Math.sin(angle);
			
			// 라인과 관계가 있는 공의 위치를 가져옵니다
			var x1:Number = ball.x - line.x;
			var y1:Number = ball.y - line.y;
			
			// 좌표 회전
			var y2:Number = cos * y1 - sin * x1;
			
			// 회전된 값으로 바운드 수행
			if(y2 > -ball.height / 2)
			{
				// 좌표 회전
				var x2:Number = cos * x1 + sin * y1;
				
				// 속도 회전
				var vx1:Number = cos * ball.vx + sin * ball.vy;
				var vy1:Number = cos * ball.vy - sin * ball.vx;
			
				y2 = -ball.height / 2;
				vy1 *= bounce;
				
				// 원래대로 다시 회전
				x1 = cos * x2 - sin * y2;
				y1 = cos * y2 + sin * x2;
				ball.vx = cos * vx1 - sin * vy1;
				ball.vy = cos * vy1 + sin * vx1;
				ball.x = line.x + x1;
				ball.y = line.y + y1;
			}
		}
	}
}