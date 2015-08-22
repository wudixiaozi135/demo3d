/**
 * Created by Administrator on 2015/8/18.
 */
package gui3D
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import gui3D.shapes.CubeSpread;

	/**
	 * 3d展览层
	 * */
	public class ExhibitLayer extends Sprite
	{
		public function ExhibitLayer()
		{
			if (stage)
			{
				init();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}

		private function init(e:Event = null):void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			removeEventListener(Event.ADDED_TO_STAGE, init);

			var cube:CubeSpread = new CubeSpread();
			addChild(cube);

			var bool:Boolean = true;
			stage.addEventListener(MouseEvent.CLICK, function ():void
			{
				if (bool)
				{
					cube.unfold();
				} else
				{
					cube.fold();
				}
				bool = !bool;
			});
		}

		public function destroy():void
		{

		}

		private static var _instance:ExhibitLayer = null;

		public static function get getInstance():ExhibitLayer
		{
			if (_instance == null)
			{
				_instance = new ExhibitLayer();
			}
			return _instance;
		}
	}
}
