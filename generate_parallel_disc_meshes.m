% generate parallel discs

clear all
close all
clc

addpath("submodules/distmesh-utilities/")

output_folder = "coaxial-discs/";

scale_factors = [2, 5, 10, 20, 50, 80];
offset = 1.0;
radii = [0.2, 0.8, 1.0, 2.0, 5.0, 8.0, 10.0];

for i = 5 : length(scale_factors)
  folder_name = output_folder + "L" + num2str(i) + "/";

  for j = 1 : length(radii)
    r = radii(j);

    bM = generateDisc( r, scale_factors(i) );
    tM = translateMesh( bM, [0,0,offset] );
    tM = flipNormals( tM );
    bottom_name = "bottom-r=" + num2str(r) + ".stl";
    top_name = "top-r=" + num2str(r) + "-sep=" + num2str(offset) + ".stl";
  
    stlwrite(bM, folder_name + bottom_name, "binary")
    stlwrite(tM, folder_name + top_name, "binary")
  end

end