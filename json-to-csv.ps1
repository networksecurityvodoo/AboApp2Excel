#==========================================
# Title:  Export json to csv format
# App Download: https://play.google.com/store/apps/details?id=de.simolation.subscriptionmanager&ref=https://github.com/networksecurityvodoo/
# Author: networksecurityvodoo
# Date:   30 April 2023
#==========================================
$json = Get-Content "abos.json" | ConvertFrom-Json

# Initialize output files
$outFile = New-Item -ItemType File -Path "output.csv" -Force
$disabledFile = New-Item -ItemType File -Path "disabled-entries.csv" -Force

# Define row delimiter
$rowDelimiter = ";"

# Write header row to output files
$header = "Subscription Name${rowDelimiter}Active${rowDelimiter}Price Amount${rowDelimiter}Price Currency${rowDelimiter}Payment Method${rowDelimiter}Description${rowDelimiter}First Billing Date${rowDelimiter}Cycle Type${rowDelimiter}Cycle Duration${rowDelimiter}Cycle Rhythm"
Add-Content $outFile $header
Add-Content $disabledFile $header

# Loop through subscriptions in JSON data
foreach ($subscription in $json.subscriptions) {
    # Check if subscription is active
    if ($subscription.active) {
        # Create output string for active subscription
        $description = if ($subscription.description) { $subscription.description } else { "NULL" }
        $firstBillingDate = if ($subscription.firstBillingDate) { $subscription.firstBillingDate } else { "NULL" }
        $cycleType = if ($subscription.cycle.cycleType) { $subscription.cycle.cycleType } else { "NULL" }
        $cycleDuration = if ($subscription.cycle.cycleDuration) { $subscription.cycle.cycleDuration } else { "NULL" }
        $cycleRhythm = if ($subscription.cycle.cycleRhythm -eq 2) { "yearly" } elseif ($subscription.cycle.cycleRhythm -eq 1) { "monthly" } else { "NULL" }
        $output = "$($subscription.name)$rowDelimiter$($subscription.active)$rowDelimiter$($subscription.price.amount -replace '\.','\:')$rowDelimiter$($subscription.price.currencyCode)$rowDelimiter$($subscription.paymentMethod)$rowDelimiter$description$rowDelimiter$firstBillingDate$rowDelimiter$cycleType$rowDelimiter$cycleDuration$rowDelimiter$cycleRhythm"
        
        # Write output to file
        Add-Content $outFile $output
    }
    else {
        # Create output string for disabled subscription
        $description = if ($subscription.description) { $subscription.description } else { "NULL" }
        $firstBillingDate = if ($subscription.firstBillingDate) { $subscription.firstBillingDate } else { "NULL" }
        $cycleType = if ($subscription.cycle.cycleType) { $subscription.cycle.cycleType } else { "NULL" }
        $cycleDuration = if ($subscription.cycle.cycleDuration) { $subscription.cycle.cycleDuration } else { "NULL" }
        $cycleRhythm = if ($subscription.cycle.cycleRhythm -eq 2) { "yearly" } elseif ($subscription.cycle.cycleRhythm -eq 1) { "monthly" } else { "NULL" }
        $output = "$($subscription.name)$rowDelimiter$($subscription.active)$rowDelimiter$($subscription.price.amount -replace '\.','\:')$rowDelimiter$($subscription.price.currencyCode)$rowDelimiter$($subscription.paymentMethod)$rowDelimiter$description$rowDelimiter$firstBillingDate$rowDelimiter$cycleType$rowDelimiter$cycleDuration$rowDelimiter$cycleRhythm"
        
        # Write output to file
        Add-Content $disabledFile $output
    }
}

Write-Host "Output has been written to output.csv"
Write-Host "Disabled entries have been written to disabled-entries.csv"
