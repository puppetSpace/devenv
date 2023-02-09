$envlocation = "~/.devenv";
if(-Not (Test-Path -Path $envlocation)){
    New-Item -ItemType Directory  $envlocation;
}

function DownloadFromGithub{
    wget "https://github.com/puppetSpace/terminalthemes/raw/main/Caskaydia%20Cove%20Nerd%20Font%20Complete.ttf" -Outfile "$envlocation/Caskaydia.ttf";
    wget "https://raw.githubusercontent.com/puppetSpace/terminalthemes/main/puppet.omp.json" -OutFile "$envlocation/puppet.omp.json";
}

function InstallFont{
    $font = Get-Item -Path "$envlocation/Caskaydia.ttf";
    if (-not(Test-Path "C:\Windows\Fonts\$($font.Name)")) {
        $destination = (New-Object -ComObject Shell.Application).Namespace(0x14)
        $destination.CopyHere($font,0x10)
    }
}

function SetPowershellProfile{
    if (-not(Test-Path $PROFILE)) {
        "oh-my-posh init pwsh --config $envlocation/puppet.omp.json | Invoke-Expression
        Set-Alias -Name kc -Value kubectl
        " | Out-File $PROFILE
    }
}

function InstallWinget{
    $existing = Get-AppPackage -name "Microsoft.Winget.Source"

    if($existing -ne $null){
        wget "https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle" -O $envlocation;
        Add-AppPackage -path "$envlocation/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle";
    }
}


function InstallWingetPackages{
    winget install Microsoft.WindowsTerminal
    winget install JanDeDobbeleer.OhMyPosh -s winget
    winget install Kubernetes.kubectl
}

function InstallWsl{
    wsl --install
}


DownloadFromGithub;
InstallFont;
InstallWinget
InstallWingetPackages;
SetPowershellProfile;





