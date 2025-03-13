% GENERATE SPHERE MESHES FOR VERIFICATION

clear all

addpath('submodules\\distmesh-utilities\\')
addpath('submodules\\distmesh-utilities\\generateSphere\\')

num_refinements = [1, 2, 3, 4, 5, 6];

inner_r = [1, 1.5, 2];
outer_r = [1.5, 2, 3];

output_folder = 'concentric-spheres\\';

for n = num_refinements

  folder_name = output_folder + "L" + num2str(n) + "/";

  for r = inner_r
    inner_mesh = generateSphere(r, n);
    stlwrite(inner_mesh, folder_name + "inner_sphere_r=" + num2str(r) + ".stl", "binary");
  end
  
  for r = outer_r
    outer_mesh = generateSphere(r, n);
    outer_mesh = flipNormals(outer_mesh);
    stlwrite(outer_mesh, folder_name + "outer_sphere_r=" + num2str(r) + ".stl", "binary");
  end

end