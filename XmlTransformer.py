import lxml.etree as ET


class XmlTransformer:
    def transform_xml(self, xml_file_path, xsl_file_path, output_xml_path):
        original_xml = ET.parse(xml_file_path)
        xslt = ET.parse(xsl_file_path)
        transform = ET.XSLT(xslt)
        new_xml = transform(original_xml)
        output_file = open(output_xml_path, "w")
        output_file.write(str(new_xml))
