Import-Module PwdMaker -Force

Describe "Format-TranslateChars" {
  
    Context "When UsingNumbers parameter is not specified" {
        $result = "IESLOA" | Format-TranslateChars

        It "Translates using characters" {
            $result | Should Be "!#%&*@"
        }
    }

    Context "When UsingNumbers parameter is specified" {
        $result = "IESLOA" | Format-TranslateChars -UsingNumbers

        It "Translates using numbers" {
            $result | Should Be "135702"
        }
    }

    Context "When input contains special and non-special characters" {
        $result = Format-TranslateChars "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

        It "Translates only special characters" {
            $result | Should Be "@BCD#FGH!JK&MN*PQR%TUVWXYZ0123456789"
        }
    }

    Context "When value is specified without using pipeline" {
        $result = Format-TranslateChars -Value "IESLOA"

        It "It should not matter" {
            $result | Should Be "!#%&*@"
        }
    }
}
