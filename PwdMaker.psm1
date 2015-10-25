function Get-AlphaContent {
<#
.SYNOPSIS
Return an array containing the lowercase letters 'a' through 'z'.

.EXAMPLE

$a = Get-AlphaContent

.LINK
#>
    $content = $null

    For ([int]$i = 97; $i –le 122; $i++)
    {
        $content += ,[char][byte]$i
    }

    $content
}

function Get-AlphaNumericContent {
<#
.SYNOPSIS
Returns an array containing the lowercase letters 'a' through 'z' and the numbers '0' through '9'.

.EXAMPLE

$a = Get-AlphaNumericContent

.LINK
#>

    $content = $null

    For ([int]$i = 97; $i –le 122; $i++)
    {
        $content += ,[char][byte]$i
    }

    For ([int]$i = 48; $i –le 57; $i++)
    {
        $content += ,[char][byte]$i
    }

    $content

}

function Get-AsciiContent {
<#
.SYNOPSIS
Returns an array of all printable ASCII characters (excluding the space character).

.EXAMPLE

$a = Get-AsciiContent

.LINK
#>
    $content = $NULL

    For ([int]$i = 33; $i –le 126; $i++)
    {
        $content += ,[char][byte]$i
    }

    $content
}


function Get-NumericContent {
<#
.SYNOPSIS
Returns an array of numbers '0' through '9'.

.EXAMPLE

$a = Get-NumericContent

.LINK
#>
    $content = $NULL

    For ([int]$i = 48; $i –le 57; $i++)
    {
        $content += ,[char][byte]$i
    }

    $content
}

<#
function Get-RandomContent {
.SYNOPSIS
Returns an array containing a specified number of items chosen at random from an input set.

.PARAMETER FromArray
A array of strings from which a specified number will be chosen at random.

.PARAMETER Count
Specifies the number of random items the final result should contain. Defaults to 1 if unspecified.

.EXAMPLE

$a = Get-RandomContent -FromArray A,B,C,D,E,F,G -Count 5

.EXAMPLE

$a = Get-RandomContent -FromArray 0,1,2,3,4,5,6,7,8,9

.LINK


Param(
    [Parameter(Mandatory=$true,ValueFromPipeLine=$true,Position=0)]
    [array]$FromArray,

    [Parameter(Mandatory=$false,Position=1)]
    [int]$Count = 1
)

    $content = $NULL

    For ([int] $i = 1; $i -le $Count; $i++)
    {
        $content += ,(Get-Random -InputObject $FromArray).ToString()
    }

    $content
}
#>

function Get-WordFileContent {
<#
.SYNOPSIS
Returns an array of words read from a file.

.PARAMETER FromFile
The path and file name of the file containing the list of words. The file should contain one word per line.

.EXAMPLE

$a = Get-WordFileContent

.EXAMPLE

$a = Get-WordFileContent -FromFile "C:\Temp\WordList.txt"

.EXAMPLE

$a = Get-WordFileContent "C:\Temp\WordList.txt"

.LINK
#>
Param(
    [Parameter(Mandatory=$false,Position=0)]
    [string]$FromFile
)

    if ($FromFile -eq $null -or $FromFile -eq "") {
        foreach($path in $env:PSModulePath.Split(";"))
        {
            if (Test-Path -path "$path\PwdMaker\data\wordlist.txt")
            {
                $FromFile = "$path\PwdMaker\data\wordlist.txt"
            }
        }

    }

    Get-Content -Path "$FromFile" | ForEach { $_.ToString().Trim() }

}

function Format-StringCase {
<#
.SYNOPSIS
Formats a string according to all upper case, all lowe case, or a random selection of mixed case.

.PARAMETER Value
TODO

.PARAMETER UsingCase
Specifies a named key representing the desired case. Available values are "Upper", "Lower", or
"Mixed". It will default to "mixed" if left unspecified.

.EXAMPLE

$a = Format-StringCase -Value "This is a test" -UsingCase Upper

.EXAMPLE

$a = Format-StringCase -Value "THIS IS A TEST"

.LINK
#>

Param(
    [Parameter(Mandatory=$true,ValueFromPipeLine=$true,Position=0)]
    [string]$Value,

    [Parameter(Mandatory=$false)]
    [ValidateSet("Upper","Lower","Mixed")]
    [string]$UsingCase = "Mixed"
)

    switch ($UsingCase)
    {
        "Upper"
        {
            ([string]$Value).ToUpper()
        }

        "Lower" {
            ([string]$Value).ToLower()
        }

        "Mixed"
        {
            $chars = ([string]$Value).ToLower().ToCharArray()
            for ([int] $i = 0; $i -lt $chars.Length; $i = $i + 2)
            {
                $position = Get-Random -Minimum 0 -Maximum $chars.Length
                $chars[$position] = ([string]$chars[$position]).ToUpper()
            }
            -join $chars
        }
    }
}

