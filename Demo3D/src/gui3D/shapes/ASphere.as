/**
 * Created by Administrator on 2015/8/17.
 */
package gui3D.shapes
{
	import away3d.entities.Mesh;
	import away3d.events.MouseEvent3D;
	import away3d.materials.ColorMaterial;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.primitives.SphereGeometry;

	import constants.ShapeType;

	import gui3D.Geometry3D;
	import gui3D.interf.IAShape;

	import universal.pattern.event.GameDispatcher;
	import universal.pattern.event.GameEventConst;

	public class ASphere extends AShapeBase implements IAShape
	{
		private var _sphereMesh:Mesh;
		private var _sphereGeometry:SphereGeometry;
		private var _colorMaterial:ColorMaterial;

		//Geometry3D的引用
		private var _geometry3d:Geometry3D;

		public function ASphere(geometry3d:Geometry3D)
		{
			type = ShapeType.SHHERE_TYPE;
			_geometry3d = geometry3d;
			_sphereGeometry = new SphereGeometry(_radius);
			_colorMaterial = new ColorMaterial(_color, _alpha);
			_colorMaterial.lightPicker = new StaticLightPicker([_geometry3d.light]);
			_sphereMesh = new Mesh(_sphereGeometry, _colorMaterial);
			addChild(_sphereMesh);
			_geometry3d.mainView.scene.addChild(this);
			_sphereMesh.mouseEnabled = true;
			addEventListener(MouseEvent3D.MOUSE_DOWN, downEvt);
		}

		private function downEvt(event:MouseEvent3D):void
		{
			GameDispatcher.dispatchEvent(GameEventConst.DOWN_ITEM, {item: this});
		}

		/**
		 * 特殊化认为球的宽就是直径
		 * */
		override public function get width():Number
		{
			return super.radius * 2;
		}

		/**
		 * 特殊化认为球的高就是直径
		 * */
		override public function get height():Number
		{
			return super.radius * 2;
		}

		override public function set radius(value:Number):void
		{
			super.radius = value;
			if (_sphereGeometry)
			{
				_sphereGeometry.radius = radius;
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
			if (_sphereGeometry)
			{
				_sphereGeometry.dispose();
				_sphereGeometry = null;
			}
			if (_sphereMesh && _sphereMesh.parent)
			{
				_sphereMesh.removeEventListener(MouseEvent3D.MOUSE_DOWN, downEvt);
				_sphereMesh.parent.removeChild(_sphereMesh);
				_sphereMesh.dispose();
				_sphereMesh = null;
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
