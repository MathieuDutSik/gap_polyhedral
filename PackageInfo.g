#############################################################################
##
##  PackageInfo.g for the package `gap_polyhedral'   Mathieu Dutour Sikiric
##

SetPackageInfo( rec(

##  This is case sensitive, use your preferred spelling.
PackageName := "GAP_POLYHEDRAL",

##  See '?Extending: Version Numbers' in GAP help for an explanation
##  of valid version numbers.
Version := "0.1.0",

##  Release date of the current version in dd/mm/yyyy format.
Date := "30/10/2024",

##  Machine readable license information (as an SPDX identifier)
License := "GPL-2.0",

SourceRepository := rec(
    Type := "git",
    URL :=  "https://github.com/MathieuDutSik/gap_polyhedral",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://github.com/MathieuDutSik/gap_polyhedral",
README_URL      := Concatenation( ~.PackageWWWHome, "/README.md" ),
PackageInfoURL  := Concatenation( ~.PackageWWWHome, "/PackageInfo.g" ),
ArchiveURL      := Concatenation( ~.SourceRepository.URL,
                                 "/releases/download/v", ~.Version,
                                 "/grape-", ~.Version ),

ArchiveFormats := ".tar.gz",

BinaryFiles := ["doc/manual.dvi","doc/manual.pdf","nauty2_8_6/nug28.pdf"],

Persons := [
  rec(
    LastName := "Dutour Sikiric",
    FirstNames := "Mathieu",
    IsAuthor := true,
    IsMaintainer := true,
    Email := "mathieu.dutour@gmail.com",
    WWWHome := "https://mathieudutsik.github.io/",
    Place := "Zagreb, Croatia",
    Institution := "MSM programming"
    )
],

Status := "accepted",

CommunicatedBy := "?",
AcceptDate := "?",

##  Here you  must provide a short abstract explaining the package content
##  in HTML format (used on the package overview Web page) and an URL
##  for a Webpage with more detailed information about the package
##  (not more than a few lines, less is ok):
##  Please, use '<span class="pkgname">GAP</span>' and
##  '<span class="pkgname">MyPKG</span>' for specifying package names.
##
AbstractHTML := "<span class=\"pkgname\">GAP_POLYHEDRAL</span> is a package for \
computing with polyhedral and quadratic forms.",

PackageDoc := rec(
  # use same as in GAP
  BookName := "GAP_POLYHEDRAL",
  ArchiveURLSubset := ["htm", "doc/manual.pdf"],
  HTMLStart := "htm/chapters.htm",
  PDFFile := "doc/manual.pdf",
  # the path to the .six file used by GAP's help system
  SixFile := "doc/manual.six",
  # a longer title of the book, this together with the book name should
  # fit on a single text line (appears with the '?books' command in GAP)
  LongTitle := "Polyhedral package for polytopes and quadratic forms",
  # Should this help book be autoloaded when GAP starts up? This should
  # usually be 'true', otherwise say 'false'.
  Autoload := true
),


##  Are there restrictions on the operating system for this package? Or does
##  the package need other packages to be available?
Dependencies := rec(
  # GAP version, use version strings for specifying exact versions,
  # prepend a '>=' for specifying a least version.
  GAP := ">=4.11",
  # list of pairs [package name, (least) version],  package name is case
  # insensitive, least version denoted with '>=' prepended to version string.
  # without these, the package will not load
  # NeededOtherPackages := [["GAPDoc", ">= 0.99"]],
  NeededOtherPackages := [],
  # without these the package will issue a warning while loading
  # SuggestedOtherPackages := [],
  SuggestedOtherPackages := [],
  # needed external conditions (programs, operating system, ...)  provide
  # just strings as text or
  # pairs [text, URL] where URL  provides further information
  # about that point.
  # (no automatic test will be done for this, do this in your
  # 'AvailabilityTest' function below)
  # ExternalConditions := []
  ExternalConditions := []
),

## Provide a test function for the availability of this package, see
## documentation of 'Declare(Auto)Package', this is the <tester> function.
## For packages which will not fully work, use 'Info(InfoWarning, 1,
## ".....")' statements. For packages containing nothing but GAP code,
## just say 'ReturnTrue' here.
## (When this is used for package loading in the future the availability
## tests of other packages, as given above, will be done automatically and
## need not be included here.)
AvailabilityTest := function()
    local binaries;
    binaries:=["INDEF_FORM_AutomorphismGroup", "LATT_Canonicalize", "POLY_FaceLatticeGen", "INDEF_FORM_GetOrbitRepresentative",    "LATT_FindIsotropic", "POLY_SerialDualDesc", "CP_TestCompletePositivity", "INDEF_FORM_GetOrbit_IsotropicKplane", "LORENTZ_FundDomain_AllcockEdgewalk", "CP_TestCopositivity", "INDEF_FORM_TestEquivalence"];
    for binary in binaries
    do
        if ExternalFilename(DirectoriesPackagePrograms("g"),binary) = fail then
            Print("The binary = ", binary, " has not been compiled\n");
            return false;
        fi;
    od;
    return true;
end,

Subtitle := "Algorithm for computing with polyhedra",

##  *Optional*, but recommended: path relative to package root to a file which
##  contains as many tests of the package functionality as sensible.
TestFile := "tst/testall.g",

##  *Optional*: Here you can list some keyword related to the topic
##  of the package.
Keywords := ["polyhedral cone", "indefinite forms", "design"]

));


