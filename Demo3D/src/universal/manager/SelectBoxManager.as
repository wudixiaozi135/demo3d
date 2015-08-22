/**
 * Created by Administrator on 2015/8/14.
 */
package universal.manager
{
	import gui3D.interf.IAShape;

	public class SelectBoxManager
	{
		private var _selectShape:IAShape;
		private static var _instance:SelectBoxManager = null;

		public static function get getInstance():SelectBoxManager
		{
			if (_instance == null)
			{
				_instance = new SelectBoxManager();
			}
			return _instance;
		}

		public function set selectShape(selectBox:IAShape):void
		{
			_selectShape = selectBox;
		}

		public function get selectShape():IAShape
		{
			return _selectShape;
		}

		public function destroy():void
		{
			_selectShape = null;
			_instance = null;
		}
	}
}
