Import-Module PwdMaker -Force

Describe "Get-FormattedPassword" {
  
    Context "Length is not specified" {

        $results = Get-FormattedPassword

        It "Should return a password of length 8" {
            $results.Length | Should Be 8
        }
    }

    Context "When minimum and maximum length are different" {

        $results = Get-FormattedPassword -MinimumLength 8 -MaximumLength 12

        It "Should return a password with length between the min and max" {
            ($results.Length -ge 8 -and $results.Length -le 12) | Should Be $true
        }

    }


}
