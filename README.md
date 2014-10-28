# Password Maker PowerShell Module #

This is a PowerShell module to help generate random passwords for user or service accounts, websites, etc.

## Installation ##

To install this module, place the PwdMaker folder and its contents in the *modules* folder of your PowerShell *profile* folder.

On a Windows 7 or 8 computer, this path would typically be:

`C:\Users\UserName\Documents\WindowsPowerShell\Modules\

>NOTE: From a PowerShell prompt you can execute:
>
	PS> Split-Path $profile -Parent

>This will give you your PowerShell profile directory location and may still require you to manually create the *Modules* subfolder.

## Running Tests ##

If you have installed [Pester](https://github.com/pester/Pester) you can run the unit tests using:

	PS> cd $(Split-Path $profile -Parent)
	PS> cd .\Modules\PwdMaker\Tests
	PS> .\Execute-Test.ps1

## Available Cmdlets ##

	PS> Import-Module -Name PwdMaker
	PS> Get-Command -Module PwdMaker
	
	CommandType     Name                                               ModuleName
	-----------     ----                                               ----------
	Function        Format-StringCase                                  PwdMaker
	Function        Format-TranslateChars                              PwdMaker
	Function        Get-AlphaContent                                   PwdMaker
	Function        Get-AlphaNumericContent                            PwdMaker
	Function        Get-AsciiContent                                   PwdMaker
	Function        Get-FormattedPassword                              PwdMaker
	Function        Get-NumericContent                                 PwdMaker
	Function        Get-RandomPassword                                 PwdMaker
	Function        Get-WordFileContent                                PwdMaker

## Examples ##

#### Generate a 10 character password based on words ####

	PS> Get-FormattedPassword -MinimumLength 10 -MaximumLength 10 -UsingFormat Word
	prestoha

> Other available formats are **WordNumberWord**, **WordNumber**, **NumberWord**

#### Generate a 8 character password based on numbers ####

	PS> Get-FormattedPassword -MinimumLength 8 -MaximumLength 8 -UsingFormat Number
	29098972

> Other available formats are **WordNumberWord**, **WordNumber**, **NumberWord**

#### Generate a 10 character random password in upper case ####

	PS> Get-RandomPassword -Length 10 | Format-StringCase -UsingCase Upper
	VHH7150CP2

#### Generate a 8 character random password replacing characters with punctuation ####

	PS> Get-RandomPassword -Length 8 | Format-TranslateChars
	muff3y@0

> Replaces all occurrences of the characters "I", "E", "S", "L", "O", and "A" with "!", "#", "%",
"&", "*", and "@" respectively. If the UsingNumbers switch is specified then the characters are
replace with "1", "3", "5", "7", "0", "2" respectively. If the string contains other characters
outside of the ones that are to be translated, they will be left alone.

#### Generate a 8 character random password replacing characters with numbers ####

	PS> Get-RandomPassword -Length 8 | Format-TranslateChars -UsingNumbers
	52kfrqgp

> Replaces all occurrences of the characters "I", "E", "S", "L", "O", and "A" with "!", "#", "%",
"&", "*", and "@" respectively. If the UsingNumbers switch is specified then the characters are
replace with "1", "3", "5", "7", "0", "2" respectively. If the string contains other characters
outside of the ones that are to be translated, they will be left alone.

#### Generate a 15 character word password in mixed case and replacing some characters with numbers ####

	PS> Get-FormattedPassword -MinimumLength 15 -MaximumLength 15 -UsingFormat Word `
         | Format-TranslateChars -UsingNumbers | Format-StringCase -UsingCase Mixed
	T0y0t23M2172C2d

## Getting Help ##

All of the cmdlets have built-in help that can access using the Get-Help cmdlet.

- For basic help: *Get-Help [cmdlet name]*; for example, ```Get-Help Get-FormattedCommand```
- For detailed help: *Get-Help [cmdlet name] -Full*; for example ```Get-Help Get-FormattedCommand -Full```

## See Also ##

- [Microsoft Script Center](http://technet.microsoft.com/en-us/scriptcenter/bb410849.aspx)	

Copyright (c) 2014 Thomas Chester. This software is licensed under the MIT License.