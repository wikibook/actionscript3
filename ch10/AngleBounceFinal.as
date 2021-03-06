package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.geom.Rectangle;

	public class AngleBounceFinal extends Sprite
	{
		private var ball:Ball;
		private var line:Sprite;
		private var gravity:Number = 0.3;
		private var bounce:Number = -0.6;
		
		public function AngleBounceFinal()
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
			line.rotation = (stage.stageWidth/ 2 - mouseX) * .1;
			
			// normal motion code
			ball.vy += gravity;
			ball.x += ball.vx;
			ball.y += ball.vy;
			
			if(ball.x + ball.radius > stage.stageWidth)
			{
				ball.x = stage.stageWidth - ball.radius;
				ball.vx *= bounce;
			}
			else if(ball.x - ball.radius < 0)
			{
				ball.x = ball.radius;
				ball.vx *= bounce;
			}
			if(ball.y + ball.radius > stage.stageHeight)
			{
				ball.y = stage.stageHeight - ball.radius;
				ball.vy *= bounce;
			}
			else if(ball.y - ball.radius < 0)
			{
				ball.y = ball.radius;
				ball.vy *= bounce;
			}
			
			var bounds:Rectangle = line.getBounds(this);
			if(ball.x > bounds.left && ball.x < bounds.right)
			{
				
				// 각도, 사인, 코사인을 가져옵니다
				var angle:Number = line.rotation * Math.PI / 180;
				var cos:Number = Math.cos(angle);
				var sin:Number = Math.sin(angle);
				
				// 라인과 관계가 있는 공의 위치를 가져옵니다
				var x1:Number = ball.x - line.x;
				var y1:Number = ball.y - line.y;
				
				// 좌표 회전
				var y2:Number = cos * y1 - sin * x1;
				
				// 속도 회전
				var vy1:Number = cos * ball.vy - sin * ball.vx;
				
				// 회전된 값으로 바운드 수행
				if(y2 > -ball.height / 2 && y2 < vy1)
				{
					// 좌표 회전
					var x2:Number = cos * x1 + sin * y1;
					
					// 속도 회전
					var vx1:Number = cos * ball.vx + sin * ball.vy;
				
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
}