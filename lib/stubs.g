BindGlobal("GAP_POLYHEDRAL_tmpdir",DirectoryTemporary());
FilePOLY_DirectSerialDualDesc:=Filename(DirectoriesPackagePrograms("gap_polyhedral"),"POLY_DirectSerialDualDesc");
FileCP_TestCopositivity:=Filename(DirectoriesPackagePrograms("gap_polyhedral"),"CP_TestCopositivity");
FileCP_TestCompletePositivity:=Filename(DirectoriesPackagePrograms("gap_polyhedral"),"CP_TestCompletePositivity");
FileLORENTZ_ReflectiveEdgewalk:=Filename(DirectoriesPackagePrograms("gap_polyhedral"),"LORENTZ_ReflectiveEdgewalk");
FilePOLY_DirectFaceLattice:=Filename(DirectoriesPackagePrograms("gap_polyhedral"),"POLY_DirectFaceLattice");
FileINDEF_FORM_AutomorphismGroup:=Filename(DirectoriesPackagePrograms("gap_polyhedral"),"INDEF_FORM_AutomorphismGroup");
FileINDEF_FORM_TestEquivalence:=Filename(DirectoriesPackagePrograms("gap_polyhedral"),"INDEF_FORM_TestEquivalence");
FileINDEF_FORM_GetOrbitRepresentative:=Filename(DirectoriesPackagePrograms("gap_polyhedral"),"INDEF_FORM_GetOrbitRepresentative");
FileINDEF_FORM_GetOrbit_IsotropicKplane:=Filename(DirectoriesPackagePrograms("gap_polyhedral"),"INDEF_FORM_GetOrbit_IsotropicKplane");
FileLATT_Canonicalize:=Filename(DirectoriesPackagePrograms("gap_polyhedral"),"LATT_Canonicalize");
FileLATT_FindIsotropic:=Filename(DirectoriesPackagePrograms("gap_polyhedral"),"LATT_FindIsotropic");
FileLATT_SerialComputeDelaunay:=Filename(DirectoriesPackagePrograms("gap_polyhedral"),"LATT_SerialComputeDelaunay");
FileLATT_SerialLattice_IsoDelaunayDomain:=Filename(DirectoriesPackagePrograms("gap_polyhedral"),"LATT_SerialLattice_IsoDelaunayDomain");

BindGlobal("CPP_WriteMatrix",function(output, eMat)
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
end);

BindGlobal("WriteMatrixFile",function(eFile, eMat)
    local output;
    output:=OutputTextFile(eFile, true);
    CPP_WriteMatrix(output, eMat);
    CloseStream(output);
end);

BindGlobal("CPP_WriteGroup",function(output, n, GRP)
  local ListGen, eGen, i, j;
  ListGen:=GeneratorsOfGroup(GRP);
  AppendTo(output, n, " ", Length(ListGen), "\n");
  for eGen in ListGen
  do
    for i in [1..n]
    do
      j:=OnPoints(i, eGen);
      if j>n then
          Error("We have j=", j, " but n=", n);
      fi;
      AppendTo(output, " ", j-1);
    od;
    AppendTo(output, "\n");
  od;
end);


BindGlobal("WriteGroupFile",function(eFile, n, GRP)
    local output;
    RemoveFileIfExist(eFile);
    output:=OutputTextFile(eFile, true);
    CPP_WriteGroup(output, n, GRP);
    CloseStream(output);
end);




BindGlobal("GenericExecutionFile",function(f_write, input, TheProg)
    local FileInp, FileOut, FileErr;
    FileInp:=Filename(GAP_POLYHEDRAL_tmpdir,"GenericExecSing.inp");
    FileOut:=Filename(GAP_POLYHEDRAL_tmpdir,"GenericExecSing.out");
    FileErr:=Filename(GAP_POLYHEDRAL_tmpdir,"GenericExecSing.err");
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
end);

BindGlobal("GenericExecutionFileFile",function(f_write1, input1, f_write2, input2, TheProg)
    local FileInp, FileOut, FileErr;
    FileIn1:=Filename(GAP_POLYHEDRAL_tmpdir,"GenericExecSing.in1");
    FileIn2:=Filename(GAP_POLYHEDRAL_tmpdir,"GenericExecSing.in2");
    FileOut:=Filename(GAP_POLYHEDRAL_tmpdir,"GenericExecSing.out");
    FileErr:=Filename(GAP_POLYHEDRAL_tmpdir,"GenericExecSing.err");
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
end);

BindGlobal("GenericExecutionFileStrInput",function(f_write, input, strInput, eProg)
    local FileInp, FileOut, FileErr;
    FileInp:=Filename(GAP_POLYHEDRAL_tmpdir,"GenericExecSing.inp");
    FileOut:=Filename(GAP_POLYHEDRAL_tmpdir,"GenericExecSing.out");
    FileErr:=Filename(GAP_POLYHEDRAL_tmpdir,"GenericExecSing.err");
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
end);

