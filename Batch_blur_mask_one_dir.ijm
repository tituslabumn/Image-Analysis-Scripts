//run this on a list of directories where the subdirectorise have a raw image and create a mask
//cannot tolerate subfolders without an image with the suffix 


mainDir = getDirectory("Choose a main directory "); 
mainList = getFileList(mainDir); 


Dialog.create("Create Masks on a Directory of Sub Directories");
Dialog.addString("image Suffix:", "_c488");


Dialog.show();
imageSuffix = Dialog.getString() + ".tiff";


//for (i=0; i<mainList.length; i++) {  // for loop to parse through names in main folder 

      //if(endsWith(mainList[i], "/")){   // a '/" indicates that the name is a subfolder... 
   
           //subDir = mainDir + mainList[i]; 
           //subList = getFileList(subDir); 
			
           		for (m=0; m<mainList.length; m++) { //clunky, loops thru all items in folder looking for image
		    		if (endsWith(mainList[m], imageSuffix)) { 
		   	 			open(mainDir+mainList[m]);
		   	 			
		   	 			
		   	 			im_title = getTitle();
			    		index = indexOf(im_title, imageSuffix);
         				name = substring(im_title, 0, index);
         				
 						//run("Subtract Background...", "rolling=50 stack");
						//run("Despeckle", "stack");
						run("Gaussian Blur...", "sigma=2 stack");
						run("8-bit");
						setAutoThreshold("Huang dark");
						setOption("BlackBackground", true);
						run("Convert to Mask", "method=Huang background=Dark black");
						run("Fill Holes", "stack");
						run("Erode", "stack");
						run("Erode", "stack");
	    				run("Erode", "stack");
						saveAs("tiff", mainDir+name+"_mask");	
						//		    		
		    			}
           			}          						    
			    im_title = getTitle();	    		
				selectWindow(im_title);
 				close();    
		    // execute all tasks while in subfolder
//all images in main directory	



