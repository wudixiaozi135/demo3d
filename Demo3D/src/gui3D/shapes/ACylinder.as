/**
 * Created by Administrator on 2015/8/17.
 */
package gui3D.shapes
{
	import away3d.entities.Mesh;
	import away3d.events.MouseEvent3D;
	import away3d.materials.ColorMaterial;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.primitives.CylinderGeometry;

	import constants.ShapeType;

	import gui3D.Geometry3D;
	import gui3D.interf.IAShape;

	import universal.pattern.event.GameDispatcher;
	import universal.pattern.event.GameEventConst;

	public class ACylinder extends AShapeBase implements IAShape
	{
		private var _cylinderMesh:Mesh;
		private var _cylinderGeometry:CylinderGeometry;
		private var _colorMaterial:ColorMaterial;

		//Geometry3D的引用
		private var _geometry3d:Geometry3D;

		public function ACylinder(geometry3d:Geometry3D)
		{
			type = ShapeType.CYLINDER_TYPE;
			_geometry3d = geometry3d;
			_cylinderGeometry = new CylinderGeometry(_radius, _radius, _height);
			_colorMaterial = new ColorMaterial(_color, _alpha);
			_colorMaterial.lightPicker = new StaticLightPicker([_geometry3d.light]);
			_cylinderMesh = new Mesh(_cylinderGeometry, _colorMaterial);
			addChild(_cylinderMesh);
			_geometry3d.mainView.scene.addChild(this);
			_cylinderMesh.mouseEnabled = true;
			addEventListener(MouseEvent3D.MOUSE_DOWN, downEvt);
		}

		private function downEvt(event:MouseEvent3D):void
		{
			GameDispatcher.dispatchEvent(GameEventConst.DOWN_ITEM, {item: this});
		}

		override public function set height(value:Number):void
		{
			super.height = value;
			if (_cylinderGeometry)
			{
				_cylinderGeometry.height = _height;
			}
		}

		override public function set radius(value:Number):void
		{
			super.radius = value;
			if (_cylinderGeometry)
			{
				_cylinderGeometry.topRadius = _cylinderGeometry.bottomRadius = radius;
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
			if (_cylinderGeometry)
			{
				_cylinderGeometry.dispose();
				_cylinderGeometry = null;
			}
			if (_cylinderMesh && _cylinderMesh.parent)
			{
				_cylinderMesh.removeEventListener(MouseEvent3D.MOUSE_DOWN, downEvt);
				_cylinderMesh.parent.removeChild(_cylinderMesh);
				_cylinderMesh.dispose();
				_cylinderMesh = null;
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
