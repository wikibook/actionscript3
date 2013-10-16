package
{
	import flash.display.Sprite;
	
	public class MultiCurves1 extends Sprite
	{
		private var numPoints:uint = 9;
		public function MultiCurves1()
		{
			init();
		}
		
		private function init():void
		{
			// 먼저 랜덤한 점의 배열을 설정
			var points:Array = new Array();
			for (var i:int = 0; i < numPoints; i++)
			{
				points[i] = new Object();
				points[i].x = Math.random() * stage.stageHeight;
				points[i].y = Math.random() * stage.stageHeight;
			}
			graphics.lineStyle(1);

			// 이제 첫번째 점으로 이동합니다.
			graphics.moveTo(points[0].x, points[0].y);

			// 그리고 다음 점들을 지나갑니다.
			for (i = 1; i < numPoints; i += 2)
			{
				graphics.curveTo(points[i].x, points[i].y,
								 points[i + 1].x, points[i + 1].y);
			}
		}
	}
}
