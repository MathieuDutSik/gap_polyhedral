FilePOLY_SerialDualDesc:=Filename(DirectoriesPackagePrograms("gap_polyhedral"),"POLY_SerialDualDesc");
FileCP_TestCopositivity:=Filename(DirectoriesPackagePrograms("gap_polyhedral"),"CP_TestCopositivity");
FileCP_TestCompletePositivity:=Filename(DirectoriesPackagePrograms("gap_polyhedral"),"CP_TestCompletePositivity");
FileLORENTZ_FundDomain_AllcockEdgewalk:=Filename(DirectoriesPackagePrograms("gap_polyhedral"),"LORENTZ_FundDomain_AllcockEdgewalk");
FilePOLY_FaceLatticeGen:=Filename(DirectoriesPackagePrograms("gap_polyhedral"),"POLY_FaceLatticeGen");
FileINDEF_FORM_AutomorphismGroup:=Filename(DirectoriesPackagePrograms("gap_polyhedral"),"INDEF_FORM_AutomorphismGroup");
FileINDEF_FORM_TestEquivalence:=Filename(DirectoriesPackagePrograms("gap_polyhedral"),"INDEF_FORM_TestEquivalence");
FileINDEF_FORM_GetOrbitRepresentative:=Filename(DirectoriesPackagePrograms("gap_polyhedral"),"INDEF_FORM_GetOrbitRepresentative");
FileINDEF_FORM_GetOrbit_IsotropicKplane:=Filename(DirectoriesPackagePrograms("gap_polyhedral"),"INDEF_FORM_GetOrbit_IsotropicKplane");
FileLATT_canonicalize:=Filename(DirectoriesPackagePrograms("gap_polyhedral"),"LATT_canonicalize");
FileLATT_FindIsotropic:=Filename(DirectoriesPackagePrograms("gap_polyhedral"),"LATT_FindIsotropic");

CPP_WriteMatrix:=function(output, eMat)
  local nbRow, nbCol, iRow, iCol;
  nbRow:=Length(eMat);
  nbCol:=Length(eMat[1]);
  AppendTo(output, nbRow, " ", nbCol, "\n");
  for iRow in [1..nbRow]
  do
    for iCol in [1..nbCol]
    do
      AppendTo(output, " ", eMat[iRow][iCol]);
    od;
    AppendTo(output, "\n");
  od;
end;

WriteMatrixFile:=function(eFile, eMat)
    local output;
    output:=OutputTextFile(eFile, true);
    CPP_WriteMatrix(output, eMat);
    CloseStream(output);
end;

ComputeIsotropicVector:=function(M)
    local FileInp, FileOut, FileErr;
    FileInp:=Filename(POLYHEDRAL_tmpdir,"Isotropic.inp");
    FileOut:=Filename(POLYHEDRAL_tmpdir,"Isotropic.out");
    FileErr:=Filename(POLYHEDRAL_tmpdir,"Isotropic.err");
    WriteMatrixFile(FileInp, M);
    #
    TheCommand:=Concatenation(FileLATT_FindIsotropic, " ", FileInp, " GAP ", FileOut, " 2> ", FileErr);
    Exec(TheCommand);
    #
    TheRec:=ReadAsFunction(FileOut)();
    RemoveFile(FileInp);
    RemoveFile(FileOut);
    RemoveFile(FileErr);
    return TheRec;
end;

ComputeCanonicalForm:=function(M)
end;
