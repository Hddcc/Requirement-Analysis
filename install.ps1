param(
    [ValidateSet("codex", "claude", "custom")]
    [string]$Agent = "codex",
    [string]$Target = ""
)

$ErrorActionPreference = "Stop"
$skillName = "requirement-tech-docs"
$source = Split-Path -Parent $MyInvocation.MyCommand.Path

switch ($Agent) {
    "codex" {
        $skillsRoot = Join-Path $HOME ".codex\skills"
    }
    "claude" {
        $skillsRoot = Join-Path $HOME ".claude\skills"
    }
    "custom" {
        if ([string]::IsNullOrWhiteSpace($Target)) {
            throw "Custom installation requires -Target with the Agent skills directory."
        }
        $skillsRoot = $Target
    }
}

$destination = Join-Path $skillsRoot $skillName
New-Item -ItemType Directory -Force -Path $destination | Out-Null

$files = @("SKILL.md", "README.md", "INSTALL.md", "LICENSE", "install.ps1", "install.sh")
foreach ($file in $files) {
    Copy-Item -Force -LiteralPath (Join-Path $source $file) -Destination $destination
}

foreach ($directory in @("references", "adapters")) {
    $targetDirectory = Join-Path $destination $directory
    New-Item -ItemType Directory -Force -Path $targetDirectory | Out-Null
    Copy-Item -Recurse -Force -Path (Join-Path $source "$directory\*") -Destination $targetDirectory
}

Write-Host "Installed requirement-tech-docs to $destination"
Write-Host "Restart the $Agent session to reload installed skills."
