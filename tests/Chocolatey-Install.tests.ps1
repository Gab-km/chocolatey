$here = Split-Path -Parent $MyInvocation.MyCommand.Definition
$common = Join-Path $here '_Common.ps1'
. $common

function Chocolatey-PackagesConfig {
  $script:chocolatey_packages_was_called = $true
}

Describe "When installing a package that is already installed without using the force command" {
  Initialize-Variables
  Chocolatey-Install 'testpackage'
  
  It "should call Chocolatey-NuGet" {
    $script:chocolatey_nuget_was_called.should.be($true)
  }
#todo: finish this up
}

Describe "When installing packages from a manifest" {
  Initialize-Variables

  Chocolatey-Install "TestDrive:\packages.config"

  It "should call the chocolatey packages config function" {
    $script:chocolatey_packages_was_called.should.be($true)
  }

}

Describe "When installing a package that happens to end in 'packages.config'" {
  Initialize-Variables

  Chocolatey-Install "fake.packages.config"
  
  It "should call Chocolatey NuGet as if to download the package" {
    $script:chocolatey_nuget_was_called.should.be($true)
  }

}