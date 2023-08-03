# Create empty DF Folders with the number you need

for ($i = 1; $i -le 16; $i++) {
    $dirname = "DF$i"
    New-Item -ItemType Directory -Path $dirname
}
