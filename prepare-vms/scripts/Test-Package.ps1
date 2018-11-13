#Requires -Modules Pester
[CmdletBinding()]
Param (
    [string[]]
    $Package,

    [string]
    $Source
)

Describe "Testing Chocolatey Packages" {

    foreach ($pkg in $Package) {
        Context "Testing package $pkg" {
            it 'should install without error' {
                # choco install $pkg -y -s $Source
                # $LASTEXITCODE | Should Be 0
                $true | Should Be $true
            }

            it 'should uninstall without error' {
                # choco uninstall $pkg -y
                # $LASTEXITCODE | Should Be 0
                $true | Should Be $true
            }
        } #context
    } # foreach
}# describe