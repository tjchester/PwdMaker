Import-Module PwdMaker -Force

Describe "Get-NumericContent" {
  
    Context "When content is returned" {

        $results = Get-NumericContent

        foreach ($number in "0123456789".ToCharArray())
        {
            It "Contains the number `'$number`'" {
                $results -ccontains $number | Should Be $true
            }

        }

        It "Has a length of 10" {
            $results.Length | Should Be 10
        }
    }

}
