% generate parallel plates

clear all
close all
clc

addpath("submodules/distmesh-utilities/")

output_folder = "parallel-plates/";

scale_factors = [2, 5, 10, 20, 50, 80];
separation = 1;
side_lengths = [0.1, 0.2, 0.4, 0.6, 1.0, 2.0, 4.0, 10.0];
bottom_c = [ 1,2,3; 1,3,4 ];
top_c = [ 1,3,2; 1,4,3 ];


for i = 1 : length(scale_factors)
  folder_name = output_folder + "L" + num2str(i) + "/";

  for l = side_lengths
    p = [ 0,0,0; l,0,0; l,l,0; 0,l,0 ];
    bM = generateRectangle( p, scale_factors(i) );
    tM = translateMesh( bM, [0,0,separation] );
    tM = flipNormals( tM );
    bottom_name = "bottom-xDim=" + num2str(l) + "-yDim=" + num2str(l) + ".stl";
    top_name = "top-xDim=" + num2str(l) + "-yDim=" + num2str(l) + "-sep=" + num2str(separation) + ".stl";
  
    stlwrite(bM, folder_name + bottom_name, "binary")
    stlwrite(tM, folder_name + top_name, "binary")
  end

end