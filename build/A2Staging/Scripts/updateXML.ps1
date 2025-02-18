Set-Variable -name XML_TO_UPDATE -value $args[0]

[xml]$xmlDoc = New-Object System.Xml.XmlDocument

# Load the Document
$xmlDoc.Load(${XML_TO_UPDATE})

# Get a List of the Nodes that we will be updating.
$componentNodesList = $xmlDoc.GetElementsByTagName('Component')

# Verify that there are updates that actually need to be made.
if ( $componentNodesList.Count -gt 0)
{
    foreach ($componentNode in $componentNodesList)
    {
        # Create the new attribute
        $win64Attr = $xmlDoc.CreateAttribute('Win64')
        $win64Attr.Value = 'yes'
        $componentNode.Attributes.Append($win64Attr) | Out-Null
    }
    
    # Save the updated document to the filesystem.
    $xmlDoc.Save(${XML_TO_UPDATE}) 
}