/**
 * Created by Administrator on 2015/8/14.
 */
package universal.manager
{
	import constants.ShapeType;

	import gui3D.Geometry3D;
	import gui3D.interf.IAShape;
	import gui3D.shapes.ACone;
	import gui3D.shapes.ACube;
	import gui3D.shapes.ACylinder;
	import gui3D.shapes.ASphere;

	public class ShapeFactoryManager
	{
		private var _geometry3D:Geometry3D;

		public function ShapeFactoryManager()
		{
		}

		public function initGeometry3D(geometry3D:Geometry3D):void
		{
			_geometry3D = geometry3D;
		}

		public function createShape(type:int):IAShape
		{
			switch (type)
			{
				case ShapeType.CUBE_TYPE:
					return new ACube(_geometry3D);
				case ShapeType.CYLINDER_TYPE:
					return new ACylinder(_geometry3D);
				case ShapeType.CONE_TYPE:
					return new ACone(_geometry3D);
				case ShapeType.SHHERE_TYPE:
					return new ASphere(_geometry3D);
			}
			return null;
		}

		public function destroy():void
		{
			_geometry3D = null;
			_instance = null;
		}

		private static var _instance:ShapeFactoryManager = null;

		public static function get getInstance():ShapeFactoryManager
		{
			if (_instance == null)
			{
				_instance = new ShapeFactoryManager();
			}
			return _instance;
		}
	}
}
