Import-Module PwdMaker -Force

Describe "Get-AlphaContent" {
  
    Context "When content is returned" {

        $results = Get-AlphaContent

        foreach ($letter in "abcdefghijklmnopqrstuvwxyz".ToCharArray())
        {
            It "Contains the lowercase letter `'$letter`'" {
                $results -ccontains $letter | Should Be $true
            }

        }

        It "Has a length of 26" {
            $results.Length | Should Be 26
        }

        foreach ($letter in "ABCDEFGHIJKLMNOPQRSTUVWXYZ".ToCharArray())
        {
            It "Does not contain the uppercase letter `'$letter`'" {
                $results -ccontains $letter | Should Be $false
            }

        }
    }

}
