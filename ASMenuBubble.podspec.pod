Pod::Spec.new do |s|
  s.name         = "ASBubbleMenu"
  s.version      = "1.0.0"
  s.summary      = "ASBubbleMenu."

  s.description  = <<-DESC
                   ASBubbleMenu.
                   DESC

  s.homepage     = "https://github.com/scamps88/ASBubbleMenu"
  s.license      = "MIT (example)"
  s.author             = { "Alberto Scampini" => "alberto.scampini" }
  s.platform     = :ios, '7.1'
  s.source_files  = "UIConcept/ASBubbleMenu", "UIConcept/ASBubbleMenu/*.swift"
  s.resources = "UIConcept/ASBubbleMenu/*.png"
  s.requires_arc = true

end