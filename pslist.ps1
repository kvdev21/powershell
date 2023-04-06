Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create a form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Idle Mode"
$form.Size = New-Object System.Drawing.Size(300,300)
$form.StartPosition = "CenterScreen"

# Create a label for the start time
$lblStartTime = New-Object System.Windows.Forms.Label
$lblStartTime.Location = New-Object System.Drawing.Point(10,20)
$lblStartTime.Size = New-Object System.Drawing.Size(100,20)
$lblStartTime.Text = "Start Time:"
$form.Controls.Add($lblStartTime)

# Create a text box for the start time
$txtStartTime = New-Object System.Windows.Forms.TextBox
$txtStartTime.Location = New-Object System.Drawing.Point(120,20)
$txtStartTime.Size = New-Object System.Drawing.Size(100,20)
$form.Controls.Add($txtStartTime)

# Create a label for the end time
$lblEndTime = New-Object System.Windows.Forms.Label
$lblEndTime.Location = New-Object System.Drawing.Point(10,50)
$lblEndTime.Size = New-Object System.Drawing.Size(100,20)
$lblEndTime.Text = "End Time:"
$form.Controls.Add($lblEndTime)

# Create a text box for the end time
$txtEndTime = New-Object System.Windows.Forms.TextBox
$txtEndTime.Location = New-Object System.Drawing.Point(120,50)
$txtEndTime.Size = New-Object System.Drawing.Size(100,20)
$form.Controls.Add($txtEndTime)

# Create a label for the process list
$lblProcessList = New-Object System.Windows.Forms.Label
$lblProcessList.Location = New-Object System.Drawing.Point(10,80)
$lblProcessList.Size = New-Object System.Drawing.Size(100,20)
$lblProcessList.Text = "Process List:"
$form.Controls.Add($lblProcessList)

# Create a dropdown list of running processes
$cboProcessList = New-Object System.Windows.Forms.ComboBox
$cboProcessList.Location = New-Object System.Drawing.Point(120,80)
$cboProcessList.Size = New-Object System.Drawing.Size(150,20)
$processes = Get-Process | Select-Object -ExpandProperty Name
$cboProcessList.Items.AddRange($processes)
$form.Controls.Add($cboProcessList)

# Create a button to save the settings and start the idle mode
$btnSave = New-Object System.Windows.Forms.Button
$btnSave.Location = New-Object System.Drawing.Point(10,120)
$btnSave.Size = New-Object System.Drawing.Size(75,23)
$btnSave.Text = "Save"
$btnSave.Add_Click({
    $startTime = $txtStartTime.Text
    $endTime = $txtEndTime.Text
    $selectedProcess = $cboProcessList.SelectedItem.ToString()
    Write-Host "StartTime $startTime..."
    Write-Host "EndTime $endTime..."
    Write-Host "Process $selectedProcess..."

    while ($true) {
        $currentTime = Get-Date -Format "HH:mm"
        if ($currentTime -ge $startTime -and $currentTime -lt $endTime) {
            $process = Get-Process -Name $selectedProcess
            $process.PriorityClass = [System.Diagnostics.ProcessPriorityClass]::Idle
             Write-Host "Going into Idle..."
        } else {
            $process = Get-Process -Name $selectedProcess
            $process.PriorityClass = [System.Diagnostics.ProcessPriorityClass]::Normal
             Write-Host "Going into Normal..."
            break
        }
        Start-Sleep -Seconds 60
    }
})
$form.Controls.Add($btnSave)

$form.ShowDialog() | Out-Null
