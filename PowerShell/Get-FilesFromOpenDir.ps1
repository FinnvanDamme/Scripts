#Variables

#URL to opendir
$url = 'https://opendir'
#part of filename to search for
$title = 'filename'
#file extension
$extension = '.exe'

#Script
$content = Invoke-WebRequest $url
$content.Links.ForEach{
    if($_.href -like "*$title*")
        {
            $SubFolder = New-Item -ItemType Directory -Force -Path $_.innerHTML
            $subsite = "$url/$($_.href)"
            $subContent = Invoke-WebRequest $subsite
            $subContent.Links.ForEach{
                if($_.href -like "*$extension")
                {
                    $path = "$SubFolder\$($_.OuterText)"
                    $DL =  "$subsite/$($_.href)"
                    Invoke-WebRequest $DL -OutFile $path
                }
            }
        }
    }
