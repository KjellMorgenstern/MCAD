  /*
 *  OpenSCAD Layout Library (www.openscad.org)
 *  Copyright (C) 2012 Peter Uithoven
 *
 *  License: LGPL 2.1 or later
*/

//list(iHeight);
//grid(iWidth,iHeight,inYDir = true,limit=3)

// Examples:
/*list(15)
{
	square([25,10]);
	square([25,10]);
    square([25,10]);
	square([25,10]);
    square([25,10]);
}*/
/*grid(30,15,false,2)
{
	square([25,10]);
	square([25,10]);
    square([25,10]);
	square([25,10]);
    square([25,10]);
}*/

//----------------------

module column(iWidth)
{
	for (i = [0 : $children-1]) 
		translate([i*iWidth,0]) rotate([0,0,90]) child(i);
}

module list90(iHeight)
{
	for (i = [0 : $children-1]) 
		translate([0,i*iHeight]) rotate([0,0,90]) child(i);
}

module list(iHeight)
{
	for (i = [0 : $children-1]) 
		translate([0,i*iHeight]) child(i);
}
module grid(iWidth,iHeight,inYDir = true,limit=3)
{
	for (i = [0 : $children-1]) 
	{
		translate([(inYDir)? (iWidth)*(i%limit) : (iWidth)*floor(i/limit),
					(inYDir)? (iHeight)*floor(i/limit) : (iHeight)*(i%limit)])
					child(i);
	}
}