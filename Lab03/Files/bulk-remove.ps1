Import-Csv C:\Users\Administrator\Documents\users.csv | foreach {

    Remove-ADUser -Identity $($_.SamAccountName) -Confirm:$false

}
