package
{
	// flash classes
	import flash.display.Sprite;

	import gui3D.Geometry3D;

	import guiFlex.FlexMainUI;

	public class Main extends Sprite
	{
		public function Main()
		{
			addChild(Geometry3D.getInstance);
			addChild(FlexMainUI.getInstance);
//			addChild(ExhibitLayer.getInstance);
		}

		public function destroy():void
		{
			removeChild(Geometry3D.getInstance);
			removeChild(FlexMainUI.getInstance);
			Geometry3D.getInstance.destroy();
			FlexMainUI.getInstance.destroy();
		}
	}
}