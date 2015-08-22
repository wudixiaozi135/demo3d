/**
 * Created by Administrator on 2015/8/17.
 */
package gui3D.shapes
{
	import away3d.entities.Mesh;
	import away3d.events.MouseEvent3D;
	import away3d.materials.ColorMaterial;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.primitives.ConeGeometry;

	import constants.ShapeType;

	import gui3D.Geometry3D;
	import gui3D.interf.IAShape;

	import universal.pattern.event.GameDispatcher;
	import universal.pattern.event.GameEventConst;

	public class ACone extends AShapeBase implements IAShape
	{
		private var _coneMesh:Mesh;
		private var _coneGeometry:ConeGeometry;
		private var _colorMaterial:ColorMaterial;

		//Geometry3D的引用
		private var _geometry3d:Geometry3D;

		public function ACone(geometry3d:Geometry3D)
		{
			type = ShapeType.CONE_TYPE;
			_geometry3d = geometry3d;
			_coneGeometry = new ConeGeometry(_radius, _height);
			_colorMaterial = new ColorMaterial(_color, _alpha);
			_colorMaterial.lightPicker = new StaticLightPicker([_geometry3d.light]);
			_coneMesh = new Mesh(_coneGeometry, _colorMaterial);
			addChild(_coneMesh);
			_geometry3d.mainView.scene.addChild(this);
			_coneMesh.mouseEnabled = true;
			addEventListener(MouseEvent3D.MOUSE_DOWN, downEvt);
		}

		private function downEvt(event:MouseEvent3D):void
		{
			GameDispatcher.dispatchEvent(GameEventConst.DOWN_ITEM, {item: this});
		}

		override public function set height(value:Number):void
		{
			super.height = value;
			if (_coneGeometry)
			{
				_coneGeometry.height = _height;
			}
		}

		/**
		 * 特殊化认为圆柱的宽就是直径
		 * */
		override public function get width():Number
		{
			return super.radius * 2;
		}

		override public function set radius(value:Number):void
		{
			super.radius = value;
			if (_coneGeometry)
			{
				_coneGeometry.radius = radius;
			}
		}

		override public function set alpha(value:Number):void
		{
			super.alpha = value;
			if (_colorMaterial)
			{
				_colorMaterial.alpha = _alpha;
			}
		}

		override public function set color(value:uint):void
		{
			super.color = value;
			if (_colorMaterial)
			{
				_colorMaterial.color = _color;
			}
		}

		override public function destroy():void
		{
			super.destroy();
			if (_colorMaterial)
			{
				_colorMaterial.dispose();
				_colorMaterial = null;
			}
			if (_coneGeometry)
			{
				_coneGeometry.dispose();
				_coneGeometry = null;
			}
			if (_coneMesh && _coneMesh.parent)
			{
				_coneMesh.removeEventListener(MouseEvent3D.MOUSE_DOWN, downEvt);
				_coneMesh.parent.removeChild(_coneMesh);
				_coneMesh.dispose();
				_coneMesh = null;
			}
			if (_geometry3d && _geometry3d.mainView && _geometry3d.mainView.scene)
			{
				if (_geometry3d.mainView.scene.contains(this))
				{
					_geometry3d.mainView.scene.removeChild(this);
				}
			}
			_geometry3d && (_geometry3d = null);
		}
	}
}
