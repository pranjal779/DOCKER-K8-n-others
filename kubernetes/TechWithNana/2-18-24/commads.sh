# Use the following for the data: mongo-user & mongo-password
# not for command prompt
echo -n mongouser | base64

# or

# This PowerShell commands will provide you  the equivalent of encoding the string "mongouser" to base64.
$echoedText = [System.Text.Encoding]::UTF8.GetBytes("mongouser")
$base64Text = [System.Convert]::ToBase64String($echoedText)
echo $base64Text