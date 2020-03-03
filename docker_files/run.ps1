$scriptPath = Split-Path $MyInvocation.MyCommand.Path -Parent
$scriptPath = Split-Path $scriptPath -Parent

$MainPath = $scriptPath + "\work"
Set-Location -Path $MainPath
Write-Host "Set-Location: " + $MainPath

docker rm $(docker stop $(docker ps -a -q --filter ancestor="jupyter/datascience-notebook" --format="{{.ID}}"))

$volume = $MainPath + ":" + "/home/jovyan/work"
docker run --rm -p 8888:8888 -e JUPYTER_ENABLE_LAB=yes -v $volume jupyter/datascience-notebook