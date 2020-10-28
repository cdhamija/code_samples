#Required Headers#
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("aw-tenant-code", "2UMDAwSrR0H3nNB5b+Vm+BNC5Qx/ipmJMzeHjdL0rE0=")
$headers.Add("Authorization", "Basic YXBwYWRtaW46a3JvZ2VyMTIz")
$headers.Add("Content-Type", "application/json")

#Smart Group Ids assigned to Chrome app #
$sglist = @(94)
#Other Smart group Ids: 75 #

#App Id for Chrome is 155 #
$appId = 155

#Empty array for list of Devices #
$devices = @()

#Get list of Devices in an Assignment Group #
foreach($sg in $sglist)
{
    $url = "https://as1428.awmdm.com/API/mdm/smartgroups/$sg/devices"
     try
    {
        $response = Invoke-RestMethod -Uri $url -Method 'GET' -Headers $headers
    }
    catch { echo "An error occured. Please try via console. "}
    $devices += $response.Devices.Id
}
echo "Devices lined for Update :"$devices

# Update Chrome app for Devices in above list #
foreach($device in $devices)
{
    $url = "https://as1428.awmdm.com/API/mam/apps/public/$appId/install"
    $body = "{`n	`"DeviceId`": $device,`n}"
    try
     {
         $response = Invoke-RestMethod -Uri $url -Method 'POST' -Headers $headers -Body $body
     }
     catch 
     {
        echo "Device not responding. Please push an udpate on device id: " $device " from console."
     }
    echo "Update pushed on Device Id: "$device
}