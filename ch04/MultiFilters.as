package
{
	import flash.display.Sprite;
	import flash.filters.BlurFilter;
	import flash.filters.DropShadowFilter;
	
	public class MultiFilters extends Sprite
	{
		public function MultiFilters()
		{
			init();
		}
		
		private function init():void
		{
			var sprite:Sprite = new Sprite();
			sprite.graphics.lineStyle(2);
			sprite.graphics.beginFill(0xffff00);
			sprite.graphics.drawRect(100, 100, 100, 100);
			sprite.graphics.endFill()
			addChild(sprite);
			
			// 첫번째 필터
			sprite.filters = [new BlurFilter(5, 5, 3)];

			// 두번째 필터
			var filters:Array = sprite.filters;
			filters.push(new DropShadowFilter(10, 45, 0, 1, 10, 10, .3));
			sprite.filters = filters;
			
			// 빠른 방법
			//sprite.filters = sprite.filters.concat(new BlurFilter(5, 5, 3));
			//sprite.filters = sprite.filters.concat(new DropShadowFilter(10, 45, 0, 1, 10, 10, .3));
			
		}
	}
}
