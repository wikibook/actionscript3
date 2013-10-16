package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class MultiCurves2 extends Sprite
	{
		private var numPoints:uint = 9;
		public function MultiCurves2()
		{
			init();
		}
		
		private function init():void
		{
			// 먼저 임의의 점의 배열을 설정합니다
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

			// 곡선을 그리고 매 중간점에서 멈춥니다
			for (i = 1; i < numPoints - 2; i ++)
			{
				var xc:Number = (points[i].x + points[i + 1].x) / 2;
				var yc:Number = (points[i].y + points[i + 1].y) / 2;
				graphics.curveTo(points[i].x, points[i].y, xc, yc);
			}
			// 마지막 두 점의 곡선을 그립니다
			graphics.curveTo(points[i].x, points[i].y, points[i+1].x, points[i+1].y);
		}
	}
}
