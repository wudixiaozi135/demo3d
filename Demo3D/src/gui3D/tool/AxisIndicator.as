package gui3D.tool
{
	import away3d.containers.Scene3D;
	import away3d.debug.Trident;
	import away3d.primitives.WireframePlane;

	/**
	 * 3d空间坐标指示器
	 * 包括3条坐标系指示线，1个XZ坐标平面
	 */
	public class AxisIndicator
	{
		private var _scene:Scene3D;
		private var _segmentPlane:WireframePlane;
		private var _trident:Trident;
		private var _visible:Boolean;

		public function AxisIndicator(scene:Scene3D)
		{
			_scene = scene;
			init();
		}

		private function init():void
		{
			_trident = new Trident(1000, true);
			_segmentPlane = new WireframePlane(6000, 6000, 10, 10, 0xffffff, .4, "xz");
		}

		public function get visible():Boolean
		{
			return _visible;
		}

		/**
		 * 设置是否要在舞台上显示
		 * @param value
		 *
		 */
		public function set visible(value:Boolean):void
		{
			_visible = value;
			if (value)
			{
				_scene.addChild(_trident);
				_scene.addChild(_segmentPlane);
			} else
			{
				_scene.removeChild(_segmentPlane);
				_scene.removeChild(_trident);
			}
		}

		public function get trident():Trident
		{
			return _trident;
		}

		public function destroy():void
		{
			if (_trident && _trident.parent)
			{
				_trident.parent.removeChild(_trident);
				_trident.dispose();
				_trident = null;
			}
			if (_segmentPlane && _segmentPlane.parent)
			{
				_segmentPlane.parent.removeChild(_segmentPlane);
				_segmentPlane.dispose();
				_segmentPlane = null;
			}
			_scene && (_scene = null);
		}
	}
}