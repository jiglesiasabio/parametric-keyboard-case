switchSide = 14.2;
topWidth = 60;
bottomWidth = 20;
depth = 30;
wallThickness = 2;

difference() {
    //outer
    linear_extrude(height = 10)
    polygon(points=[
        [(topWidth - bottomWidth)/2,0],
        [((topWidth - bottomWidth)/2) + bottomWidth,0],
        [topWidth,depth],
        [0,depth]
    ]);
    
    //inner
    linear_extrude(height = 10)
    polygon(points=[
        [(topWidth - bottomWidth)/2 + wallThickness, 0 + wallThickness],
        [((topWidth - bottomWidth)/2) - wallThickness + bottomWidth,0 + wallThickness],
        [(topWidth) - wallThickness, depth - wallThickness],
        [0 + wallThickness,depth - wallThickness]
    ]);

    
}


