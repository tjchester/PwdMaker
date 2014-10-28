Import-Module PwdMaker -Force

Describe "Get-WordFileContent" {
  
    Context "When content is returned" {

        $results = Get-WordFileContent -FromFile "..\Data\wordlist.txt"

        It "Contains the word `'admin`'" {
            $results -ccontains "admin" | Should Be $true
        }

        It "Contains the word `'engine`'" {
            $results -ccontains "engine" | Should Be $true
        }

        It "Contains the word `'zmodem`'" {
            $results -ccontains "zmodem" | Should Be $true
        }

        It "Does not contain the word `'enemy               `'" {
            $results -ccontains "enemy               " | Should Be $false
        }

        It "Contains 815 words" {
            $results.Length | Should Be 815
        }

    }
}
