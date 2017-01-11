/* [Die] */

// Distance between opposite sides of the die
rect_height = 10; // [10:100]

/* [Face text] */

// Font to use for the faces
text_font = "Roboto";
// Size of the text for the faces
text_size = 2.0; // [1:100]
// Depth of the text
text_depth = 0.2;
text_extrude = text_depth * 2;

// Text to use the for "1" face
1_text = "1";
// Text to use the for "2" face
2_text = "2";
// Text to use the for "3" face
3_text = "3";
// Text to use the for "4" face
4_text = "4";
// Text to use the for "5" face
5_text = "5";
// Text to use the for "6" face
6_text = "6";
// Text to use the for "7" face
7_text = "7";
// Text to use the for "8" face
8_text = "8";
// Text to use the for "9" face
9_text = "9";
// Text to use the for "10" face
10_text = "10";
// Text to use the for "11" face
11_text = "11";
// Text to use the for "12" face
12_text = "12";
// Text to use the for "13" face
13_text = "13";
// Text to use the for "14" face
14_text = "14";
// Text to use the for "15" face
15_text = "15";
// Text to use the for "16" face
16_text = "16";
// Text to use the for "17" face
17_text = "17";
// Text to use the for "18" face
18_text = "18";
// Text to use the for "19" face
19_text = "19";
// Text to use the for "20" face
20_text = "20";

PHI=(1+sqrt(5))/2;

edge_length = rect_height/PHI;
triangle_face_height = (edge_length/2) * sqrt(3);

diameter = sqrt(pow(rect_height,2) + pow(edge_length,2));
radius = diameter/2;

// https://en.wikipedia.org/wiki/Dihedral_angle
dihedral_angle = acos(-sqrt(5)/3);
side_angle = dihedral_angle/2;
fifth = 360/5;

//Taken from: http://en.wikipedia.org/wiki/Icosahedron#Cartesian_coordinates
//Specifically: http://en.wikipedia.org/w/index.php?title=Icosahedron&oldid=568753314#Cartesian_coordinates
points = [
  [0,-1,-PHI], //1
  [0,-1,PHI],  //2
  [0,1,-PHI],  //3
  [0,1,PHI],   //4
  [-1,-PHI,0], //5
  [-1,PHI,0],  //6
  [1,-PHI,0],  //7
  [1,PHI,0],   //8
  [-PHI,0,-1], //9
  [PHI,0,-1],  //10
  [-PHI,0,1],  //11
  [PHI,0,1]    //12
]*edge_length/2;

faces =[
  [1,3,11],
  [1,11,6],
  [1,6,4], // 1
  [1,4,10],
  [1,10,3],
  [3,5,7],
  [3,7,11],
  [3,5,10],
  [11,6,9],
  [11,7,9],
  [0,6,9],
  [0,6,4],
  [0,8,4],
  [10,8,4],
  [10,8,5],
  [2,8,5],
  [0,2,9],
  [0,2,8],
  [7,2,9],
  [5,2,7] // 20
];

module side_text (string, triangle_center, rotation) {
  translate(triangle_center)
  rotate(rotation)
  linear_extrude(height = text_depth)
  /*linear_extrude(1000)*/
  text(string, halign = "center", valign = "center", text_font = text_font, size = text_size);
  /*circle(0.05);*/
}



/*difference() {*/
  polyhedron_angle = atan(edge_length/rect_height);
  rotate([polyhedron_angle, 0, 0])
  polyhedron(points, faces);

  triangle_angle = 90 - side_angle + polyhedron_angle;

  tri_depth = sin(triangle_angle)*triangle_face_height;
  tri_height = tri_depth/tan(triangle_angle);

  y = tri_depth * 2/3;
  z = radius - (tri_height * 2/3);

  side_text(
    1_text,
    [0, y, z],
    [90-triangle_angle, 0, 180]
  );

  /*side_text(
    1_text,
    [0, 0 - radius + tri_depth/3, radius/3],
    [side_angle, 0, 0]
  );
  side_text(
    2_text,
    [3.5, -3.5, radius/3],
    [45,45,0]
  );
  side_text(
    8_text,
    [0, 0 - radius + tri_depth/3, -radius/3],
    [side_angle, 180, 0]
  );

  side_text(
    13_text,
    [0, 0 + radius - tri_depth/3, radius/3],
    [side_angle, 0, 180]
  );
  side_text(
    20_text,
    [0, 0 + radius - tri_depth/3, -radius/3],
    [side_angle, 180, 180]
  );*/

/*}*/
