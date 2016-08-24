unit fx_ver;

interface

var
  // status of the build:
  // 0 - release, 1 - alpha, 2 - beta, 3 - gamma, 7 - release candidate
  ver_status: integer = 2;

  // version of the above (should be 0 for release)
  ver_number: integer = 1;

  // codename of the above (should be '' for release)
  ver_codename: string = 'S';


implementation

end.
