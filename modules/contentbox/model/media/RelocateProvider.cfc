/**
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
* Deliver file via cfcontent
*/
component accessors="true" implements="contentbox.model.media.IMediaProvider" singleton{
	
	// Dependecnies
	property name="mediaService"		inject="mediaService@cb";
	property name="log"					inject="logbox:logger:{this}";
	property name="fileUtils" 			inject="coldbox:plugin:FileUtils";
	
	/**
	* Constructor
	*/
	any function init(){
		return this;
	}
	
	/**
	* The internal name of the provider
	*/
	function getName(){
		return "RelocateProvider";
	}
	
	/**
	* Get the display name of a provider
	*/
	function getDisplayName(){
		return "Relocation Provider";
	}
	
	/**
	* Get the description of this provider
	*/
	function getDescription(){
		return "This provider relocates to the requested media path.";
	}
	
	/**
	* Validate if a media requested exists
	* @mediaPath.hint the media path to verify if it exists
	*/
	boolean function mediaExists(required mediaPath){
		return fileExists( getRealMediaPath( arguments.mediaPath ) );
	}
	
	/**
	* Deliver the media
	* @mediaPath.hint the media path to deliver back to the user
	*/
	any function deliverMedia(required mediaPath){
		// get the real path
		var realPath = getRealMediaPath( arguments.mediaPath );
		// Deliver the file
		fileUtils.sendFile( file=realPath, 
							disposition="inline", 
							mimeType=getPageContext().getServletContext().getMimeType( realPath ) );
	}
	
	/************************************** PRIVATE *********************************************/
	
	private function getRealMediaPath(required mediaPath){
		return mediaService.getCoreMediaRoot( absolute=true ) & "/#arguments.mediaPath#";
	}
	
}