BindGlobal("GenericExecutionFileFileStr",function(f_write1, input1, f_write2, input2, strInput, TheProg)
    local FileInp, FileOut, FileErr;
    FileIn1:=Filename(GAP_POLYHEDRAL_tmpdir,"GenericExecSing.in1");
    FileIn2:=Filename(GAP_POLYHEDRAL_tmpdir,"GenericExecSing.in2");
    FileOut:=Filename(GAP_POLYHEDRAL_tmpdir,"GenericExecSing.out");
    FileErr:=Filename(GAP_POLYHEDRAL_tmpdir,"GenericExecSing.err");
    f_write1(FileIn1, input1);
    f_write2(FileIn2, input2);
    #
    TheCommand:=Concatenation(TheProg, " ", FileIn1, " ", FileIn2, " ", strInput, " GAP ", FileOut, " 2> ", FileErr);
    Exec(TheCommand);
    #
    TheRec:=ReadAsFunction(FileOut)();
    RemoveFile(FileIn1);
    RemoveFile(FileIn2);
    RemoveFile(FileOut);
    RemoveFile(FileErr);
    return TheRec;
end);


#
# The calling function
#


BindGlobal("ComputeIsotropicVector",function(M)
    local f_write, eProg;
    f_write:=function(eFile, Minp)
        WriteMatrixFile(eFile, Minp);
    end;
    eProg:=Concatenation(FileLATT_FindIsotropic, " rational");
    return GenericExecutionFile(f_write, M, eProg);
end);


BindGlobal("ComputeCanonicalForm",function(M)
    local f_write, eProg;
    f_write:=function(eFile, Minp)
        WriteMatrixFile(eFile, Minp);
    end;
    eProg:=Concatenation(FileLATT_Canonicalize, " gmp");
    return GenericExecutionFile(f_write, M, eProg);
end);


BindGlobal("TestCopositivity",function(M)
    local f_write, eProg;
    f_write:=function(eFile, Minp)
        WriteMatrixFile(eFile, Minp);
    end;
    eProg:=Concatenation(FileCP_TestCopositivity, " gmp");
    return GenericExecutionFile(f_write, M, eProg);
end);


BindGlobal("TestCompletePositivity",function(M)
    local f_write, eProg;
    f_write:=function(eFile, Minp)
        WriteMatrixFile(eFile, Minp);
    end;
    eProg:=Concatenation(FileCP_TestCompletePositivity, " gmp");
    return GenericExecutionFile(f_write, M, eProg);
end);


BindGlobal("INDEF_FORM_AutomorphismGroup",function(M)
    local f_write, eProg;
    f_write:=function(eFile, Minp)
        WriteMatrixFile(eFile, Minp);
    end;
    eProg:=Concatenation(FileINDEF_FORM_AutomorphismGroup, " gmp");
    return GenericExecutionFile(f_write, M, eProg);
end);


BindGlobal("INDEF_FORM_TestEquivalence",function(M1, M2)
    local f_write, eProg;
    f_write:=function(eFile, Minp)
        WriteMatrixFile(eFile, Minp);
    end;
    eProg:=Concatenation(FileINDEF_FORM_TestEquivalence, " gmp");
    return GenericExecutionFileFile(f_write, M1, f_write, M2, eProg);
end);


BindGlobal("INDEF_FORM_GetOrbitRepresentative",function(M, eNorm)
    local f_write, eProg;
    f_write:=function(eFile, Minp)
        WriteMatrixFile(eFile, Minp);
    end;
    eProg:=Concatenation(FileINDEF_FORM_GetOrbitRepresentative, " gmp");
    strInput:=String(eNorm);
    return GenericExecutionFileStrInput(f_write, M, strInput, eProg);
end);


BindGlobal("INDEF_FORM_GetOrbit_IsotropicKstuff",function(M, k, nature)
    local f_write, eProg;
    f_write:=function(eFile, Minp)
        WriteMatrixFile(eFile, Minp);
    end;
    eProg:=Concatenation(FileINDEF_FORM_GetOrbit_IsotropicKplane, " gmp");
    strInput:=Concatenation(String(k), " ", nature);
    return GenericExecutionFileStrInput(f_write, M, strInput, eProg);
end);


BindGlobal("INDEF_FORM_GetOrbit_IsotropicKplane",function(M, k)
    return INDEF_FORM_GetOrbit_IsotropicKstuff(M, k, "plane");
end);


BindGlobal("INDEF_FORM_GetOrbit_IsotropicKflag",function(M, k)
    return INDEF_FORM_GetOrbit_IsotropicKstuff(M, k, "flag");
end);


BindGlobal("POLY_DualDescription",function(EXT, GRP)
    local f_write, eProg;
    f_write1:=function(eFile, EXTinp)
        WriteMatrixFile(eFile, EXTinp);
    end;
    f_write2:=function(eFile, GRPinp)
        WriteGroupFile(FileGRP, GRPinp);
    end;
    eProg:=Concatenation(FilePOLY_DirectSerialDualDesc, " rational");
    return GenericExecutionFileFile(f_write1, EXT, f_write2, GRP, eProg);
end);


BindGlobal("LORENTZ_ReflectiveEdgewalk",function(M)
    local f_write, eProg;
    f_write:=function(eFile, Minp)
        WriteMatrixFile(eFile, Minp);
    end;
    eProg:=Concatenation(FileLORENTZ_ReflectiveEdgewalk, " gmp");
    return GenericExecutionFile(f_write, M, eProg);
end);


BindGlobal("POLY_FaceLattice",function(EXT, GRP, LevSearch)
    local f_write, eProg;
    f_write1:=function(eFile, EXTinp)
        WriteMatrixFile(eFile, EXTinp);
    end;
    f_write2:=function(eFile, GRPinp)
        WriteGroupFile(FileGRP, GRPinp);
    end;
    eProg:=Concatenation(FilePOLY_DirectFaceLattice, " rational");
    strInput:=String(LevSearch);
    return GenericExecutionFileFile(f_write1, EXT, f_write2, GRP, strInput, eProg);
end);
