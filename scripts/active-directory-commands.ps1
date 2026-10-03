# Enterprise Active Directory Lab - PowerShell reference
# Commands used during the project.
# Run on DC01 with appropriate administrative privileges.
# Passwords are intentionally not stored here.
# Commands that modify Active Directory are commented out by default.

Import-Module ActiveDirectory

# Users
Get-ADUser -Filter * |
    Select-Object Name, SamAccountName

Get-ADUser -Filter * -Properties Enabled |
    Select-Object Name, SamAccountName, Enabled

Get-ADUser -Filter * -Properties Enabled |
    Where-Object { $_.Enabled -eq $false } |
    Select-Object Name, SamAccountName

# Groups
Get-ADGroup -Filter * |
    Select-Object Name, GroupScope, GroupCategory

Get-ADGroupMember -Identity "GRP_Informatique" |
    Select-Object Name, SamAccountName

# Organizational Units
Get-ADOrganizationalUnit -Filter * |
    Select-Object Name, DistinguishedName

# Example used in the lab: create Lucas Test
# New-ADUser `
#     -Name "Lucas Test" `
#     -GivenName "Lucas" `
#     -Surname "Test" `
#     -SamAccountName "lucas.test" `
#     -UserPrincipalName "lucas.test@enterprise.lab" `
#     -Path "OU=Informatique,OU=Utilisateurs,DC=entreprise,DC=lab" `
#     -AccountPassword (Read-Host -AsSecureString "Temporary password") `
#     -Enabled $true `
#     -ChangePasswordAtLogon $true

# Verify account
# Get-ADUser -Identity "lucas.test" |
#     Select-Object Name, SamAccountName, Enabled, DistinguishedName

# Example used in the lab: group membership
# Add-ADGroupMember -Identity "GRP_Informatique" -Members "lucas.test"

# Get-ADGroupMember -Identity "GRP_Informatique" |
#     Select-Object Name, SamAccountName

# Export user inventory
Get-ADUser -Filter * -Properties Enabled |
    Select-Object Name, SamAccountName, Enabled |
    Export-Csv "$env:USERPROFILE\Desktop\AD_Users.csv" -NoTypeInformation -Encoding UTF8

# Security checks
Get-ADDefaultDomainPasswordPolicy

Get-NetFirewallProfile |
    Select-Object Name, Enabled
