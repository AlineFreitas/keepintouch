module CollaboratorsHelper

  # Returns the Gravatar (http://gravatar.com/) for the given collaborator.
  def gravatar_for(collaborator, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(collaborator.email.downcase)
    size = options[:size]
    gravatar =
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: collaborator.name, class: "gravatar")
  end
end
