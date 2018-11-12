#Requires -Modules Pester
[CmdletBinding()]
Param (
    [string[]]
    $Package
)

$source = 'https://chocolatey.org/api/v2/'

Describe "Testing Chocolatey Packages" {

    foreach ($pkg in $Package) {
        Context "Testing package $pkg" {
            it 'should install without error' {
                choco install $pkg -y -s $source
                $LASTEXITCODE | Should Be 0
            }

            it 'should uninstall without error' {
                choco uninstall $pkg -y
                $LASTEXITCODE | Should Be 0
            }
        } #context
    } # foreach
}# describe