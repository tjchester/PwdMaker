Import-Module PwdMaker -Force

Describe "Format-StringCase" {
  
    Context "When upper case is specified" {
        $result = "abcdefghijklmnopqrstuvwxyz" | Format-StringCase -UsingCase Upper

        It "String is converted to upper case" {
            $result | Should Be "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        }
    }

    Context "When lower case is specified"  {
        $result = "ABCDEFGHIJKLMNOPQRSTUVWXYZ" | Format-StringCase -UsingCase Lower

        It "String is converted to lower case" {
            $result | Should Be "abcdefghijklmnopqrstuvwxyz"
        }
    }

    Context "When mixed case is specified" {
        $result = Format-StringCase -UsingCase Mixed "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

        It "String should not be upper or lower case" {
            $result | Should Not Be "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
            $result | Should Not Be "abcdefghijklmnopqrstuvwxyz"
        }
    }

    Context "When value is specified without using pipeline" {
        $result = Format-StringCase -Value "ABC" -UsingCase Lower

        It "It should not matter" {
            $result | Should Be "abc"
        }
    }

}
