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

GenericExecutionFile:=function(f_write, input, TheProg)
    local FileInp, FileOut, FileErr;
    FileInp:=Filename(POLYHEDRAL_tmpdir,"GenericExecSing.inp");
    FileOut:=Filename(POLYHEDRAL_tmpdir,"GenericExecSing.out");
    FileErr:=Filename(POLYHEDRAL_tmpdir,"GenericExecSing.err");
    f_write(FileInp, input);
    #
    TheCommand:=Concatenation(TheProg, " ", FileInp, " GAP ", FileOut, " 2> ", FileErr);
    Exec(TheCommand);
    #
    TheRec:=ReadAsFunction(FileOut)();
    RemoveFile(FileInp);
    RemoveFile(FileOut);
    RemoveFile(FileErr);
    return TheRec;
end;

GenericExecutionFileFile:=function(f_write1, input1, f_write2, input2, TheProg)
    local FileInp, FileOut, FileErr;
    FileIn1:=Filename(POLYHEDRAL_tmpdir,"GenericExecSing.in1");
    FileIn2:=Filename(POLYHEDRAL_tmpdir,"GenericExecSing.in2");
    FileOut:=Filename(POLYHEDRAL_tmpdir,"GenericExecSing.out");
    FileErr:=Filename(POLYHEDRAL_tmpdir,"GenericExecSing.err");
    f_write1(FileIn1, input1);
    f_write2(FileIn2, input2);
    #
    TheCommand:=Concatenation(TheProg, " ", FileIn1, " ", FileIn2, " GAP ", FileOut, " 2> ", FileErr);
    Exec(TheCommand);
    #
    TheRec:=ReadAsFunction(FileOut)();
    RemoveFile(FileIn1);
    RemoveFile(FileIn2);
    RemoveFile(FileOut);
    RemoveFile(FileErr);
    return TheRec;
end;

GenericExecutionFileStrInput:=function(f_write, input, strInput, eProg)
    local FileInp, FileOut, FileErr;
    FileInp:=Filename(POLYHEDRAL_tmpdir,"GenericExecSing.inp");
    FileOut:=Filename(POLYHEDRAL_tmpdir,"GenericExecSing.out");
    FileErr:=Filename(POLYHEDRAL_tmpdir,"GenericExecSing.err");
    f_write(FileInp, input);
    #
    TheCommand:=Concatenation(eProg, " ", FileInp, " ", strInput, " GAP ", FileOut, " 2> ", FileErr);
    Exec(TheCommand);
    #
    TheRec:=ReadAsFunction(FileOut)();
    RemoveFile(FileInp);
    RemoveFile(FileOut);
    RemoveFile(FileErr);
    return TheRec;
end;



#
# The calling function
#

ComputeIsotropicVector:=function(M)
    local f_write;
    f_write:=function(eFile, Minp)
        WriteMatrixFile(eFile, Minp);
    end;
    return GenericExecutionFile(f_write, M, FileLATT_FindIsotropic);
end;


ComputeCanonicalForm:=function(M)
    local f_write;
    f_write:=function(eFile, Minp)
        WriteMatrixFile(eFile, Minp);
    end;
    return GenericExecutionFile(f_write, M, FileLattCanonicalization);
end;


TestCopositivity:=function(M)
    local f_write, eProg;
    f_write:=function(eFile, Minp)
        WriteMatrixFile(eFile, Minp);
    end;
    eProg:=Concatenation(FileCP_TestCopositivity, " gmp");
    return GenericExecutionFile(f_write, M, eProg);
end;


TestCompletePositivity:=function(M)
    local f_write, eProg;
    f_write:=function(eFile, Minp)
        WriteMatrixFile(eFile, Minp);
    end;
    eProg:=Concatenation(FileCP_TestCompletePositivity, " gmp");
    return GenericExecutionFile(f_write, M, eProg);
end;


INDEF_FORM_AutomorphismGroup:=function(M)
    local f_write, eProg;
    f_write:=function(eFile, Minp)
        WriteMatrixFile(eFile, Minp);
    end;
    eProg:=Concatenation(FileINDEF_FORM_AutomorphismGroup, " gmp");
    return GenericExecutionFile(f_write, M, eProg);
end;


INDEF_FORM_TestEquivalence:=function(M1, M2)
    local f_write, eProg;
    f_write:=function(eFile, Minp)
        WriteMatrixFile(eFile, Minp);
    end;
    eProg:=Concatenation(FileINDEF_FORM_TestEquivalence, " gmp");
    return GenericExecutionFileFile(f_write, M1, f_write, M2, eProg);
end;


INDEF_FORM_GetOrbitRepresentative:=function(M, eNorm)
    local f_write, eProg;
    f_write:=function(eFile, Minp)
        WriteMatrixFile(eFile, Minp);
    end;
    eProg:=Concatenation(FileINDEF_FORM_GetOrbitRepresentative, " gmp");
    strInput:=String(eNorm);
    return GenericExecutionFileStrInput(f_write, M, strInput, eProg);
end;


INDEF_FORM_GetOrbit_IsotropicKstuff:=function(M, k, nature)
    local f_write, eProg;
    f_write:=function(eFile, Minp)
        WriteMatrixFile(eFile, Minp);
    end;
    eProg:=Concatenation(FileINDEF_FORM_GetOrbit_IsotropicKplane, " gmp");
    strInput:=Concatenation(String(eNorm), " ", nature);
    return GenericExecutionFileStrInput(f_write, M, strInput, eProg);
end;


INDEF_FORM_GetOrbit_IsotropicKplane:=function(M, k)
    return INDEF_FORM_GetOrbit_IsotropicKstuff(M, k, "plane");
end;


INDEF_FORM_GetOrbit_IsotropicKflag:=function(M, k)
    return INDEF_FORM_GetOrbit_IsotropicKstuff(M, k, "flag");
end;


