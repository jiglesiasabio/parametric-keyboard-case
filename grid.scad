/*
Cherry switches dimesions:
    14*14 mm
    mountplate click: 2mm
    
    Assuming 4mm between switches in the mount plate is ok...
    
    there is probably not enough space inside the box for hand wiring and board...
*/
/*difference(){
    cube([12*(14+4)+4,4*(14+4)+4,2]);
    
    for(j=[0:3]){
        for(i=[0:11]){
            translate([(18*i)+4,(18*j)+4])
            cube([14,14,4]);    
        }     
    }  
}*/

/*translate([-4,-4,-15]){

    translate([4,4,0])
    difference(){
        cube([12*(14+4)+4,4*(14+4)+4,8]);
        translate([2,2])
        cube([12*(14+4),4*(14+4),8]);
    }
    
    difference(){
        cube([12*(14+4)+4+8,4*(14+4)+4+8,10]);
        translate([4,4,2])
        cube([12*(14+4)+4,4*(14+4)+4,8]);
    } 
}*/



// Parameters
rows = 4;
columns = 12;
switchSide = 14.2;
interSwitchMargin = 5;
externalMargin = 5;

plateWidth = columns * (14 + interSwitchMargin) + externalMargin;
plateHeight = rows * (14 + interSwitchMargin) + externalMargin;
plateZ = 2;

plateBoxMargin = 15;
plateBoxHeight = 15;

boxScrewRadius = 1.5;
boxScrewMargin = 5;


// Upper Box
difference(){
    cube([plateWidth+plateBoxMargin, plateHeight+plateBoxMargin, plateBoxHeight]);
    translate([plateBoxMargin/2, plateBoxMargin/2])
    cube([plateWidth, plateHeight, plateBoxHeight]);
    
    screwPostHeight = plateBoxHeight-2;
    
    translate([boxScrewMargin, boxScrewMargin])
    cylinder(screwPostHeight,boxScrewRadius,boxScrewRadius);
    
    translate([plateWidth+plateBoxMargin-boxScrewMargin, boxScrewMargin])
    cylinder(screwPostHeight,boxScrewRadius,boxScrewRadius);
    
    translate([plateWidth+plateBoxMargin-boxScrewMargin, plateHeight+plateBoxMargin-boxScrewMargin])
    cylinder(screwPostHeight,boxScrewRadius,boxScrewRadius);
    
    translate([boxScrewMargin, plateHeight+plateBoxMargin-boxScrewMargin])
    cylinder(screwPostHeight,boxScrewRadius,boxScrewRadius);    
}

// Switch plate
translate([plateBoxMargin/2, plateBoxMargin/2, plateBoxHeight - plateZ])
difference(){
    cube([plateWidth, plateHeight, plateZ]);
    
    for(j=[0:rows - 1]){
        for(i=[0:columns - 1]){
            translate([
                ((switchSide + interSwitchMargin) * i) + interSwitchMargin,
                ((switchSide + interSwitchMargin) * j) + interSwitchMargin
            ])
            cube([switchSide,switchSide,plateZ + 1]);    
        }     
    }  
}

// Lower box
// TODO - Height is too much!
rotate([0,180,0])
translate([10, 0, -10])

difference(){
    cube([plateWidth+plateBoxMargin, plateHeight+plateBoxMargin, 10]);
    translate([plateBoxMargin/2, plateBoxMargin/2, 2])
    cube([plateWidth, plateHeight, 12]);
    
    bottomBoxScrewPostHeight = 14;
    
    translate([boxScrewMargin, boxScrewMargin])
    cylinder(bottomBoxScrewPostHeight,boxScrewRadius,boxScrewRadius);
    
    translate([plateWidth+plateBoxMargin-boxScrewMargin, boxScrewMargin])
    cylinder(bottomBoxScrewPostHeight,boxScrewRadius,boxScrewRadius);
    
    translate([plateWidth+plateBoxMargin-boxScrewMargin, plateHeight+plateBoxMargin-boxScrewMargin])
    cylinder(bottomBoxScrewPostHeight,boxScrewRadius,boxScrewRadius);
    
    translate([boxScrewMargin, plateHeight+plateBoxMargin-boxScrewMargin])
    cylinder(bottomBoxScrewPostHeight,boxScrewRadius,boxScrewRadius);
}



