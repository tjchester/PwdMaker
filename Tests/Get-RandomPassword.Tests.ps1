Import-Module PwdMaker -Force

Describe "Get-RandomPassword" {
  
    Context "Length is not specified" {

        $results = Get-RandomPassword

        It "Should return a password of length 8" {
            $results.Length | Should Be 8
        }
    }

}
