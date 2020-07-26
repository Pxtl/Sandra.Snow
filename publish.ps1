param(
    [Parameter(Position=0,mandatory=$true)][string]$message
)

& src\Snow\bin\Debug\Snow config=.\SnowSite\Snow\Snow.config
git add .
git commit -m $message
git push

pushd ..\Pxtl.github.io\
git add .
git commit -m $message
git push
popd