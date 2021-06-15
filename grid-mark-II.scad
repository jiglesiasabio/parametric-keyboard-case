$fn=50;
plateZ=2;
rows=4;
columns=12;
switchSide = 14.2;
switchMargin = 4;
plateMargin=4;
plateBoxZ=4;
plateBoxThickness=2;

minkowskiCylinderRadius=2;


//plateW=columns*(switchSide + switchMargin)+2*plateMargin - switchMargin;
//plateH=rows*(switchSide + switchMargin)+2*plateMargin - switchMargin;

plateW=(columns*switchSide) + (columns-1)*switchMargin +2*plateMargin;
plateH=(rows*switchSide) + (rows-1)*switchMargin +2*plateMargin;

echo("plateW=", plateW, " plateH=", plateH);

module platePlane(){
minkowski()
{
  cube([plateH,plateW,plateZ]);
  cylinder(r=minkowskiCylinderRadius,h=plateZ);
}
}

module plateBox(){
    difference(){
        
        minkowski()
        {
          cube([plateH+plateBoxThickness*2,plateW+plateBoxThickness*2,plateBoxZ]);
          cylinder(r=minkowskiCylinderRadius,h=plateBoxZ);
        }
        
        translate([plateBoxThickness,plateBoxThickness,0])
        minkowski()
        {
          cube([plateH,plateW,plateBoxZ]);
          cylinder(r=minkowskiCylinderRadius,h=plateBoxZ);
        }
        
        
    }

}


module holes(){
for(i=[0:columns-1]){
    for(j=[0:rows-1]){
        translate([(switchSide+switchMargin)*j,(switchSide+switchMargin)*i,0])
        cube([switchSide,switchSide,4]);
    }
    
}
}


plateBox();
translate([plateBoxThickness,plateBoxThickness,0])
difference(){
    platePlane();
    translate([plateMargin,plateMargin,0])
    holes();
    }





 


   