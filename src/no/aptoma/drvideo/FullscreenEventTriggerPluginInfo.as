package no.aptoma.drvideo
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.utils.Timer;
	
	import org.osmf.elements.VideoElement;
	import org.osmf.events.MediaElementEvent;
	import org.osmf.media.MediaElement;
	import org.osmf.media.MediaFactoryItem;
	import org.osmf.media.MediaFactoryItemType;
	import org.osmf.media.MediaResourceBase;
	import org.osmf.media.PluginInfo;
	import org.osmf.media.URLResource;
	import org.osmf.traits.DisplayObjectTrait;
	import org.osmf.traits.MediaTraitType;
	
	public class FullscreenEventTriggerPluginInfo extends PluginInfo
	{
		
		public static var FULLSCREEN_BITRATE_LIMITER:String = 
			"http://drvideo.aptoma.no/fullscreenbitratelimiter";
		private var javascriptCallback:String;
		private var settings:Object;
		
		/**
		 * register the plugin as a proxy
		 */
		public function FullscreenEventTriggerPluginInfo()
		{
			var items:Vector.<MediaFactoryItem> = new Vector.<MediaFactoryItem>();
			var item:MediaFactoryItem = new MediaFactoryItem(
				FULLSCREEN_BITRATE_LIMITER
				, canHandleResourceFunction
				, mediaElementCreationFunction,
				MediaFactoryItemType.PROXY
			);
			items.push(item);
			this.settings = new Object();
			trace('FullscreenBitrateLimiterPluginInfo is beeing constructed');
			super(items, creationNotificationFunction);
		}
		
		/**
		 * Can handle all dynamic stream resource that consists of more then one stream
		 */
		private function canHandleResourceFunction(resource:MediaResourceBase):Boolean
		{
			trace('FullscreenBitrateLimiterPluginInfo  can handle this resource');
			var urlResource:URLResource = resource as URLResource;
			if (urlResource == null) {
				return false;
			}
			return true;
		}
		
		private function mediaElementCreationFunction():MediaElement
		{
			trace('FullscreenBitrateLimiterPluginInfo :mediaElementCreationFunction called.');
			return new VideoElement;
		}
		
		/**
		 * @inheritDoc
		 **/
		override public function initializePlugin(resource:MediaResourceBase):void
		{
			this.javascriptCallback = resource.getMetadataValue('callback') as String;
			if (!this.javascriptCallback) {
				trace(
					'FullscreenBitrateLimiterPluginInfo  is missing the callback parameter.'
					+ ' Remove this plugin or add the missing callback parameter.'
					+ ' The name of the parameter starts with the namespace parameter'
					+ ' to the plugin which you find by looking at the name of the'
					+ ' flashvar parameter (plugin_{namespace to this plugin})'
					+ ' the name of the callback parameter is then :'
					+ ' {namespace to this plugin}_callback.'
					+ ' value should be the same as the javascriptCallbackFunction.'
				);
			}
		}
		
		private function creationNotificationFunction(media:MediaElement):void
		{
			media.addEventListener(MediaElementEvent.TRAIT_ADD, registerForAddedToStageEvent);
		}
		
		private function registerForAddedToStageEvent(event:MediaElementEvent):void
		{
			if (event.traitType == MediaTraitType.DISPLAY_OBJECT && !this.settings.hasOwnProperty('media'))
			{
				var media:MediaElement = event.target as MediaElement;
				this.settings.media = media;
				var trait:DisplayObjectTrait = media.getTrait(MediaTraitType.DISPLAY_OBJECT) as DisplayObjectTrait;
				var displayable:DisplayObject = trait.displayObject;
				displayable.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
				event.target.removeEventListener(MediaElementEvent.TRAIT_ADD, registerForAddedToStageEvent);
				trace('FullscreenBitrateLimiterPluginInfo :The display object trait was added.');
			}
		}
		
		/**
		 * the event target has to have a parent that has a property named stage
		 */
		private function onAddedToStage(event:Event):void
		{
			if (!event.target.hasOwnProperty('parent'))
			{
				trace(
					'FullscreenBitrateLimiterPluginInfo : Could not find property parent for the event.target property '
					+ 'This plugin is only compatible with Strobe 1.6'
				);
				return;
			}
			
			var displayable:DisplayObject = event.target.parent;
			if (!displayable.hasOwnProperty('stage'))
			{
				trace(
					'FullscreenBitrateLimiterPluginInfo : Could not find property stage for the parent property '
					+ 'of the current event target. '
					+ 'This plugin is only compatible with Strobe 1.6'
				);
				return;
			}
			
			displayable.stage.addEventListener(
				FullScreenEvent.FULL_SCREEN, onFullScreen
			);
			trace('FullscreenBitrateLimiterPluginInfo : Registered for fullscreen events.');
			event.target.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onFullScreen(event:FullScreenEvent):void
		{
			if (event.fullScreen) {
				trace('FullscreenBitrateLimiterPluginInfo :in fullscreen:{callback:'+this.javascriptCallback+',id:'+ExternalInterface.objectID+',fullscreen:true');
				call([this.javascriptCallback, ExternalInterface.objectID, "fullscreen", true]);
			} else {
				trace('FullscreenBitrateLimiterPluginInfo :out of fullscreen:{callback:'+this.javascriptCallback+',id:'+ExternalInterface.objectID+',fullscreen:false');
				call([this.javascriptCallback, ExternalInterface.objectID, "fullscreen", false]);
			}
		}
		
		private static function call(args:Array, async:Boolean = true):void
		{		
			if (async)
			{
				var asyncTimer:Timer = new Timer(10, 1);	
				asyncTimer.addEventListener(TimerEvent.TIMER, 
					function(event:Event):void
					{
						asyncTimer.removeEventListener(TimerEvent.TIMER, arguments.callee);
						ExternalInterface.call.apply(ExternalInterface, args);
						trace('FullscreenBitrateLimiterPluginInfo :the javascript call was succesfully made.');
					}
				);	
				asyncTimer.start();
			}
			else
			{
				ExternalInterface.call.apply(ExternalInterface, args);
			}
		}
	}
}
