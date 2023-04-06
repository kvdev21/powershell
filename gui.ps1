Add-Type -AssemblyName System.Windows.Forms

# Create GUI form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Application Idle Mode"
$form.Size = New-Object System.Drawing.Size(300,150)
$form.StartPosition = "CenterScreen"

# Create Start Time Label
$startTimeLabel = New-Object System.Windows.Forms.Label
$startTimeLabel.Location = New-Object System.Drawing.Point(10,20)
$startTimeLabel.Size = New-Object System.Drawing.Size(100,20)
$startTimeLabel.Text = "Start Time (HH:mm)"
$form.Controls.Add($startTimeLabel)

# Create Start Time Textbox
$startTimeTextbox = New-Object System.Windows.Forms.TextBox
$startTimeTextbox.Location = New-Object System.Drawing.Point(120,20)
$startTimeTextbox.Size = New-Object System.Drawing.Size(100,20)
$form.Controls.Add($startTimeTextbox)

# Create End Time Label
$endTimeLabel = New-Object System.Windows.Forms.Label
$endTimeLabel.Location = New-Object System.Drawing.Point(10,50)
$endTimeLabel.Size = New-Object System.Drawing.Size(100,20)
$endTimeLabel.Text = "End Time (HH:mm)"
$form.Controls.Add($endTimeLabel)

# Create End Time Textbox
$endTimeTextbox = New-Object System.Windows.Forms.TextBox
$endTimeTextbox.Location = New-Object System.Drawing.Point(120,50)
$endTimeTextbox.Size = New-Object System.Drawing.Size(100,20)
$form.Controls.Add($endTimeTextbox)

# Create Save Button
$saveButton = New-Object System.Windows.Forms.Button
$saveButton.Location = New-Object System.Drawing.Point(10,90)
$saveButton.Size = New-Object System.Drawing.Size(80,30)
$saveButton.Text = "Save"
$saveButton.Add_Click({ 
    $startTime = $startTimeTextbox.Text
    $endTime = $endTimeTextbox.Text
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\your_application_name_here.exe" -Name "Debugger" -Value "powershell.exe -nologo -command `"`while ((Get-Date).ToString('HH:mm') -ge '$startTime' -and (Get-Date).ToString('HH:mm') -le '$endTime') {Start-Sleep -Seconds 60}; Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\your_application_name_here.exe' -Name 'Debugger'`""
})
$form.Controls.Add($saveButton)

# Show form
$form.ShowDialog() | Out-Null
