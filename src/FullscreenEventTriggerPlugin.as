package
{
	import flash.display.Sprite;
	
	import no.aptoma.drvideo.FullscreenEventTriggerPluginInfo;
	
	import org.osmf.media.PluginInfo;
	
	public class FullscreenEventTriggerPlugin extends Sprite
	{
		private var fullscreenEventTriggerInfo:FullscreenEventTriggerPluginInfo;
		
		public function FullscreenEventTriggerPlugin()
		{
			this.fullscreenEventTriggerInfo = new FullscreenEventTriggerPluginInfo();
		}
		
		public function get pluginInfo():PluginInfo
		{
			return this.fullscreenEventTriggerInfo;
		}
	}
}