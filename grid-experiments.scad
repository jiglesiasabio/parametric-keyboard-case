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
columns = 5;
switchSide = 14.2;
interSwitchMargin = 5;
externalMargin = 5;

plateZ=2;



plateBoxMargin = 15;
plateBoxHeight = 15;

boxScrewRadius = 1.5;
boxScrewMargin = 5;

//last 4 is 2 * minkowski radius
fullPlateWidth = columns * (14 + interSwitchMargin) + externalMargin + 4;
ooo = sin(160)*(fullPlateWidth/sin((180-160)/2));


plateWidth = columns * (14 + interSwitchMargin) + externalMargin;
    plateHeight = rows * (14 + interSwitchMargin) + externalMargin;
    plateZ = 2;


module plate( rows, columns, plateZ, minus=0 ) {
    difference(){
        
        plateWidth = columns * (14 + interSwitchMargin) + externalMargin - minus;
        plateHeight = rows * (14 + interSwitchMargin) + externalMargin - minus;

        //Plate
        minkowski()
        {
            cube([plateWidth,plateHeight,plateZ]);
            cylinder(r=2,h=plateZ-1);
        }
        
        //vaciado cilindros
        //top right post
        cylinder(plateZ+7,5,5);
        
        //top left post
        translate([plateWidth,0,0])
        cylinder(plateZ+7,5,5);
        
        //bottom right post
        translate([0,plateHeight,0])
        cylinder(plateZ+7,5,5);
            
        //bottom left post
        translate([plateWidth,plateHeight,0])
        cylinder(plateZ+7,5,5);
    }
}

module plateBorder( rows, columns ) {
    plateWidth = columns * (14 + interSwitchMargin) + externalMargin;
    plateHeight = rows * (14 + interSwitchMargin) + externalMargin;
    plateZ = 2;
    
    difference(){
        difference(){                
                minkowski()
                {
                    cube([plateWidth,plateHeight,plateZ+2]);
                    cylinder(r=2,h=plateZ+2);
                }
            
                translate([2,2,0])
                minkowski()
                {
                    cube([plateWidth-4,plateHeight-4,plateZ+2]);
                    cylinder(r=2,h=plateZ+2);
                }            
            }
            
            //vaciado cilindros
            //top right post
            cylinder(plateZ+7,5,5);
            
            //top left post
            translate([plateWidth,0,0])
            cylinder(plateZ+7,5,5);
            
            //bottom right post
            translate([0,plateHeight,0])
            cylinder(plateZ+7,5,5);
                
            //bottom left post
            translate([plateWidth,plateHeight,0])
            cylinder(plateZ+7,5,5);
    }
    
    //top right post
    difference(){
        cylinder(plateZ+7,5,5);
        cylinder(plateZ+7,3,3);
    }
    
    //top left post
    translate([plateWidth,0,0])
    difference(){
        cylinder(plateZ+7,5,5);
        cylinder(plateZ+7,3,3);
    }
    
    //bottom right post
    translate([0,plateHeight,0])
    difference(){
        cylinder(plateZ+7,5,5);
        cylinder(plateZ+7,3,3);
    }
    
    //bottom left post
    translate([plateWidth,plateHeight,0])
    difference(){
        cylinder(plateZ+7,5,5);
        cylinder(plateZ+7,3,3);
    }
}







module holes( rows, columns ) {
       plateZ = 2;
    
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


//everything
rotate([0,0,10])
union(){
    
    
    //Keyboard Top
    union(){
        difference(){
            hull(){
            //L Plate
            plate(rows,columns,plateZ);

            //R Plate
            translate([columns * (14 + interSwitchMargin) + externalMargin,0,0])
            rotate([0,0,-20])
            plate(rows,columns,plateZ);
            }
            
            //L Plate Holes
            holes(rows,columns);

            //R Plate Holes
            translate([columns * (14 + interSwitchMargin) + externalMargin,0,0])
            rotate([0,0,-20])
            holes(rows,columns);
            
            
            
            
            // TODO bien en mano derecha, mal todavia en mano izquierda
            //vaciado cilindros
            //top right post
            cylinder(plateZ+7,5,5);
            
            //top left post
            translate([plateWidth,0,0])
            cylinder(plateZ+7,5,5);
            
            //bottom right post
            translate([0,plateHeight,0])
            cylinder(plateZ+7,5,5);
                
            //bottom left post
            translate([plateWidth,plateHeight,0])
            cylinder(plateZ+7,5,5);
            
            
            
        }
        
        //Borders
        union(){
            //L Plate Border
            plateBorder(rows,columns);

            //R Plate Border
            translate([columns * (14 + interSwitchMargin) + externalMargin,0,0])
            rotate([0,0,-20])
            plateBorder(rows,columns);
        }

    }
    
    
    bottomBoxZ=8;
    
    //Bottom
    translate([0,0,-50])
    difference(){
        //The Box itself
        union(){
            difference(){
                //Floor
                hull(){
                    //L Plate
                    plate(rows,columns,bottomBoxZ);

                    //R Plate
                    translate([columns * (14 + interSwitchMargin) + externalMargin,0,0])
                    rotate([0,0,-20])
                    plate(rows,columns,bottomBoxZ);
                }
                
                //Box walls
                translate([3,3,2])
                hull(){
                    //L Plate
                    plate(rows,columns,bottomBoxZ,6);

                    //R Plate
                    translate([columns * (14 + interSwitchMargin) + externalMargin+1,-1,0])
                    rotate([0,0,-20])
                    plate(rows,columns,bottomBoxZ,6);
                }
            }
            
            //Posts
        
            //Post A
            rotate([0,0,-10])
            translate([(ooo/2)-10,30,1])
            cube([10,5,bottomBoxZ+6]);
            
            //Post B
            rotate([0,0,-10])
            translate([(ooo/2)-10,70,1])
            cube([10,5,bottomBoxZ+6]);
        }
        
        //Cable hole
        rotate([0,0,-10])
        union(){
            
            translate([(ooo/2)-8,-2,8])
            cube([5,5,8]);
            
        }        
    }   
}