function Format-TranslateChars {
<#
.SYNOPSIS
Replaces all occurrences of the characters "I", "E", "S", "L", "O", and "A" with "!", "#", "%",
"&", "*", and "@" respectively. If the UsingNumbers switch is specified then the characters are
replace with "1", "3", "5", "7", "0", "2" respectively. If the ReplaceHomoglyphs switch is also
specified then visually confusing characters will also be replaced. If the string contains other
characters outside of the ones that are to be translated, they will be left alone.

.PARAMETER Value
Specifies the string that needs to have the specified characters translated.

.PARAMETER UsingNumbers
Specifies that numbers should be used for the translation characters instead of punctuation characters.

.PARAMETER ReplaceHomoglphs
Homoglyphs are characters that at a quick glance can be confused because of their similarities. A
couple of examples in the English alphabet are "O" (oh) versus "0" (zero); and "1" (one) versus
"I" (eye) versus "l" (El). Specifying this switch will replace those characters with less
visually confusing ones.

.EXAMPLE

"Test" | Format-TranslateChars

T#%t

.EXAMPLE

"Test" | Format-TranslateChars -UsingNumbers

T35t

.EXAMPLE

Format-TranslateChars -Value "TeST" -ReplaceHomoglyphs

T#%t

.EXAMPLE

"Test"| Format-TranslateChars -UsingNumbers -ReplaceHomoglyphs

T35t

.LINK

[Wikipedia Article on Homoglyphs](https://en.wikipedia.org/wiki/Homoglyph)

#>

Param(
    [Parameter(Mandatory=$true,ValueFromPipeLine=$true,Position=0)]
    [string]$Value,

    [Parameter(Mandatory=$false)]
    [switch]$UsingNumbers,

    [Parameter(Mandatory=$false)]
    [switch]$ReplaceHomoglyphs
)

    if (-not $UsingNumbers)
    {
        if ($ReplaceHomoglyphs)
        {
            (((((((($Value -ireplace "I","!") `
                           -ireplace "1","^") `
                           -ireplace "L","$") `
                           -ireplace "E","#") `
                           -ireplace "S","%") `
                           -ireplace "O","*") `
                           -ireplace "0","*") `
                           -ireplace "A","@")
        }
        else
        {
            (((((($Value -ireplace "I","!") `
                         -ireplace "E","#") `
                         -ireplace "S","%") `
                         -ireplace "L","&") `
                         -ireplace "O","*") `
                         -ireplace "A","@")
        }
    }
    else
    {
      if ($ReplaceHomoglyphs)
      {
          (((((((($Value -ireplace "I","6") `
                         -ireplace "1","7") `
                         -ireplace "L","8") `
                         -ireplace "E","3") `
                         -ireplace "S","5") `
                         -ireplace "O","4") `
                         -ireplace "0","9") `
                         -ireplace "A","2")
      }
      else
      {
          (((((($Value -ireplace "I","4") `
                       -ireplace "E","3") `
                       -ireplace "S","5") `
                       -ireplace "L","7") `
                       -ireplace "O","6") `
                       -ireplace "A","2")
      }
    }
}


function Get-FormattedPassword {
<#
.SYNOPSIS
Returns a password in a specified format with a specified length.

.PARAMETER MinimumLength
Specifies the minimum number of characters the password must contain. If the minimum length
matches the maximum length then a password of exactly that length will be returned otherwise
the first password whose length is between the minimum and maximum length will be returned.

.PARAMETER MaximumLength
Specifies the maximum number of characters the password must contain. If the minimum length
matches the maximum length then a password of exactly that length will be returned otherwise
the first password whose length is between the minimum and maximum length will be returned.

.PARAMETER UsingFormat
Specifies the format that password should follow. Available formats are "Word + Number + Word",
"Number", "Word", "Word + Number", or "Number + Word". It defaults to "Word + Number + Word" if
unspecified.

.EXAMPLE

$a = Get-FormattedPassword -MinimumLength 10 -MaximumLength 10 -UsingFormat Word

.EXAMPLE

$a = Get-FormattedPassword | Format-StringCase -UsingCase Mixed | Format-TranslateChars -UsingNumbers

.LINK
#>

Param(
    [Parameter(Mandatory=$false)]
    [int]$MinimumLength = 8,

    [Parameter(Mandatory=$false)]
    [int]$MaximumLength = 8,

    [Parameter(Mandatory=$false)]
    [ValidateSet("WordNumberWord","Number","Word","WordNumber","NumberWord")]
    [string]$UsingFormat = "WordNumberWord"
)

    $content = $null

    $Word1 = ""
    $Numb1 = ""
    $Word2 = ""

    Do
    {
        if ($content.Length -ge $MinimumLength) { break; }

        switch ($UsingFormat)
        {
            "WordNumberWord"
            {
                $Word1 += Get-WordFileContent | Get-Random
                $Numb1 += (Get-NumericContent | Get-Random).ToString() + (Get-NumericContent | Get-Random).ToString()
                $Word2 += Get-WordFileContent | Get-Random
            }

            "Number"
            {
                $Numb1 += (Get-NumericContent | Get-Random).ToString() + (Get-NumericContent | Get-Random).ToString()
            }

            "Word"
            {
                $Word1 += Get-WordFileContent | Get-Random
            }

            "WordNumber"
            {
                $Word1 += Get-WordFileContent | Get-Random
                $Numb1 += (Get-NumericContent | Get-Random).ToString() + (Get-NumericContent | Get-Random).ToString()
            }

            "NumberWord"
            {
                $Numb1 += (Get-NumericContent | Get-Random).ToString() + (Get-NumericContent | Get-Random).ToString()
                $Word2 += Get-WordFileContent | Get-Random
            }
        }

        $content = $Word1 + $Numb1 + $Word2

        #Write-Host -ForegroundColor Yellow "Word1 = " $Word1
        #Write-Host -ForegroundColor Yellow "Numb1 = " $Numb1
        #Write-Host -ForegroundColor Yellow "Word2 = " $Word2

    } While ($content.Length -le $MaximumLength)


    While ($content.Length -gt $MaximumLength)
    {
        if (($Word1.Length -ge $Numb1.Length) -And ($Word1.Length -ge $Word2.Length))
        {
            $Word1 = $Word1.SubString(0, $Word1.Length - 1)
        }
        elseif (($Numb1.Length -ge $Word1.Length) -And ($Numb1.Length -ge $Word2.Length))
        {
            $Numb1 = $Numb1.SubString(0, $Numb1.Length - 1)
        }
       else
        {
            $Word2 = $Word2.SubString(0, $Word2.Length - 1)
        }

        $content = $Word1 + $Numb1 + $Word2

    }

    $content
}

function Get-RandomPassword {
<#
.SYNOPSIS
Returns a random password string from a specified input set with a specified length.

.PARAMETER Length
Specifies the number of characters the password should contain. Defaults to 8 if unspecified.

.PARAMETER FromSet
Specifies a keyword which identifies the set of a characters the password will be chosen from.
The available options are "Alpha" for alphabetic characters only, "Numeric" for numbers only,
"AlphaNumeric" for both numbers and letters, and "Ascii" for all printable ASCII characters
excluding the space character. Defaults to "AlphaNumeric" if unspecified.

.EXAMPLE

$a = Get-RandomPassword -Length 10 -FromSet "Alpha"

.EXAMPLE

$a = Get-RandomPassword

.EXAMPLE

$a = Get-RandomPassword -FromSet "Numeric"

.LINK
#>

Param(
    [Parameter(Mandatory=$false,Position=0)]
    [ValidateRange(1,50)]
    [int]$Length = 8,

    [Parameter(Mandatory=$false,Position=1)]
    [ValidateSet("Alpha","Numeric","AlphaNumeric","Ascii")]
    [string]$FromSet = "AlphaNumeric"
)

    $dataset = "AlphaNumeric"

    switch ($FromSet)
    {
        "Alpha"        { $dataset = Get-AlphaContent        }
        "Numeric"      { $dataset = Get-NumericContent      }
        "AlphaNumeric" { $dataset = Get-AlphaNumericContent }
        "Ascii"        { $dataset = Get-AsciiContent        }
    }

    For ([int]$i = 1; $i –le $Length; $i++)
    {
        $password += ($dataset | Get-Random)
    }

    $password
}
