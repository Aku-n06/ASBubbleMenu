Pod::Spec.new do |s|
  s.name         = "ASBubbleMenu"
  s.version      = "1.0.0"
  s.summary      = "ASBubbleMenu."

  s.description  = <<-DESC
                   ASBubbleMenu.
                   DESC

  s.homepage     = "https://github.com/scamps88/ASBubbleMenu"
  s.license      = "MIT"
  s.author             = { "Alberto Scampini" => "alberto.scampini" }
  s.source       = { :git => "https://github.com/scamps88/ASBubbleMenu.git", :tag => "1.0.0" }
  s.platform     = :ios, '7.1'
  s.source_files  = "UIConcept/ASBubbleMenu", "UIConcept/ASBubbleMenu/*.swift"
  s.resources = "UIConcept/ASBubbleMenu/*.png"
  s.framework  = 'SystemConfiguration'
  s.requires_arc = true

end
