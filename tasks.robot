*** Settings ***
Documentation       Robot Framework XML examples.

Library             XML    use_lxml=True
Library             XmlTransformer.py


*** Variables ***
${XML_FILE_PATH}=       ${CURDIR}${/}robots.xml


*** Tasks ***
Parse an XML file
    ${xml}=    Parse Xml    ${XML_FILE_PATH}
    Log Element    ${xml}

Get elements from XML by XPath
    ${xml}=    Parse test XML
    ${elements}=    Get Elements    ${xml}    //robot
    FOR    ${element}    IN    @{elements}
        Log Element    ${element}
    END

Get elements from XML by element value
    ${xml}=    Parse test XML
    ${elements}=
    ...    Get Elements
    ...    ${xml}
    ...    //robot[customization-options/colors[color='gold']]
    FOR    ${element}    IN    @{elements}
        Log Element    ${element}
    END

Get elements from XML by attribute value
    ${xml}=    Parse test XML
    ${elements}=
    ...    Get Elements
    ...    ${xml}
    ...    //robot[dimensions/dimension[@type='weight' and @value>100]]
    FOR    ${element}    IN    @{elements}
        Log Element    ${element}
    END

Get element children from XML by XPath
    ${xml}=    Parse test XML
    ${elements}=    Get Child Elements    ${xml}    //robot[1]
    FOR    ${element}    IN    @{elements}
        Log Element    ${element}
    END

Access XML element object attributes
    ${xml}=    Parse test XML
    # https://docs.python.org/3/library/xml.etree.elementtree.html#element-objects
    ${element}=    Get Element    ${xml}    //robot[1]
    Log    ${element.tag}    # robot
    Log    ${element.text}
    Log    ${element.tail}
    Log    ${element.attrib}    # {'id': 'MK-I'}

Get attribute values from XML by XPath
    ${xml}=    Parse test XML
    ${attributes}=
    ...    Get Element Attributes
    ...    ${xml}
    ...    //robot[1]/dimensions/dimension[1]
    Log    ${attributes}    # {'type': 'weight', 'unit': 'kg', 'value': '160'}

Get named attribute value from XML by XPath
    ${xml}=    Parse test XML
    ${attribute}=    Get Element Attribute    ${xml}    id    //robot[1]
    Log    ${attribute}    # MK-I

Save XML to a file
    ${xml}=    Parse test XML
    Save Xml    ${xml}    ${OUTPUT_DIR}${/}saved.xml

Remove elements from XML by XPath
    ${xml}=    Parse test XML
    ${result_xml}=    Remove Elements    ${xml}    //customization-options
    Log Element    ${result_xml}

Remove element attributes from XML by XPath
    ${xml}=    Parse test XML
    Remove Elements Attributes    ${xml}    //dimension
    Log Element    ${xml}

Set XML element attribute value
    ${xml}=    Parse test XML
    ${element}=    Get Element    ${xml}    //robot[1]
    Set Element Attribute    ${element}    id    New-Value
    ${attribute}=    Get Element Attribute    ${element}    id
    Log    ${attribute}    # New-Value

Add attribute to XML element by XPath
    ${xml}=    Parse test XML
    Set Element Attribute    ${xml}    my-attribute    my-value    //robot[1]
    ${attribute}=
    ...    Get Element Attribute
    ...    ${xml}
    ...    my-attribute
    ...    //robot[1]
    Log    ${attribute}    # my-value

Transform XML using XSLT
    Transform Xml
    ...    ${XML_FILE_PATH}
    ...    ${CURDIR}${/}transform-to-humans.xsl
    ...    ${OUTPUT_DIR}${/}humans.xml


*** Keywords ***
Parse test XML
    ${xml}=    Parse Xml    ${XML_FILE_PATH}
    RETURN    ${xml}
