#This file runs thru what I understand to be the build process for a c# system
# Clean up old build artifacts
Remove-Item -Recurse -Force .\bin\ -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force .\obj\ -ErrorAction SilentlyContinue

# Restore and build
dotnet clean
dotnet restore
dotnet build

# Publish (framework-dependent, single EXE)
dotnet publish -c Release -r win-x64 --self-contained true /p:PublishSingleFile=true /p:IncludeNativeLibrariesForSelfExtract=true /p:PublishTrimmed=false

# Optional: Open the publish folder
Start-Process .\bin\Release\net8.0\win-x64\publish\