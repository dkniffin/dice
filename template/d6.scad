/* [Die] */

// Distance between opposite sides of the die
diameter = 10; // [10:100]
radius = diameter/2;

/* [Face text] */

// Font to use for the faces
text_font = "Roboto";
// Size of the text for the faces
text_size = 8.0; // [1:100]
// Depth of the text
text_depth = 0.2;

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

points = [
  [0,        0,        0], // 0
  [diameter, 0,        0], // 1
  [diameter, diameter, 0], // 2
  [0,        diameter, 0], // 3
  [0,        0,        diameter], // 4
  [diameter, 0,        diameter], // 5
  [diameter, diameter, diameter], // 6
  [0,        diameter, diameter] // 7
];

faces = [
  [0,1,2,3], // bottom
  [4,5,1,0], // front
  [7,6,5,4], // top
  [5,6,2,1], // right
  [6,7,3,2], // back
  [7,4,0,3]  // left
];

difference() {
  polyhedron(points, faces);

  // Top - 1
  translate([radius, radius, diameter - text_depth])
  rotate([0,0,0])
  linear_extrude(height = text_depth*2)
  text(1_text, halign = "center", valign = "center", text_font = text_font, size = text_size);

  // Front - 2
  translate([radius, 0 + text_depth, radius])
  rotate([90,0,0])
  linear_extrude(height = text_depth*2)
  text(2_text, halign = "center", valign = "center", text_font = text_font, size = text_size);

  // Right - 3
  translate([diameter - text_depth, radius, radius])
  rotate([90,0,90])
  linear_extrude(height = text_depth*2)
  text(3_text, halign = "center", valign = "center", text_font = text_font, size = text_size);

  // Left - 4
  translate([0 + text_depth, radius, radius])
  rotate([90,0,-90])
  linear_extrude(height = text_depth*2)
  text(4_text, halign = "center", valign = "center", text_font = text_font, size = text_size);

  // Back - 5
  translate([radius, diameter - text_depth, radius])
  rotate([90,0,180])
  linear_extrude(height = text_depth*2)
  text(5_text, halign = "center", valign = "center", text_font = text_font, size = text_size);

  // Bottom - 6
  translate([radius, radius, text_depth])
  rotate([180,0,0])
  linear_extrude(height = text_depth*2)
  text(6_text, halign = "center", valign = "center", text_font = text_font, size = text_size);
}
