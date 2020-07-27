/*
Cherry switches dimesions:
    14*14 mm
    mountplate click: 2mm
    
    Assuming 4mm between switches in the mount plate is ok...
    
    there is probably not enough space inside the box for hand wiring and board...
*/
difference(){
    cube([12*(14+4)+4,4*(14+4)+4,2]);
    
    for(j=[0:3]){
        for(i=[0:11]){
            translate([(18*i)+4,(18*j)+4])
            cube([14,14,4]);    
        }     
    }  
}

translate([-4,-4,-15]){

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
    
    
}

