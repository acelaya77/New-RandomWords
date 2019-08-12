
Function New-RandomWords {
    [cmdletbinding()]
    Param(
        [int]$count = 4,
        [int]$length = 4
    )#end Param()

    #region :: old words
    <#
    $words = $($(@"
our mission the mission of the State Center Community College
foundation is to encourage philanthropic gifts that directly
enhance the access to and quality of community education for
the students and faculty of the State Center Community College
District honor the Past affirm the present embrace the future
for nearly three decades State Center Community College foundation
representing Fresno City College Reedley College Clovis Community
College and Madera and Oakhurst Community College centers has
directly enhanced the access to a quality community college
education for thousands of students within the Central Valley
through generous contributions heartfelt community support and the
dedication of the Foundation Board members deserving students
are being given the opportunity to study learn and become our
leaders of tomorrow State Center Community College Foundation
together with our community of supporters are dedicated in
providing aid to aspiring students and helping to meet the many
needs of our campuses through scholarships mini-grants and
campus improvements in 2013 the Foundation Board set aside
millions to be used to match donor gifts of or more to establish
endowed scholarships as of today the Foundation has established
endowed scholarships for a matching total of there is still million
in matching funds available for this program in addition the
Foundation provides yearly each to Clovis Community College Fresno
City College and Reedley College to help with additional campus
needs and programs State Center Community College Foundation also
makes available grant funding opportunities to faculty through the
Mini-Grant program which encourages and supports projects and
programs directly benefiting students and classroom instruction
State Center Community College Foundation is a private non-profit
organization that is designated to receive gifts to any division
of the District from private sources such as individuals foundations
and corporations the Foundation is compliant with donor restrictions
for use of their gifts timely distribution of funds to students
judicious investment of funds reporting to the community external
auditing of all financial records and sound fiscal management the
Foundation and its Board members continue to be passionate about
making a difference in the lives of the individual students our
campuses the workforce and our Valley together we are making it
possible for students to not only improve their own lives but also
change the lives of others
"@).Replace("`r"," ").replace(",","").replace(".","") -split " ").Where({($_.length -ge $length) -and ($_ -match "\w") -and ($_ -notmatch "\d")})
    #>
    #endregion

    $words = Get-Content (Join-Path $PSScriptRoot "words.txt")
    Write-Verbose "Word count: $($words.count)"
    $randoWords = Get-Random -InputObject $words -Count $count
    $strPassword = "{0} {1}{2}" -f $((get-Culture).TextInfo.ToTitleCase($randoWords[0])),$($randoWords[1..$($randoWords.Count)] -join ' '),$(@('.','?','!','!','?','?','!') | Get-Random)    
    $password = ConvertTo-SecureString -Force -AsPlainText $strPassword
    #$password
    #$strPassword

    [PSCustomObject]@{
        AccountPassword = $password
        PlainPassword = $strPassword
    }#end PSCustomObject
}#end function New-RandomWords
