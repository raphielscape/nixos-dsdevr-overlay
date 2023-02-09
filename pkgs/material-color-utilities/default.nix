{ stdenv
, lib
, python3Packages
}:

python3Packages.buildPythonPackage rec {
  pname = "material-color-utilities-python";
  version = "0.1.5";

  src = python3Packages.fetchPypi {
    inherit pname version;
    sha256 = "sha256-PG8C585wWViFRHve83z3b9NijHyV+iGY2BdMJpyVH64=";
  };

  propagatedBuildInputs = [
    python3Packages.pillow
    python3Packages.regex
  ];

  # No tests implemented.
  doCheck = false;

  pythonImportsCheck = [ "material_color_utilities_python" ];

  meta = with lib; {
    homepage = "https://pypi.org/project/material_color_utilities_python";
    description = "Python port of material_color_utilities used for Material You colors";
    license = licenses.asl20;
    maintainers = with maintainers; [ foo-dogsquared ];
  };
}
