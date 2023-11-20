param(
    [Parameter(Position=0,mandatory=$true)][string]$message
)

& src\Snow\bin\Debug\Snow config=.\SnowSite\Snow\Snow.config.json
git add .
git commit -m $message
git push

Push-Location ..\Pxtl.github.io\
    git add .
    git commit -m $message
    git push
Pop-Location