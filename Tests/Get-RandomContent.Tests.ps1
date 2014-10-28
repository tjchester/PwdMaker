Import-Module PwdMaker -Force

<#
Describe "Get-RandomContent" {
  
    Context "When the Count parameter is specified" {

        $results = Get-RandomContent -FromArray 0,1,2,3,4,5,6,7,8,9 -Count 5

        #Write-Host "Results = " $results

        It "Returns an array containing exactly that many characters" {
            $results.Length | Should Be 5
        }
    }

    Context "When the Count parameter is not specified" {

        $results = Get-RandomContent -FromArray 0,1,2,3,4,5,6,7,8,9

        It "Returns an array containing exactly one character" {
            $results.Length | Should Be 1
        }
    }

    Context "When called with an input set of 1 item and a specified count" {
        
        $results = Get-RandomContent -FromArray "A" -Count 2

        #Write-Host "Results = " $results

        It "Should contain that item specified count times" {
            ($results[0] -ceq "A" -And $results[1] -ceq "A") | Should Be $true
        }

    }


}
#>