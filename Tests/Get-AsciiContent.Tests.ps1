Import-Module PwdMaker -Force

Describe "Get-AsciiContent" {
  
    Context "When content is returned" {

        $results = Get-AsciiContent

        foreach ($letter in "abcdefghijklmnopqrstuvwxyz".ToCharArray())
        {
            It "Contains the lowercase letter `'$letter`'" {
                $results -ccontains $letter | Should Be $true
            }

        }

        foreach ($number in "01234567890".ToCharArray())
        {
            It "Contains the number `'$number`'" {
                $results -ccontains $number | Should Be $true
            }

        }

        foreach ($letter in "ABCDEFGHIJKLMNOPQRSTUVWXYZ".ToCharArray())
        {
            It "Contains the uppercase letter `'$letter`'" {
                $results -ccontains $letter | Should Be $true
            }

        }

        foreach ($symbol in "!`"#$%&`'()*+,-./:;<=>?@[\]^_``{|}~".ToCharArray())
        {
            It "Contains the symbol `'$symbol`'" {
                $results -ccontains $symbol | Should Be $true
            }

        }

        It "Has a length of 94" {
            $results.Length | Should Be 94
        }
    }

}
