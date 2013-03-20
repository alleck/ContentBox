﻿/**
********************************************************************************
ContentBox - A Modular Content Platform
Copyright 2012 by Luis Majano and Ortus Solutions, Corp
www.gocontentbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************
Apache License, Version 2.0

Copyright Since [2012] [Luis Majano and Ortus Solutions,Corp] 

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License. 
You may obtain a copy of the License at 

http://www.apache.org/licenses/LICENSE-2.0 

Unless required by applicable law or agreed to in writing, software 
distributed under the License is distributed on an "AS IS" BASIS, 
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
See the License for the specific language governing permissions and 
limitations under the License.
********************************************************************************
* Handles RSS Feeds
*/
component singleton{

	// DI
	property name="mediaService" 	inject="mediaService@cb";

	/**
	* Deliver Media
	*/
	function index(event,rc,prc){
		prc.mediaPath = trim( replacenocase( event.getCurrentRoutedURL(), event.getCurrentRoute(), "" ) );
		prc.mediaPath = reReplace( prc.mediaPath, "\/$", "" );
		
		// Get the media provider
		var mediaProvider = mediaService.getDefaultProvider();
		
		// Check if media path detected
		if( !len( prc.mediaPath ) OR !mediaProvider.mediaExists( prc.mediaPath ) ){
			// return invalid media
			return invalidMedia(event,rc,prc);
		}
		
		// Announce media delivery
		var iData = { mediaPath = prc.mediaPath, mediaProvider = mediaProvider };
		announceInterception( "cbui_onMediaRequest", iData );
		
		// Deliver it baby!
		mediaProvider.deliverMedia( prc.mediaPath );
	}
	
	/************************************** PRIVATE *********************************************/

	// Invalid Media
	private function invalidMedia(event,rc,prc){
		// Announce invalid media
		var iData = { mediaPath = prc.mediaPath };
		announceInterception( "cbui_onInvalidMediaRequest", iData );
		// Render invalid media
		event.renderData(data="<h1>404: Requested path not found</h1>", statusCode="404", statusText="Requested Path Not Found");
	}
	

}