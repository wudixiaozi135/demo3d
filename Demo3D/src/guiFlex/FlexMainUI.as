/**
 * Created by Administrator on 2015/8/13.
 */
package guiFlex
{
	import guiFlex.app.AppContainer;
	import guiFlex.ui.RightToolUI;
	import guiFlex.ui.TopToolUI;

	public class FlexMainUI extends AppContainer
	{
		public function FlexMainUI()
		{
			mouseEnabled=false;
		}

		override protected function createChildren():void
		{
			super.createChildren();
			var topUI:TopToolUI=TopToolUI.getInstance;
			addElement(topUI);
			topUI.horizontalCenter=0;

			var rightUI:RightToolUI=RightToolUI.getInstance;
			rightUI.setMain(parent);
			addElement(rightUI);
			rightUI.right=0;
		}

		public function destroy():void
		{
			removeAllElements();
			TopToolUI.getInstance.destroy();
			RightToolUI.getInstance.destroy();
			_instance = null;
		}
		private static var _instance:FlexMainUI = null;

		public static function get getInstance():FlexMainUI
		{
			if (_instance == null)
			{
				_instance = new FlexMainUI();
			}
			return _instance;
		}
	}
}
