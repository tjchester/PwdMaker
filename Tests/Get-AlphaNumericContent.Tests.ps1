Import-Module PwdMaker -Force

Describe "Get-AlphaNumericContent" {
  
    Context "When content is returned" {

        $results = Get-AlphaNumericContent

        foreach ($letter in "abcdefghijklmnopqrstuvwxyz".ToCharArray())
        {
            It "Contains the lowercase letter `'$letter`'" {
                $results -ccontains $letter | Should Be $true
            }

        }

        foreach ($number in "0123456789".ToCharArray())
        {
            It "Contains the number `'$number`'" {
                $results -ccontains $number | Should Be $true
            }

        }

        It "Has a length of 36" {
            $results.Length | Should Be 36
        }

        foreach ($letter in "ABCDEFGHIJKLMNOPQRSTUVWXYZ".ToCharArray())
        {
            It "Does not contain the uppercase letter `'$letter`'" {
                $results -ccontains $letter | Should Be $false
            }

        }
    }

}
