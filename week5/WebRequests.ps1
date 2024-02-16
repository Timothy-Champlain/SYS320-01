clear

$scraped_page = (Invoke-WebRequest -Uri http://10.0.17.36/ToBeScraped.html)

# Get a count of the links in the page
# $scraped_page.Links.count


# Display links as HTML Element
# $scraped_page.Links

# Display links as HTML Element
# $scraped_page.Links | Select-Object 'outertext','href'

$h2s=$scraped_page.ParsedHtml.body.getElementsByTagName('h2') | Select-Object 'outertext'

# $h2s

# Print innerText of every div element that has the class as "div-1"
$divs1=$scraped_page.ParsedHtml.body.getElementsByTagName("div") | where { `
$_.getAttributeNode("class").Value -ilike "div-1"} | select innerText

$divs1