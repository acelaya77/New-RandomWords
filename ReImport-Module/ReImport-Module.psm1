Function ReImport-Module{
[CmdletBinding()]
Param(
    [Parameter(Mandatory=$true,Position=1,ValueFromPipeline=$true)]
    $Module
)

Process{
    Remove-Module $Module -Force -ErrorAction SilentlyContinue
    Import-Module $Module
}

}#end ReImport-Module{}